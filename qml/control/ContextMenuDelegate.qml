import QtQuick 2.15
import QtQuick.Controls 2.15


MenuItem {

    property color themeBlack: "#2c313c"
    property color themeGray: "#23272E"
    property color themeBlue: "#00a1f1"


    id: menuItem
    implicitWidth: 170
    implicitHeight: 40

    arrow: Canvas {
        x: parent.width - width
        implicitWidth: 40
        implicitHeight: 40
        visible: menuItem.subMenu
        onPaint: {
            var ctx = getContext("2d")
            ctx.fillStyle = menuItem.highlighted ? "#ffffff" : themeBlue
            ctx.moveTo(15, 15)
            ctx.lineTo(width - 15, height / 2)
            ctx.lineTo(15, height - 15)
            ctx.closePath()
            ctx.fill()
        }
    }

    indicator: Item {
        implicitWidth: 40
        implicitHeight: 40
        Rectangle {
            width: 26
            height: 26
            anchors.centerIn: parent
            visible: menuItem.checkable
            border.color: themeBlue
            radius: 3
            Rectangle {
                width: 14
                height: 14
                anchors.centerIn: parent
                visible: menuItem.checked
                color: themeBlue
                radius: 2
            }
        }
    }

    contentItem: Text {
        leftPadding: menuItem.indicator.width
        rightPadding: menuItem.arrow.width
        text: menuItem.text
        font: menuItem.font
        opacity: enabled ? 1.0 : 0.3
        color: menuItem.highlighted ? "#ffffff" : themeBlue
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 170
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        color: menuItem.highlighted ? themeGray : "transparent"
    }
}