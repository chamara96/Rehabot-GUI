import QtQuick 2.7
import QtQuick.Controls 2.2
import "SecondsProgress.qml"


Item {
    id: root

    width: size
    height: size

    property int size: 200

    function timeChanged() {
        var date = new Date();

        var hours = date.getHours();
        var minutes = date.getMinutes();
        var seconds = date.getSeconds();

        hourLabel.text = addZero(hours) + ":" + addZero(minutes);

        secondsProgress.rotationAngle = (seconds + 1) * 6;
        secondsProgress.resetContext = seconds == 0;
        hourDisc.rotationAngle = hours * 30;
    }

    function addZero(value) {
        if(value < 10) {
            value = "0" + value;
        }

        return value;
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: timeChanged()
    }

    FontLoader {
        id: yantramanavBold
        name: "YantramanavBold"
        source: "fonts/Yantramanav/Yantramanav-Bold.ttf"
    }

    Rectangle {
        color: "#FFF"
        anchors.fill: parent
        radius: 100

        Rectangle {
            color: "#000"
            anchors.centerIn: parent
            radius: 100
            width: parent.width - 5
            height: parent.height - 5

            SecondsProgress {
                id: secondsProgress
                width: parent.width
                height: parent.height
                anchors.centerIn: parent
            }

            Rectangle {
                color: "#FFF"
                anchors.centerIn: parent
                radius: 100
                width: parent.width - 20
                height: parent.height - 20
            }

            Rectangle {
                id: hourDisc
                color: "#000"
                anchors.centerIn: parent
                radius: 100
                width: parent.width - 25
                height: parent.height - 25

                property real rotationAngle: 0

                transform: Rotation {
                    angle: hourDisc.rotationAngle
                    origin.x: (hourDisc.width / 2)
                    origin.y: hourDisc.height / 2

                    Behavior on angle {
                        SpringAnimation {
                            spring: 2
                            damping: 0.2
                            modulus: 360
                        }
                    }
                }

                Rectangle {
                    id: hourHand
                    x: 84
                    y: -1
                    color: "#FFF"
                    antialiasing: true
                    width: 2
                    height: 13
                }
            }
        }

        Text {
            id: hourLabel
            anchors.centerIn: parent
            color: "#FFF"
            text: "00:00"
            font.pointSize: 40
            font.family: yantramanavBold.name
        }
    }
}
