import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

import QtGraphicalEffects 1.15 //for slider
//import QtQuick.Extras 1.4   // for gauge meter

Window {
    id: splashScreen
    visible: true
    width: Screen.width
    height: Screen.height

    flags: Qt.Window | Qt.FramelessWindowHint // Uncomment this for FulScreen with out Border
    visibility: Window.FullScreen

    title: qsTr("Hello, " + idPatient)
    color: "#a1a1a1"

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

    onIdPatientChanged: {
        var myurl='https://rehabot.chamara.cc/patdetails?pat_id='+idPatient;
        request(myurl, function (o) {
            var objPatient = eval('new Object(' + o.responseText + ')');
            console.log(o.responseText);
            cus_name.propertyvalue=objPatient.f_name+" "+objPatient.l_name;
            cus_nic.propertyvalue=objPatient.nic;
            cus_dob.propertyvalue=objPatient.dof;
            cus_address.propertyvalue=objPatient.address;
            cus_contact.propertyvalue=objPatient.contact_no;
            image1.source="https://rehabot.chamara.cc/storage/images/patient/"+objPatient.photo;
         });
    }

    // Custom Properties
    property string idPatient
    property string idDoctor
    property string mode



    property bool btnClick:false


    //    ==================================
    property int count:parseInt(tumbler.currentIndex*60 )
    property int countInit:parseInt(tumbler.currentIndex*60 )

    function checkTimer(){
        if (count == 1 || count <= 0){
            console.log("Timer Have to stop")
            timerClock.running=false
            timerClock.stop()
        }

        count -= 1
    }

    function setCount(val){
        count=val
    }

    //extra zeros in string ( if needed)
    function extraZeros(time){
        return (time < 10 ? "0" : "") + time
    }

    //transformation miliseconds to string representing time in hh:mm:ss:z format (00:00:00.0), 0.1 decimal precision ( cDCombinedTime text)
    function getTimeString(sTime){
        return  extraZeros(Math.floor((sTime)/60)) + ":" + //minutes
                extraZeros(Math.floor((sTime%60))) //seconds
    }
    //    ==================================

    Label {
        id: txtMode
        x: 194
        color: "#ffffff"
        text: "Mode"
        anchors.top: parent.top
        anchors.horizontalCenterOffset: 330
        anchors.topMargin: 90
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 20
    }

    Rectangle {
        id: rectangle
        y: 26
        height: 125
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0

//        Image {
//            id: image
//            x: 0
//            y: 26
//            height: 150
//            horizontalAlignment: Image.AlignLeft
//            source: "../images/logo-banner.png"
//            sourceSize.height: 150
//            fillMode: Image.PreserveAspectFit
//        }
    }


    Rectangle {
        id: leftBar
        width: 275
        color: "#313131"
        border.width: 2
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 165
        anchors.bottomMargin: 15
        anchors.leftMargin: 15

        Image {
            id: image1
            width: 200
            height: 200
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
//            source: "../images/DSC_0177.jpg"
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
        }

        CustomDetailsField{
            id: cus_name
            propertyname: "Name"
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: image1.bottom
//            propertyvalue: idPatient
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.topMargin: 10

        }

        CustomDetailsField {
            id: cus_nic
            //            y: 266
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: cus_name.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            propertyname: "NIC"
        }

        CustomDetailsField {
            id: cus_dob
            //            y: 327
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: cus_nic.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            propertyname: "DOB"
        }

        CustomDetailsField {
            id: cus_address
            //            y: 394
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: cus_dob.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            propertyname: "Address"
        }

        CustomDetailsField {
            id: cus_contact
//            y: 460
            height: 40
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: cus_address.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            propertyname: "Contact"
        }


    }

    Button {
        id: button
        x: 962
        y: 15
        text: qsTr("Exit")
        onClicked: Qt.quit()
    }

    Rectangle {

        id: rightBar
        width: 275
        color: "#313131"
        border.width: 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 15
        anchors.bottomMargin: 15
        anchors.topMargin: 15


        Label {
            id: label
            x: -18
            y: 15
            width: 260
            height: 54
            color: "#ffffff"
            text: qsTr("Passive Mode")
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.family: "Verdana"
            font.pointSize: 25
        }

        GroupBox {
            id: groupBoxEx
            x: 15
            y: 80
            width: 245
            height: 215
            font.pointSize: 12
            title: "<font color='white'>Select Exercise</font>"

            ComboBox {
                id: comboBox
                x: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                textRole: "key"
                valueRole:"value"
                model: ListModel {
                    id: modelExercise
                }
                Component.onCompleted: {
                    request('https://rehabot.chamara.cc/exelist', function (o) {
                        var arrExercise = eval('new Object(' + o.responseText + ')');
                        for(var i = 0; i < arrExercise.length; i++) {
                            modelExercise.append({value: arrExercise[i].id, key: arrExercise[i].name });
                            }
                     });
                }
                onActivated: label2.text=comboBox.currentText
            }

            Button {
                id: button1
                y: 142
                height: 40
                text: qsTr("Preview")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: label2.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                font.bold: true
                font.pointSize: 12
                onClicked: {
                    request('https://rehabot.chamara.cc/exedetails?exe_id='+comboBox.currentValue, function (o) {
                        var arrExerciseDetails = eval('new Object(' + o.responseText + ')');
//                        imgShoulderPopMin.rotation=arrExerciseDetails.s_min
//                        imgShoulderPopMax.rotation=arrExerciseDetails.s_max

//                        imgElbowPopMin.rotation=arrExerciseDetails.e_min
//                        imgElbowPopMax.rotation=arrExerciseDetails.e_max
                          rotateImgSH.from=parseInt(arrExerciseDetails.s_min)
                          rotateImgSH.to=parseInt(arrExerciseDetails.s_max)

                        rotateImgEL.from=parseInt(arrExerciseDetails.e_min)
                        rotateImgEL.to=parseInt(arrExerciseDetails.e_max)

                        imgElbowPopMax.rotation=0
                        imgShoulderPopMax.rotation=0

                        rotateImgSH.direction=RotationAnimation.Clockwise
                        rotateImgEL.direction=RotationAnimation.Clockwise

                        rotateImgSH.start()
                        rotateImgEL.start()

                        labelSMax.text=arrExerciseDetails.s_max
                        labelSMin.text=arrExerciseDetails.s_min
                        labelEMax.text=arrExerciseDetails.e_max
                        labelEMin.text=arrExerciseDetails.e_min

                        labelExName.text=arrExerciseDetails.name




                    });
                    popup_exercise.open()
                }


            }

            Popup {
                    id: popup_exercise
                    anchors.centerIn: Overlay.overlay
                    width: 600
                    height: 450
                    modal: true
                    focus: true

                    background: Rectangle {
                            color: "#a1a1a1"
                            border.color: "black"
                        }


                    enter: Transition {
                            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
                        }
                    closePolicy: {
                        Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                    }
                    onClosed:{
                        console.log("CLOSEDED")
                        rotateImgEL.stop()
                        rotateImgEL.direction=RotationAnimation.Clockwise
                        rotateImgEL.to=0
                        rotateImgEL.from=0
                        imgElbowPopMax.rotation=0

                        rotateImgSH.stop()
                        rotateImgSH.direction=RotationAnimation.Clockwise
                        rotateImgSH.to=0
                        rotateImgSH.from=0
                        imgShoulderPopMax.rotation=0
                    }

                    Image {
                        id: imgShoulderPopMax
                        x: 306
                        y: 181
                        width: 103
                        height: 116
                        source: "../images/shoulder-2.jpg"
                        transformOrigin: Item.Top
//                        rotation: 40
                        RotationAnimator{
                            id:rotateImgSH
//                            loops: Animation.Infinite
                            target: imgShoulderPopMax;
                            duration: 3000
                            direction:RotationAnimation.Clockwise
                            onFinished: {
                                console.log("BB");
                                if (rotateImgSH.direction==RotationAnimation.Counterclockwise){
                                    rotateImgSH.direction=RotationAnimation.Clockwise
                                }else {
                                    rotateImgSH.direction=RotationAnimation.Counterclockwise
                                }
                                rotateImgSH.start()
                            }
                            onDirectionChanged: {
                                console.log("DIR Changed");
                                var shTo=rotateImgSH.to
                                var shFrom=rotateImgSH.from
                                rotateImgSH.to=shFrom
                                rotateImgSH.from=shTo
                            }

                            }
                        fillMode: Image.PreserveAspectFit
                        Image {
                            id: imgElbowPopMax
                            x: -14
                            y: 82
                            width: 140
                            height: 142
                            source: "../images/elbow-1.png"
                            transformOrigin: Item.Top
//                            rotation: 30
                            RotationAnimator{
                                id:rotateImgEL
//                                loops: Animation.Infinite
                                direction:RotationAnimation.Clockwise
                                target: imgElbowPopMax;
                                duration: 3000
                                onFinished: {
                                    console.log("BB");
                                    if (rotateImgEL.direction==RotationAnimation.Counterclockwise){
                                        rotateImgEL.direction=RotationAnimation.Clockwise
                                    }else {
                                        rotateImgEL.direction=RotationAnimation.Counterclockwise
                                    }
                                    rotateImgEL.start()
                                }
                                onDirectionChanged: {
                                    console.log("DIR Changed");
                                    var elTo=rotateImgEL.to
                                    var elFrom=rotateImgEL.from
                                    rotateImgEL.to=elFrom
                                    rotateImgEL.from=elTo
                                }

                                }
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
                            id: labelmax
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
                            id: labelmin
                            width: 50
                            height: 19
                            text: qsTr("Min")
                            anchors.left: parent.left
                            anchors.top: labelmax.bottom
                            anchors.leftMargin: 0
                            anchors.topMargin: 10
                            font.pointSize: 10
                        }

                        Label {
                            id: labelSMax
                            text: qsTr("90")
                            anchors.left: labelmax.right
                            anchors.top: parent.top
                            font.bold: true
                            anchors.leftMargin: 10
                            anchors.topMargin: 0
                            font.pointSize: 10
                        }

                        Label {
                            id: labelSMin
                            text: qsTr("0")
                            anchors.left: labelmin.right
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

            Label {
                id: label2
                x: 8
                y: 142
                height: 40
                color: "#e7f3ff"
//                text: qsTr("Exercise Type 1")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: comboBox.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.topMargin: 10
                font.pointSize: 12
            }
        }

        GroupBox {
            id: groupBox
            height: 249
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: groupBoxEx.bottom
            anchors.topMargin: 10
            clip: false
            hoverEnabled: true
            title: "<font color='white'>Timer</font>"
            font.pointSize: 12
            anchors.rightMargin: 15
            anchors.leftMargin: 15

            CircularProgressBar {
                id: circularProgressBar
                x: 67
                y: 0
                width: 154
                height: 154
                value: count*100/countInit
            }

            Label {
                id: label1
                x: 117
                y: 199
                width: 250
                height: 24
                color: "#e7f3ff"
                text: getTimeString(count)
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 15
            }

            Rectangle {
                id: rectangle2
                x: 5
                y: 13
                width: 56
                height: 70
                border.color: "#313131"
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 0.04777
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 0.98726
                        color: "#ffffff"
                    }

                }
            }

            Rectangle {
                id: rectangle3
                x: 5
                y: 78
                width: 56
                height: 70
                border.color: "#313131"
                rotation: -180
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 0.04777
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 0.98726
                        color: "#ffffff"
                    }
                }
            }

            Tumbler {
                id: tumbler
                x: 1
                y: 32
                //                model: 10
                width: 60
                height: 90
                wrap: false
                currentIndex: 1
                visibleItemCount: 3
                spacing: 0
                wheelEnabled: false
                font.wordSpacing: 0
                font.bold: true
                font.pointSize: 15
                model: 60
                onCurrentIndexChanged: {
                    console.log(tumbler.currentIndex)
                    //                count=parseInt(tumbler.currentIndex*60 )
                    setCount(parseInt(tumbler.currentIndex*60 ))

                }
            }

        }

        Button {
            id: button2
            y: 645
            width: 120
            text: qsTr("Back")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.leftMargin: 10
            onClicked: {
                console.log("Back CLICKED")
                var component = Qt.createComponent("splashScreen.qml")
                var win = component.createObject()
                win.show()
                splashScreen.close()
                visible = false
            }
        }

        Button {
            id: button3
            x: 138
            y: 645
            width: 120
            text: qsTr("Exit")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            onClicked: {
                console.log("Exit CLICKED")
                Qt.quit()
            }
        }



    }

    Rectangle {
        id: rectangle1
        x: 312
        y: 165
        width: 656
        height: 566
        color: "#a1a1a1"


        Image {
            id: imgShoulder
            x: 527
            y: 101
            width: 206
            height: 232
            source: "../images/shoulder-2.jpg"
            transformOrigin: Item.Top
            rotation: dialB.value
            Image {
                id: imgElbow
                x: -28
                y: 165
                width: 281
                height: 284
                source: "../images/elbow-1.png"
                transformOrigin: Item.Top
                rotation: dialA.value
                fillMode: Image.PreserveAspectFit
            }
//            rotation: 0
            fillMode: Image.PreserveAspectFit
        }


    }

    DelayButton {
        id: delayButton
        y: 578
        height: 112
        //        text: qsTr("Start")
        text: timerClock.running ? "Stop" : "Start"
        anchors.left: rightBar.left
        anchors.right: rightBar.right
        font.capitalization: Font.AllUppercase
        font.styleName: "Regular"
        font.family: "Verdana"
        font.bold: true
        font.pointSize: 20
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        //        onClicked: {
        //            btnClick = !btnClick
        //        }
        delay: 1000
        onActivated: {
            console.log("DelayBTN Activated")
            timerClock.running = !timerClock.running

//            backend.btnStart()
//            backend.btnStop()
        }

    }


    Dial {
        id: dialB
        x: 363
        y: 252
        stepSize: 1
        to: 90
    }

    Dial {
        id: dialA
        x: 363
        y: 506
        stepSize: 1
        to: 90
    }

//    DelayButton {
//        id: delayButton1
//        x: 1217
//        y: 578
//        text: qsTr("Stop")
//        onActivated: count = parseInt(tumbler.currentIndex*60 )
//    }



    Timer {
        id: timerClock
        interval: 1000
        running: false
        repeat: true
        //        onTriggered: count -= 1
        onTriggered: checkTimer()
    }


    Connections{
            target: backend

            function onPrintTime(name){
                //                console.log(name)
                //            imgShoulder.rotation = -parseInt(name)
//                imgElbow.rotation= 2*parseInt(name)
//                dialB.value=parseInt(name)
            }

            function onMirrorArm(val1,val2){
//                console.log(val1+"=="+val2);
                dialA.value=parseInt(val1)
                dialB.value=parseInt(val2)
            }
    }



    Image {
        id: image
        x: 0
        height: 150
        anchors.top: parent.top
        horizontalAlignment: Image.AlignLeft
        source: "../images/logo-banner.png"
        anchors.topMargin: 0
        sourceSize.height: 150
        fillMode: Image.PreserveAspectFit
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}D{i:51}D{i:56}
}
##^##*/
