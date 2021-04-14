import QtQuick 2.0

Item {
    id: root

    width: 200
    height: 200

    property real rotationAngle: 0
    property bool resetContext: false

    onRotationAngleChanged:  canvas.requestPaint()

    Behavior on rotationAngle {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutCubic
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90

        onPaint: {
            var ctx = getContext("2d")

            ctx.fillStyle = Qt.rgba(200, 200, 200)
            ctx.beginPath()
            ctx.moveTo(width / 2, height / 2)
            ctx.arc(width / 2, height / 2, width / 2, 0, ((rotationAngle * Math.PI) / 180))
            ctx.closePath()
            ctx.fill()

            if(resetContext) {
               ctx.reset()
            }
        }
    }
}
