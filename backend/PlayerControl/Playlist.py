
from PySide2.QtCore import QObject, Signal
import os


class Playlist(QObject):
    indexChanged = Signal(int)
    playbackModeChanged = Signal(int)
    playlistChanged = Signal()

    __index = 0
    __urls = []

    #playback modes
    sequential = 0
    repeatOne = 1
    repeatAll = 2

    def __init__(self) -> None:
        super().__init__()
        self.__playbackMode = Playlist.sequential

    def setFromList(self, _list : list, new : bool = True ) -> None:
        if new:
            self.__urls.clear()
        for _item in _list:
            self.__urls.append(_item)

        if len(self.__urls) > 0:
            self.playlistChanged.emit()
            if new: self.indexChanged.emit(self.__index)

    def setFromDir(self, _dir : str):
        urls = self.__getMediaFromDir(_dir)
        self.setFromList(urls)

    def changePlaybackMode(self):
        if self.__playbackMode == Playlist.repeatAll:
            self.__playbackMode = Playlist.sequential
        else:
            self.__playbackMode += 1
        self.playbackModeChanged.emit(self.__playbackMode)

    def setPlaybackMode(self, mode : int):
        if mode > 2 or mode < 0: 
            print("MODE NOT DEFINED")
            raise()
        else:
            self.__playbackMode = mode
            self.playbackModeChanged.emit(self.__playbackMode)

    def next(self) -> None:
        if self.__playbackMode == Playlist.repeatOne:
            self.indexChanged.emit(self.__index)
            return

        if self.__index == len(self.__urls)-1:
            if self.__playbackMode == Playlist.repeatAll:
                self.__index = 0
            else: return
        else:
            self.__index += 1
        self.indexChanged.emit(self.__index)


    def prev(self) -> None:
        if self.__playbackMode == Playlist.repeatOne:
            self.indexChanged.emit(self.__index)
            return

        if self.__index == 0:
            if self.__playbackMode == Playlist.repeatAll:
                self.__index = len(self.__urls)-1
        else:
            self.__index -= 1
        self.indexChanged.emit(self.__index)

    def goToUrl(self, link : str) -> None:
        for index, url in enumerate(self.__urls):
            if link == url:
                self.goToIndex(index)
                
    def goToIndex(self, index : int) -> None:
        self.__index = index
        self.indexChanged.emit(self.__index)

         

###GETTERS

    def index(self) -> int:
        return self.__index

    def title(self) -> str:
        return self.__urls[self.__index].split('/')[-1]

    def url(self, index = False) -> str:
        if index != False: return self.__urls[index]
        return self.__urls[self.__index]

    def playbackMode(self) -> int:
        return self.__playbackMode

    def urls(self) -> list: return self.__urls

    def __getMediaFromDir(self, __dir : str) -> list:
        if __dir == '': return []
        fileDirs = [__dir]
        filepaths = []
        while fileDirs:
            currentDir = fileDirs.pop(0)
            fileNames = os.listdir(currentDir)

            filterlist = list(filter( lambda file: self.__filterFiles(file, ['.mp3', '.mp4', '.avi']), fileNames))
            for name in filterlist:
                filepaths.append(currentDir+'/'+name)

            for file in fileNames:
                newdir = currentDir+'/'+file
                if os.path.isdir(newdir):
                    fileDirs.append(newdir)

        return filepaths

    def __filterFiles(self, file : str, filter : list):
            index = file.rfind('.')
            return file[index:] in filter