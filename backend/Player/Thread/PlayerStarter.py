from PySide2.QtCore import QObject, Signal
import time


class PlayerStarter(QObject):
    finished = Signal()

    def run(self, core) -> None:
        while 1:
            frame, val = core.get_frame()
            if val == 'eof':
                break
            elif val == 'paused' and core.get_metadata()['duration'] != None:
                break
            elif frame is None:
                time.sleep(0.01)
            else:
                break
        self.finished.emit()