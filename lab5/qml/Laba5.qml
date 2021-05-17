import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    property var added: 0
    property var removed: 0
    property var prev: 0

    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    Connections {
        target: pageStack
        onDepthChanged: {
            if (prev > pageStack.depth) {
                removed++
            }
            else {
                added++
            }
            prev = pageStack.depth
        }
    }

}
