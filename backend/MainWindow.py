# This Python file uses the following encoding: utf-8
from PySide2.QtCore import QObject, Signal, Slot, Property, Qt
from PySide2.QtGui import QImage, QColor
import ffpyplayer.pic as ffpic


from .Player import Player
from .ImageDisplay import ImageDisplay

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.player = Player()


    @Slot()
    def startBackend(self):
        self.setupPlayer()


    def setupPlayer(self):
        self.imageDisplay = ImageDisplay()  
        self.player.imageUpdate.connect(self.imageDisplay.updateImage)
        self.player.stateChanged.connect(self.stateChangedHandler)
        # self.player.setPlaylist(["snkfinal-12.mp4"])

    def stateChangedHandler(self, state):
        if state == Player.stoppedStated:
            self.imageDisplay.setFillColor(QColor("#2c313c"))
    

