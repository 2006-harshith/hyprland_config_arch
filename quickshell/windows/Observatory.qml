import QtQuick
import Quickshell

PanelWindow {
    visible: true

    anchors {
        right: true
        top: true
        bottom: true
    }

    implicitWidth: 500

    Rectangle {
        anchors.fill: parent
        color: "#dd000000"

        Text {
            anchors.centerIn: parent
            color: "white"
            text: "OBSERVATORY"
        }
    }
}