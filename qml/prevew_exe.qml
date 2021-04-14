import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Window{
    id: popScreen
    visible: true
    width: 600
    height: 450

//    title: qsTr("Hello, " + idPatient)
    color: "#a1a1a1"

    Image {
        id: imgShoulderPopMax
        x: 306
        y: 181
        width: 103
        height: 116
        source: "../images/shoulder-2.jpg"
        transformOrigin: Item.Top
        rotation: 40
        fillMode: Image.PreserveAspectFit
        Image {
            id: imgElbowPopMax
            x: -14
            y: 82
            width: 140
            height: 142
            source: "../images/elbow-1.png"
            transformOrigin: Item.Top
            rotation: 30
            fillMode: Image.PreserveAspectFit
        }

    }

    GroupBox {
        id: groupShoulder
        width: 110
        height: 95
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
        font.pointSize: 14
        title: qsTr("Shoulder")

        Label {
            id: label
            width: 50
            height: 19
            text: qsTr("Max")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            font.pointSize: 10
        }

        Label {
            id: label1
            width: 50
            height: 19
            text: qsTr("Min")
            anchors.left: parent.left
            anchors.top: label.bottom
            anchors.leftMargin: 0
            anchors.topMargin: 10
            font.pointSize: 10
        }

        Label {
            id: labelSMax
            text: qsTr("90")
            anchors.left: label.right
            anchors.top: parent.top
            font.bold: true
            anchors.leftMargin: 10
            anchors.topMargin: 0
            font.pointSize: 10
        }

        Label {
            id: labelSMin
            text: qsTr("0")
            anchors.left: label1.right
            anchors.top: labelSMax.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 10
            font.bold: true
            font.pointSize: 10
        }
    }

    GroupBox {
        id: groupElbow
        width: 110
        height: 95
        anchors.left: parent.left
        anchors.top: groupShoulder.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 30
        Label {
            id: label4
            width: 50
            height: 19
            text: qsTr("Max")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            font.pointSize: 10
        }

        Label {
            id: label5
            width: 50
            height: 19
            text: qsTr("Min")
            anchors.left: parent.left
            anchors.top: label4.bottom
            anchors.leftMargin: 0
            anchors.topMargin: 10
            font.pointSize: 10
        }

        Label {
            id: labelEMax
            text: qsTr("90")
            anchors.left: label4.right
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 0
            font.bold: true
            font.pointSize: 10
        }

        Label {
            id: labelEMin
            text: qsTr("0")
            anchors.left: label5.right
            anchors.top: labelEMax.bottom
            anchors.topMargin: 10
            anchors.leftMargin: 10
            font.bold: true
            font.pointSize: 10
        }
        title: qsTr("Elbow")
        font.pointSize: 14
    }

    Label {
        id: labelExName
        x: 287
        text: qsTr("Name")
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.underline: true
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
        font.pointSize: 20
        anchors.topMargin: 20
    }


}
