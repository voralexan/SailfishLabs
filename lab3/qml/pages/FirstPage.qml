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
                           "description": "Назад-вперед"});

                append({"name": "Приложение-страница 2",
                           "description": "Создание прикрепленной страницы"});

                append({"name": "Приложение-страница 3",
                           "description": "Диалог-поле и текстовое поле"});

                append({"name": "Приложение-страница 4",
                           "description": "Диалог-дата и текстовое поле"});

                append({"name": "Приложение-страница 5",
                           "description": "Диалог-время и текстовое поле"});

                append({"name": "Приложение-страница 6",
                           "description": "Ежедневник (SilicaListView)"});

                append({"name": "Приложение-страница 7",
                           "description": "Веб-страница (SilicaWebView)"});

                append({"name": "Приложение-страница 8",
                           "description": "Слайды-ежедневник (SlideshowView)"});

                append({"name": "Приложение-страница 9",
                           "description": "Вытягиваемые меню сверху и снизу"});

                append({"name": "Приложение-страница 10",
                           "description": "Список и контексное меню"});
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
