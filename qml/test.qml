import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15


Window {
    id: splashScreen
    visible: true
    width: 400
    height: 400

    //    flags: Qt.Window | Qt.FramelessWindowHint // Uncomment this for FulScreen with out Border
    //    visibility: Window.FullScreen

    title: qsTr("Hello, ")
    color: "#a1a1a1"


    Label {
        id: label1
        x: 55
        y: 330
        opacity: 1
        color: "#ffffff"
        text: qsTr("Your Doctor ")
        anchors.verticalCenter: label.verticalCenter
        anchors.verticalCenterOffset: 22
        font.family: "Segoe UI"
        anchors.bottomMargin: 20
        anchors.horizontalCenterOffset: -163
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 10
    }

    Label {
        id: label
        x: 100
        y: 294
        opacity: 1
        color: "#ffffff"
        text: qsTr("Hello ")
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -176
        anchors.horizontalCenterOffset: -164
        font.family: "Segoe UI"
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 16
    }

    Rectangle {
        id: rectangle
        x: 100
        y: 284
        width: 200
        height: 50
        color: "#ffffff"
        transformOrigin: Item.Center
        rotation: 0
        //transform: Rotation { origin.x: 25; origin.y: 25; angle: 45}
    }


    Connections{
        target: backend

        function onPrintTime(name){
            //                console.log(name)
            //            imgShoulder.rotation = -parseInt(name)
            imgElbow.rotation= 2*parseInt(name)
        }
    }

    Button {
        id: buttonPlay
        y: 342
        text: qsTr("Play")
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        onClicked: {
            backend.btnStart()
        }
    }

    Button {
        id: buttonStop
        x: 263
        y: 342
        text: qsTr("Stop")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 20
        anchors.bottomMargin: 20
        onClicked: {
            backend.btnStop()
        }
    }



    Rectangle {
        id: rectangle1
        x: 59
        y: 198
        width: 80
        height: 80
        color: "#ffffff"
        baselineOffset: 0
        z: 0
        rotation: 0
        transformOrigin: Item.Bottom
        //        transform: Rotation { origin.x: 100; origin.y: 100; angle: 45}
    }

    Image {
        id: imgShoulder
        x: 204
        y: 9
        width: 144
        height: 189
        source: "../images/shoulder-2.jpg"
        rotation: 0
        transformOrigin: Item.Top
        fillMode: Image.PreserveAspectFit

        Image {
            id: imgElbow
            x: -6
            y: 139
            width: 169
            height: 214
            source: "../images/elbow-1.png"
            rotation: 90
            transformOrigin: Item.Top
            fillMode: Image.PreserveAspectFit
        }
    }



}


