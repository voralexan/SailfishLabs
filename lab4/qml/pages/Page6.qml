import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.XmlListModel 2.0
import QtQuick.LocalStorage 2.0
import QtQuick 2.0
Page {
    id: page

    allowedOrientations: Orientation.All

    DAO6 {
        id: dao
    }

    Column {
        width: page.width
        spacing: Theme.paddingMedium

        PageHeader { title: "Шестая страница"}

        TextField {
            id: text_note
            width: parent.width
            placeholderText: "Заметка"
        }

        Button {
            text: "Добавить"
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                dao.insert_note(text_note.text);
                select_notes();
                text_note.text = ""
            }
        }

        SilicaListView {
            width: parent.width
            height: parent.height
            spacing: 15

            model: ListModel {
                id: notes_list_model
            }

            delegate: Rectangle {
                width: parent.width
                height: label_text.height
                color: "blue"

                Label {
                    id: label_text
                    text: model.text
                    font.pixelSize: 46
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        dao.delete_note(notes_list_model.get(index).id);
                        select_notes();
                    }
                }
            }
        }
    }

    function select_notes() {
        notes_list_model.clear();
        dao.retrieve_notes((function(notes) {
            for (var i = 0; i < notes.length; i++) {
                var note = notes.item(i);
                notes_list_model.append({id: note.id, text: note.note});
            }
        }));
    }

    Component.onCompleted: select_notes()
}
