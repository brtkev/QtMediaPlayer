from typing import Sized, SupportsAbs
from PySide2.QtCore import QObject, SIGNAL, Slot, Signal, QPoint, QSize, Qt, Property
from PySide2.QtQuick import QQuickPaintedItem
from PySide2.QtGui import QImage, QPainter, QPixmap



class Singleton(type(QObject)):
    def __init__(cls, name, bases, dict):
        super().__init__(name, bases, dict)
        cls.instance=None

    def __call__(cls,*args,**kw):
        if cls.instance is None:
            cls.instance=super().__call__(*args, **kw)
        return cls.instance



class ImageDisplay(QQuickPaintedItem, metaclass = Singleton):



    def __init__(self, *args) -> None:
        super().__init__(*args)
        self.setRenderTarget(QQuickPaintedItem.FramebufferObject)
        self._image = QPixmap()
 
    def paint(self, painter: QPainter) -> None:
        painter.drawPixmap(self.contentsBoundingRect().toRect(), self._image)

    def updateImage(self, image : QPixmap):
        self._image = image
        self.update()



    

