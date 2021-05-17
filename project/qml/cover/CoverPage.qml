import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

CoverBackground {

    function getTopVal(cp) {
        switch ( cp ) {
            case 0: return cpu.summaryValue
            case 1: return memory.summaryValue
        }

        return -1
    }

    function getBotVal(cp) {
        switch ( cp ) {
            case 0: return cpu.temperature
            case 1: return Math.round(memory.free / 1000)
        }

        return ""
    }

    function getBotUnit(cp) {
        switch ( cp ) {
            case 0: return "C°"
            case 1: return "MB"
        }

        return ""
    }

    Image {
        id: bgimg
        source: "../images/cover.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: sourceSize.height * width / sourceSize.width
    }

    Label {
        anchors.top: parent.top
        anchors.margins: Theme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeLarge
        horizontalAlignment: Text.AlignHCenter
        color: Theme.highlightColor
        text: monitor.coverLabel
    }

    ProgressCircleBase {
        width: parent.parent.width / 1.2
        height: width
        anchors {
            horizontalCenter: parent.horizontalCenter
            centerIn: parent
        }
        value: getTopVal(monitor.coverPage) / 100.0
        borderWidth: 2
        progressColor: Theme.highlightColor

        DoubleIndicator {
            topVal: getTopVal(monitor.coverPage)
            topUnit: "%"
            botVal: getBotVal(monitor.coverPage)
            botUnit: getBotUnit(monitor.coverPage)
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "../images/cover-image-" + monitor.coverImageLeft + ".png"
            onTriggered: monitor.coverPage--
        }

        CoverAction {
            iconSource: "../images/cover-image-" + monitor.coverImageRight + ".png"
            onTriggered: monitor.coverPage++
        }        
    }
}


