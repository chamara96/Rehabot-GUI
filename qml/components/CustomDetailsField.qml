import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    id: rectangle
    width: 275

    property string propertyvalue: "value"
    property string propertyname: "name"


    Label {
        id: label1
        y: 14
        color: "#ffffff"
        text: qsTr(propertyname)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 20
        font.pointSize: 16
    }

    Label {
        id: label2
        y: 13
        color: "#ffffff"
        text: qsTr(propertyvalue)
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 20
        anchors.leftMargin: 120
        font.pointSize: 16
    }


    implicitWidth: 300
    implicitHeight: 40
    color: "#424242"
    radius: 12
    border.width: 2

}


