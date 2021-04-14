import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.14

Item {
    property alias text: propText.text
    property alias checked: checkBox.checked

    width: rowLayout.width
    height: rowLayout.height

    RowLayout {
        id: rowLayout
        CheckBox {
            id: checkBox
            indicator: Rectangle {
                anchors.centerIn: parent
                implicitWidth: 20
                implicitHeight: 20
                radius: 5
                color: checkBox.pressed ? "#222840" : "#6b7080"
                border.color: "#848895"
                Rectangle {
                    anchors.centerIn: parent
                    implicitWidth: 12
                    implicitHeight: 12
                    radius: 4
                    color: "#ffffff"
                    border.color: "#848895"
                    visible: checkBox.checked
                }
            }
        }
        Label {
            id: propText
            color: "#222840"
            font.pointSize: 12
            Layout.minimumWidth: 150
            Layout.maximumWidth: 150
            opacity: checkBox.checked ? 1.0 : 0.5
        }
    }
}