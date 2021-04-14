import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "components"
import QtQuick.Timeline 1.0

Window {
    id: splashScreen
    width: 380
    height: 580
    visible: true
    color: "#00000000"
    title: qsTr("Hello World")

    // Remove Title Bar
    flags: Qt.SplashScreen | Qt.FramelessWindowHint

    function request(url, callback) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = (function(myxhr) {
                return function() {
                    if(myxhr.readyState === 4) callback(myxhr);
                }
            })(xhr);
            xhr.open('GET', url, true);
            xhr.send('');
        }


    // Internal Functions
    QtObject{
        id: internal

        function checkLogin(idPatient, idDoctor, mode){
//            console.log(idPatient)
//            console.log(idDoctor)
//            console.log(mode)
//            if(username === "wanderson" || password === "123456"){
                var component = Qt.createComponent("passive.qml")
                var win = component.createObject()
                win.idPatient = idPatient
                win.idDoctor = idDoctor
                win.mode = mode
                win.show()
                visible = false
//            }
        }
    }

    //// Properties
    // property int timeInterval: 3000
    //
    // Timer{
    //     id: timer
    //     interval: timeInterval
    //     running: true
    //     repeat: false
    //     onTriggered: {
    //         var component = Qt.createComponent("main.qml")
    //         var win = component.createObject()
    //         win.username = "No name"
    //         win.password = "No password"
    //         win.show()
    //         visible = false
    //     }
    // }

    Rectangle {
        id: bg
        x: 78
        y: 131
        width: 360
        height: 560
        color: "#151515"
        radius: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        z: 1

        CircularProgressBar {
            id: circularProgressBar
            x: 55
            y: 198
            opacity: 0
            anchors.verticalCenter: parent.verticalCenter
            value: 100
            progressWidth: 8
            strokeBgWidth: 4
            progressColor: "#67aa25"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            id: logoImage
            x: 85
            width: 250
            height: 250
            opacity: 1
            anchors.top: parent.top
            source: "../images/logo-squre.png"
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }




//        CustomTextField {
//            id: dropdownPatient
//            x: 30
//            y: 365
//            opacity: 1
//            anchors.bottom: dropdownDoctor.top
//            anchors.bottomMargin: 10
//            anchors.horizontalCenter: parent.horizontalCenter
//            placeholderText: "Username or email"
//        }

        CustomComboField {
            id: dropdownPatient
            x: 30
            y: 365
            opacity: 1
            anchors.bottom: label3.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
//            placeholderText: "Username or email"
            colorMouseOver: "#808da7"
            colorOnFocus: "#8392b3"
            colorDefault: "#adbee1"
            displayText: ""
            flat: true
            currentIndex: -1
            width: 300
            height: 40
            editable: true
            textRole: "key"
            valueRole:"value"
            model: ListModel {
                id:modelPatient
            }

            Component.onCompleted: {
                request('https://rehabot.chamara.cc/patlist', function (o) {
                    var arrnew = eval('new Object(' + o.responseText + ')');
                    for(var i = 0; i < arrnew.length; i++) {
                        modelPatient.append({value: arrnew[i].id, key: arrnew[i].nic + " - " + arrnew[i].f_name});
                        }
                 });
            }

            onAccepted: {
                if (find(editText) === -1)
                    modelPatient.append({text: editText})
                    currentIndex = dropdownDoctor.find(editText)
            }
        }


        CustomComboField {
            id: dropdownDoctor
            x: 30
            y: 160
            opacity: 1
            anchors.bottom: btnPassive.top
            colorMouseOver: "#808da7"
            colorOnFocus: "#8392b3"
            colorDefault: "#adbee1"
//            displayText: "Size: " + currentText
            flat: true
            currentIndex: -1
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 40
            editable: true
            textRole: "key"
            valueRole:"value"
            model: ListModel {
                id: modelDoctor
            }
            Component.onCompleted: {
                request('https://rehabot.chamara.cc/doclist', function (o) {
                    var arrnew = eval('new Object(' + o.responseText + ')');
                    for(var i = 0; i < arrnew.length; i++) {
                        modelDoctor.append({value: arrnew[i].id, key: arrnew[i].reg_no + " - " + arrnew[i].f_name});
                        }
                 });
            }
            onAccepted: {
                if (find(editText) === -1)
                    modelDoctor.append({text: editText})
                    currentIndex = dropdownDoctor.find(editText)
            }
        }

        CustomButton {
            id: btnPassive
            x: 30
            y: 469
            width: 300
            height: 40
            opacity: 0
            visible: true
            text: "Passive"
            anchors.bottom: btnActive.top
            font.pointSize: 10
            font.family: "Segoe UI"
            colorPressed: "#558b1f"
            colorMouseOver: "#7ece2d"
            colorDefault: "#67aa25"
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: internal.checkLogin(dropdownPatient.currentValue, dropdownDoctor.currentValue,'Passive')
        }

        Label {
            id: label1
            x: 55
            y: 260
            opacity: 1
            color: "#ffffff"
            text: qsTr("Select Patient and Doctor")
            anchors.bottom: dropdownPatient.top
            anchors.bottomMargin: 33
            anchors.horizontalCenterOffset: 0
            font.family: "Segoe UI"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 10
        }

        Label {
            id: label
            x: 100
            y: 222
            opacity: 1
            color: "#ffffff"
            text: qsTr("Final Year Project")
            anchors.bottom: label1.top
            anchors.horizontalCenterOffset: 0
            anchors.bottomMargin: 0
            font.family: "Segoe UI"
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CustomButton {
            id: btnClose
            x: 20
            width: 30
            height: 30
            opacity: 1
            text: "X"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.rightMargin: 15
            colorPressed: "#558b1f"
            font.family: "Segoe UI"
            colorMouseOver: "#7ece2d"
            colorDefault: "#67aa25"
            font.pointSize: 10
            onClicked: splashScreen.close()
        }

        CustomButton {
            id: btnActive
            x: 20
            y: 475
            width: 300
            height: 40
            opacity: 0
            visible: true
            text: "Active"
            anchors.bottom: btnAssistive.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
            colorPressed: "#558b1f"
            font.family: "Segoe UI"
            font.pointSize: 10
            colorMouseOver: "#7ece2d"
            colorDefault: "#67aa25"
            onClicked: internal.checkLogin(dropdownPatient.currentText, dropdownDoctor.currentText,"Active")
        }

        CustomButton {
            id: btnAssistive
            x: 26
            y: 478
            width: 300
            height: 40
            opacity: 0
            visible: true
            text: "Assistive"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
            colorPressed: "#558b1f"
            font.family: "Segoe UI"
            font.pointSize: 10
            colorDefault: "#67aa25"
            colorMouseOver: "#7ece2d"
            onClicked: internal.checkLogin(dropdownPatient.currentText, dropdownDoctor.currentText,'Assistive')
        }

        Label {
            id: label2
            y: 286
            width: 81
            height: 13
            color: "#ffffff"
            text: qsTr("Patient")
            anchors.left: dropdownPatient.left
            anchors.bottom: dropdownPatient.top
            anchors.leftMargin: 0
            anchors.bottomMargin: 5
        }

        Label {
            id: label3
            y: 348
            width: 81
            height: 13
            color: "#ffffff"
            text: qsTr("Doctor")
            anchors.left: dropdownDoctor.left
            anchors.bottom: dropdownDoctor.top
            anchors.leftMargin: 0
            anchors.bottomMargin: 5
        }

    }

    DropShadow{
        anchors.fill: bg
        source: bg
        verticalOffset: 0
        horizontalOffset: 0
        radius: 10
        color: "#40000000"
        z: 0
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                duration: 3000
                running: true
                loops: 1
                to: 3000
                from: 0
            }
        ]
        enabled: true
        startFrame: 0
        endFrame: 3000

        KeyframeGroup {
            target: circularProgressBar
            property: "value"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 1300
                value: 100
            }
        }

        KeyframeGroup {
            target: circularProgressBar
            property: "opacity"
            Keyframe {
                frame: 1301
                value: 1
            }

            Keyframe {
                frame: 1800
                value: 0
            }

            Keyframe {
                frame: 0
                value: 1
            }
        }

        KeyframeGroup {
            target: logoImage
            property: "opacity"
            Keyframe {
                frame: 1801
                value: 0
            }

            Keyframe {
                frame: 2300
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label
            property: "opacity"
            Keyframe {
                frame: 1899
                value: 0
            }

            Keyframe {
                frame: 2396
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label1
            property: "opacity"
            Keyframe {
                frame: 1996
                value: 0
            }

            Keyframe {
                frame: 2504
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: dropdownPatient
            property: "opacity"
            Keyframe {
                frame: 2097
                value: 0
            }

            Keyframe {
                frame: 2652
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: dropdownDoctor
            property: "opacity"
            Keyframe {
                frame: 2198
                value: 0
            }

            Keyframe {
                frame: 2796
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label2
            property: "opacity"
            Keyframe {
                frame: 2097
                value: 0
            }

            Keyframe {
                frame: 2652
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: label3
            property: "opacity"
            Keyframe {
                frame: 2198
                value: 0
            }

            Keyframe {
                frame: 2796
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }


        KeyframeGroup {
            target: btnPassive
            property: "opacity"
            Keyframe {
                frame: 2298
                value: 0
            }

            Keyframe {
                frame: 2951
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: btnActive
            property: "opacity"
            Keyframe {
                frame: 2398
                value: 0
            }

            Keyframe {
                frame: 2951
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: btnAssistive
            property: "opacity"
            Keyframe {
                frame: 2498
                value: 0
            }

            Keyframe {
                frame: 2951
                value: 1
            }

            Keyframe {
                frame: 0
                value: 0
            }
        }

        KeyframeGroup {
            target: bg
            property: "height"
            Keyframe {
                frame: 1301
                value: 360
            }

            Keyframe {
                easing.bezierCurve: [0.221,-0.00103,0.222,0.997,1,1]
                frame: 1899
                value: 560
            }

            Keyframe {
                frame: 0
                value: 360
            }
        }
    }
}
