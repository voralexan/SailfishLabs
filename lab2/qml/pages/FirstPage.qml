import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingMedium

            Label {
                id: numberLabel;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: "Введите число:"
            }
            TextField {
                id: numberTextField;
                width: parent.width;
                inputMethodHints: Qt.ImhFormattedNumbersOnly;
              //  label: "Число"
              //  placeholderText: label
            }

            Button {
                id: pressedButton;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: "Нажать"
                onClicked: {
                    pressedButton.color = "lightgreen";
                    pressedButton.text = "Нажата";
                }
            }

            Button {
                id: holdButton;
                anchors.horizontalCenter: parent.horizontalCenter;
                highlightBackgroundColor: "lightblue"
                text: "Удерживать"
                onPressedButtonsChanged: {
                    if(down)
                        holdLabel.text = "Нажата"
                    else
                        holdLabel.text = "Отпущена"
                }
            }
            Label {
                id: holdLabel;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: "Отпущена"
            }

            ValueButton {
                width: parent.width;
                property int count: 0
                label: "Счетчик"
                description: "Считает количество нажатий на поле"
                value: count;
                onClicked: count++;
            }

            DatePicker {
                date: new Date();
                daysVisible: true
                monthYearVisible: true
                onDateTextChanged:
                    console.log(dateText);
            }

            Item {
                height: timePicker.height;
                width: parent.width;
                TimePicker {
                    width: parent.width
                    id: timePicker;
                    hour: 6
                    minute: 0
                    onTimeTextChanged: console.log(timeText)
                }
                Label {
                    anchors.centerIn: timePicker;
                    text: timePicker.timeText
                    font.pixelSize: Theme.fontSizeExtraLarge
                }
            }

            ComboBox {
                anchors.horizontalCenter: parent.horizontalCenter;
                label: "Выпадающий список"
                description: "Выберете элемент"
                menu: ContextMenu {
                    id: menu
                    MenuItem { text: "1" }
                    MenuItem { text: "2" }
                    MenuItem { text: "3" }
                }
                onCurrentIndexChanged: console.log(menu.children[currentIndex].text)
            }

            Switch {
                anchors.horizontalCenter: parent.horizontalCenter;
                id: mute;
                iconSource: "image://theme/icon-m-speaker-mute?"
                             + (checked ? Theme.highlightColor : Theme.primaryColor);

            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                text: mute.checked?"Включен":"Выключен";
            }

            Slider {
                width: parent.width
                label: "Текущее значение = " + value;
                minimumValue: 0;
                maximumValue: 100;
                value: 0;
                stepSize: 1;
            }

        }
    }
}
