# This Python file uses the following encoding: utf-8
import sys
import os
import datetime

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from PySide2.QtCore import QObject, Slot, Signal, QTimer, QUrl

import serial

#ser = serial.Serial('COM12', 9600) #/dev/ttyACM0
#ser.close()


class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        self.timerTest = QTimer()
        self.timerTest.timeout.connect(self.funStart)

        # QTimer - Run Timer
        self.timer = QTimer()

        self.timer.timeout.connect(lambda: self.setTime())
        self.timer.start(1000)

    # Signal Set Name
    # setName = Signal(str)
    # Signal Set Data
    printTime = Signal(str)
    mirrorArm = Signal(str,str)




    # Set Timer Function
    def setTime(self):
        now = datetime.datetime.now()
        formatDate = now.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        sec=now.strftime("%S")
#        print(int(sec))
        self.printTime.emit(sec)

    # Function Set Name To Label
    @Slot()
    def btnStart(self):
        nowNew = datetime.datetime.now()
        formatDateNew = nowNew.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        print("Start - ",formatDateNew)

        self.timerTest.start(50)

    def funStart(self):
#        print("Loop Start")
        if(ser.isOpen() == False):
            ser.open()
        else:
            x = str(ser.readline())
            x = x.lstrip("b")
            x = x.strip("'")
            x = x.rstrip("\\r\\n")
            y = x.split(",")
            self.mirrorArm.emit(y[0],y[1])
#           print(y[0],y[1])

    def funStop(self):
        print("Loop Stop")




    @Slot()
    def btnStop(self):
        ser.close();
        nowNew = datetime.datetime.now()
        formatDateNew = nowNew.strftime("Now is %H:%M:%S %p of %Y/%m/%d")
        print("Stop - ",formatDateNew)
        self.timerTest.stop()



if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Context
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)


#    engine.load(os.path.join(os.path.dirname(__file__), "qml/test3d.qml"))
#    engine.load(os.path.join(os.path.dirname(__file__), "qml/testComp.qml"))
#    engine.load(os.path.join(os.path.dirname(__file__), "qml/passive.qml"))
#    engine.load(os.path.join(os.path.dirname(__file__), "qml/prevew_exe.qml"))

    engine.load(os.path.join(os.path.dirname(__file__), "qml/splashScreen.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
