//import QtQuick 2.4

//import QtQuick.Window 2.15
//import QtQuick3D 1.15

//import QtQml 2.2
import QtQuick 2.15

import "components"


//import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
//import "components"
import QtQuick.Timeline 1.0




Window {
    id: window2
    visible: true
    width: 400
    height: 400

    property int count:parseInt(tumbler.currentIndex*60 )
    property int countInit:parseInt(tumbler.currentIndex*60 )

    function checkTimer(){
        if (count == 1 || count <= 0){
            console.log("Timer Have to stop")
            timer.running=false
            timer.stop()
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


    title: qsTr("Hello, ")
    color: "#a1a1a1"


    DelayButton {
              id: control
              checked: true
              text: qsTr("AA")
              x:30
              y:30

              delay:5000

              contentItem: Text {
                  text: control.text
                  font: control.font
                  opacity: enabled ? 1.0 : 0.3
                  color: "white"
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  elide: Text.ElideRight
              }

              background: Rectangle {
                  implicitWidth: 100
                  implicitHeight: 100
                  opacity: enabled ? 1 : 0.3
                  color: control.down ? "#17a81a" : "#21be2b"
                  radius: size / 2

                  readonly property real size: Math.min(control.width, control.height)
                  width: size
                  height: size
                  anchors.centerIn: parent

                  Canvas {
                      id: canvas
                      anchors.fill: parent

                      Connections {
                          target: control
                          onProgressChanged: canvas.requestPaint()
                      }

                      onPaint: {
                          var ctx = getContext("2d")
                          ctx.clearRect(0, 0, width, height)
                          ctx.strokeStyle = "white"
                          ctx.lineWidth = parent.size / 20
                          ctx.beginPath()
                          var startAngle = Math.PI / 5 * 3
                          var endAngle = startAngle + control.progress * Math.PI / 5 * 9
                          ctx.arc(width / 2, height / 2, width / 2 - ctx.lineWidth / 2 - 2, startAngle, endAngle)
                          ctx.stroke()
                      }
                  }
              }


              onActivated: {

                  console.log("ABCD")
              }
          }



    CircularProgressBar {
        id: circularProgressBar
        x: 175
        y: 133
        width: 156
        height: 156
        value: count*100/countInit
    }

    Tumbler {
        id: tumbler
        x: 65
        y: 166
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

    Column {
        x: 154
        y: 31
        Text {
            id: text2
            font.pixelSize: 20
            text: (count).toFixed(1)
        }
        Row {
            spacing: 10
            Button {
                text: timer.running ? "Stop" : "Start"
                onClicked: {
                    timer.running = !timer.running
                }
            }
            Button {
                text: "Reset"
                onClicked: count = parseInt(tumbler.currentIndex*60 )
            }

        }


    }




    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
//        onTriggered: count -= 1
        onTriggered: checkTimer()
    }

    Label {
        id: labelFormat
        x: 114
        y: 342
        width: 250
        height: 24
        text: getTimeString(count)
        font.pointSize: 15
    }

    DelayButton {
        id: delayButton
        x: 30
        y: 288
        text: qsTr("Delay Button")
        onActivated: delayButton.checked = true
    }


}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
