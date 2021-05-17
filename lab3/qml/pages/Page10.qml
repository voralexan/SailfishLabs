import QtQuick 2.0
import Sailfish.Silica 1.0
Page{
SilicaListView {
    anchors.fill: parent
    model: 20
    delegate: ListItem {
        id: delegate
        Label {
            x: Theme.paddingLarge
            text: "Задача №" + index
          //  color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
        }
        menu: ContextMenu {
         //   MenuLabel {text: "Context menu"}
            MenuItem {
                text: "Меню 1"
                onClicked: console.log("Задача #" + index + ", меню 1")
            }
            MenuItem {
                text: "Меню 2"
                onClicked: console.log("Задача #" + index + ", меню 2")
            }
        }
    }
}
}
