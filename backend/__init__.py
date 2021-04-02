from PySide2 import QtQml
# This Python file uses the following encoding: utf-8
# from .MainWindow import MainWindow
# from .ImageDisplay import ImageDisplay
from backend.MainWindow import MainWindow
from backend.ImageDisplay import ImageDisplay



def registerTypes( uri = "Player"):
    QtQml.qmlRegisterType(ImageDisplay, uri, 1, 0, "ImageDisplay" )
