import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    allowedOrientations: Orientation.All

    SilicaListView {
        anchors.fill: parent

        header: PageHeader { title: "Главная страница"}

        model: ListModel {
            id: listModel
            Component.onCompleted: {
                append({"name": "Приложение-страница 1",
                           "description": "Светофор"});

                append({"name": "Приложение-страница 2",
                           "description": "Светофор + человек"});

                append({"name": "Приложение-страница 3",
                           "description": "Поворот текста"});

                append({"name": "Приложение-страница 4",
                           "description": "Светофор - 1 компонент"});

                append({"name": "Приложение-страница 5",
                           "description": "Кнопка с заданным свойством"});

                append({"name": "Приложение-страница 6",
                           "description": "Секундомер"});

                append({"name": "Приложение-страница 7",
                           "description": "Стек страниц"});


            }
        }


        delegate: ListItem {
            width: ListView.view.width
            contentHeight: Theme.itemSizeMedium

            Label {
                id: label
                text: model.name
                font.pixelSize: 48
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: model.description
                font.pixelSize: 36
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: label.bottom
            }

            onClicked: {
                var idx = parseInt(index) + 1;
                pageStack.push(Qt.resolvedUrl("Page" + idx.toString() + ".qml"));
            }
        }
    }
}

