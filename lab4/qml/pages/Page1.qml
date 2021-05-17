import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    ListModel{
        id: dataModel;
        ListElement{color: "red"; text: "Red"}
        ListElement{color: "orange"; text: "Orange"}
        ListElement{color: "yellow"; text: "Yellow"}
        ListElement{color: "green"; text: "Green"}
        ListElement{color: "skyblue"; text: "Skyblue"}
        ListElement{color: "blue"; text: "Blue"}
        ListElement{color: "purple"; text: "Purple"}
    }

    SilicaListView{
        anchors.fill: parent
        header: PageHeader{title: "Список"}
        model: dataModel
        delegate: Rectangle{
            width: parent.width
            height: 150
            color: model.color
            Text{
                anchors.centerIn: parent
                text: model.text
            }
        }
    }
}
