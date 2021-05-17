import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("0")
    }

    CoverActionList {
        id: coverAction


        CoverAction {
            iconSource: "image://theme/icon-cover-next"
            onTriggered: label.text = parseInt(label.text) + 1
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
            onTriggered: label.text = "0"
        }
    }
}
