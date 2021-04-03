from PySide2.QtCore import QObject, Qt, Signal, Slot, QTimer, QThread, QUrl
from PySide2.QtWidgets import QLabel, QFileDialog
from PySide2.QtGui import QImage, QPixmap
from ffpyplayer.player import MediaPlayer
import ffpyplayer.pic as ffpic
import os
import sys

from backend.PlayerControl.Playlist import Playlist
from backend.PlayerControl.PlayerStarter import PlayerStarter

class Player(QObject):
    durationChanged = Signal(int)
    positionChanged = Signal(int)
    stateChanged = Signal(int)
    titleChanged = Signal(str)
    volumeChanged = Signal(float)
    playbackModeChanged = Signal(int)

    imageUpdate = Signal(QPixmap)
    aspectRatioChanged = Signal(float)


    _core = None
    playlist = Playlist()

    pausedStated = 0
    playingState = 1
    stoppedStated = 2

    _position = 0
    _duration = 0
    _filename = ''

    _volume = 1.0
    _mute = False
    _playbackRate = 1.0


    def __init__(self) -> None:
        super().__init__()
        self.__ff_opts = {'paused': False, 'sync' : 'video'}
        self.__timer = QTimer()
        self.__timer.timeout.connect(self.__update)
        self.__timer.setTimerType(Qt.PreciseTimer)
        self.__timer.setSingleShot(True)
        self.playlist.indexChanged.connect(lambda index : self.__startPlayer(self.playlist.url(index)))  
        self.playlist.playbackModeChanged.connect(self.playbackModeChanged.emit)
        # self.playlist.playlistChanged.connect(lambda : self.__startPlayer(self.playlist.url(0)))
        self.__playerState = Player.pausedStated
        # self.__setupPlayer()


    def __setupPlayer(self) -> None:
        #declaration of the current playing filename
        #declare of the player core
        # step 2: create a Qthread Object
        self.thread = QThread()
        # Step 3: Create a worker object
        self.worker = PlayerStarter()
        # Step 4: Move worker to the thread
        self.worker.moveToThread(self.thread)
        # Step 5: Connect signals and slots
        self.worker.finished.connect(self.durationChangedSignal)
        self.worker.finished.connect(self.positionChangedSignal)
        self.worker.finished.connect(self.__aspectRatioChangedHandle)
        self.worker.finished.connect(self.play)
        self.worker.finished.connect(lambda : self.titleChanged.emit(self.title()))
        self.worker.finished.connect(self.thread.quit)
        self.worker.finished.connect(self.worker.deleteLater)
        self.thread.finished.connect(lambda : self._core.set_volume(self._volume))
        self.thread.finished.connect(self.thread.deleteLater)
        self.thread.started.connect(lambda : self.worker.run(self._core))
        # Step 6: Start the thread
        
        

    def __startPlayer(self, filename : str, seekStart : bool = False) -> None:
        self.__timer.stop()
        self.__setupPlayer()
        self._filename = filename
        self.__setup_ffOpts(seekStart)
        self._core = MediaPlayer(self._filename, ff_opts=self.__ff_opts)
        self.thread.start()

    
    def __setup_ffOpts(self, seekStart : bool) -> None:
        self.__ff_opts['volume'] = self._volume
        self.__ff_opts['vf'] = ["setpts={}*PTS".format(1/self._playbackRate)]
        self.__ff_opts['af'] = "atempo={}".format(self._playbackRate)
        if self._playbackRate != 1: self.__ff_opts['sync'] = 'video'
        else: self.__ff_opts['sync'] = 'audio'
        if seekStart: self.__ff_opts['ss'] = self._position
        else: self.__ff_opts['ss'] = 0


                
    def __update(self, force = False) -> None:
        if force: 
            frame, val = self.__getTrueFrame()
        else:
            frame, val = self._core.get_frame()

        if val == 'eof':
            self.__timer.stop()
            self.next()
        elif frame == None:
            self.__timer.start(0.01)
        elif frame != None: # and self.__hasOutput
            self.positionChangedSignal(frame[1])
            self.imageUpdate.emit(self.__getQPixmap(frame[0]))
            self.__timer.start(val*1000)
            
    def __getQPixmap(self, image : ffpic.Image) -> QPixmap:
        data = image.to_bytearray()[0]
        w, h = image.get_size()
        img = QImage(data, w, h, QImage.Format_RGB888).copy()
        return QPixmap.fromImage(img).copy()
    
    #SETTERS


    def play(self) -> None:
        if self._core == None: return
        self._core.set_pause(False)
        self.__timer.start(0.01*1000)
        self.__playerState = Player.playingState
        self.stateChangedSignal()
        
    def pause(self) -> None:
        if self._core == None: return 
        self._core.set_pause(True)
        self.__timer.stop()
        self.__playerState = Player.pausedStated
        self.stateChangedSignal()

    @Slot()
    def stop(self) -> None:
        if self._core == None: return
        self.__timer.stop()
        self._core.set_pause(True)
        self.setPosition(0)
        self.__playerState = Player.stoppedStated
        self.stateChangedSignal()
        
        
    @Slot()
    def playPause(self) -> None:
        if self.__playerState == Player.playingState:
            self.pause()
        else:
            self.play() 

    @Slot()
    def next(self) -> None:
        self.playlist.next()

    @Slot()
    def prev(self) -> None:
        self.playlist.prev()


    @Slot(list)
    def fromUrls(self, urls):
        self.playlist.setFromList(urls)

    @Slot(str)
    def fromDir(self, dir):
        self.playlist.setFromDir(dir)

    def addMedia(self, _object : str):
        self.playlist.append(_object)
        if len(self.playlist) == 1:
            self.__startPlayer(self.playlist[self.playlist.index()])

    @Slot(int)
    @Slot(int, bool)
    def setPosition(self, pos, relative = False, by_bytes = False, accurate = False):
        if self._core == None: return    
        if type(pos) == str: pos = int(pos)
        self._core.seek(pos, relative, by_bytes, accurate)
        self.__update(True)

    @Slot()
    def changePlaybackMode(self) -> None: self.playlist.changePlaybackMode()

    @Slot(int)
    def setPlaybackMode(self, mode : int) -> None: self.playlist.setPlaybackMode(mode)

    @Slot(float)
    @Slot(float, bool)
    def setVolume(self, vol : float, relative : bool = False):
        """changes player volume

        Args:
            vol (float): new Volumen
            relative (bool, optional): if true vol an add/sub of last volumen. Defaults to False.
        """
        if relative: 
            vol = self._volume + vol
            if vol > 1.0:
                vol = 1.0
            elif vol < 0:
                vol = 0

        self._volume = vol
        self.volumeChanged.emit(vol)
        if self._mute: self._mute = False
        if self._core != None: self._core.set_volume(vol)

    @Slot(float)
    def setPlaybackRate(self, rate : float) -> None:
        self._playbackRate = rate
        if self._core != None:
            self.__startPlayer(self._filename, True)

    @Slot(result=bool)
    def mute(self):
        if self._mute :
            if self._core != None: self._core.set_volume(self._volume)
            self._mute = False
            self.volumeChanged.emit(self._volume)
        else:
            if self._core != None: self._core.set_volume(0)
            self.volumeChanged.emit(0)
            self._mute = True

        return self._mute

    @Slot()
    def openFiles(self):
        desktop = os.path.normpath(os.path.expanduser("~/Desktop"))
        filter = "media(*.avi *.mp3 *.mp4  *.mkv)"
        urls, filter = QFileDialog.getOpenFileNames(None, "Abrir Video", desktop, filter)
        #si el archivo existe
        if urls:
            self.setPlaylist(urls)



    #GETTERS

    def metadata(self) -> dict: return self._core.get_metadata()
    
    @Slot(result=int)
    def state(self) -> int: return self.__playerState

    def position(self) -> int: return self._position

    def duration(self) -> int: return self._duration

    def title(self) -> str: return self.playlist.title()

    @Slot(result=int)
    def playbackMode(self) -> int: return self.playlist.playbackMode()

    def volume(self) -> int:
        if self._core == None:
            return self._volume * 100
        return self._core.get_volume() * 100

    def playbackRate(self) -> float: return self._playbackRate


    #SIGNALS
    def durationChangedSignal(self) -> None:
        self._duration = self._core.get_metadata()['duration']
        self.durationChanged.emit(self._duration)

    def positionChangedSignal(self, pos : int = 0) -> None:
        pos = pos*self._playbackRate
        # if int(pos) != int(self._position):
        self._position = pos
        self.positionChanged.emit(pos)

    def stateChangedSignal(self,) -> None:
        self.stateChanged.emit(self.__playerState)

    def __aspectRatioChangedHandle(self):
        w, h = self.metadata()['src_vid_size']
        self.aspectRatioChanged.emit(w/h)

    def __getTrueFrame(self):
        if not self._core.get_pause(): return self._core.get_frame(True)
        v = self._core.get_volume()
        self._core.set_volume(0)
        self._core.set_pause(False)
        count = 0
        while 1:
            frame, val = self._core.get_frame()
            if val == 'eof':
                return
            elif frame is not None:
                if int(frame[1]) != int(self._position):
                    if count > 1:
                        self._core.set_pause(True)
                        self._core.set_volume(v)
                        return [frame, val]
                    count += 1
    

