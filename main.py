# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtCore import QObject, Signal, Slot

from backend import MainWindow, registerTypes



if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setOrganizationName("KBN");
    app.setOrganizationDomain("kbn");

    registerTypes()
    engine = QQmlApplicationEngine()

    #get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    engine.rootContext().setContextProperty("player", main.player)

    #load qml file
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))
    

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
