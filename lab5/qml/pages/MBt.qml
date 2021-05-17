import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    default property var someText
    property color myColor: "black"
    Button {
        text: someText.text
        color: myColor
        y: 200
    }
}
