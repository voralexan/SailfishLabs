import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable

    property var dataModel: [
        {color: "red", text: "Red"},
        {color: "orange", text: "Orange"},
        {color: "yellow", text: "Yellow"},
        {color: "green", text: "Green"},
        {color: "skyblue", text: "Skyblue"},
        {color: "blue", text: "Blue"},
        {color: "purple", text: "Purple"}
    ]
    SilicaListView {
        anchors.fill: parent
        model: dataModel
        delegate: Rectangle {
            width: parent.width
            height: 100
            color: modelData.color
            Text {
                anchors.centerIn: parent
                text: modelData.text
                font.pointSize: 20
                font.bold: true
                color: "black"
            }
        }
    }
}
