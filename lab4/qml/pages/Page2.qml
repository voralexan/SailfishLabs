import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    Column {
        width: page.width
        spacing: Theme.paddingMedium

        Button{
            id: addbtn
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Add item"
            onClicked: listmodel.append({"order_id": listmodel.count + 1})
        }

        SilicaListView{
            width: parent.width
            height: parent.height
            spacing: 15
            model: ListModel{
                id: listmodel
            }
            delegate: Rectangle {
                width: parent.width
                height: 80
                color: "skyblue"
                Text{
                    anchors.centerIn: parent
                    text: "Item " + model.order_id
                }
              //  onClicked: model.remove(index)

                MouseArea {
                    anchors.fill: parent
                    onClicked: listmodel.remove(index)
                }
            }
        }
    }
}
