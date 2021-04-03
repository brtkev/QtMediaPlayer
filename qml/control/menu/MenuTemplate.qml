import QtQuick 2.15
import QtQuick.Controls 2.15

// import "control"
import ".."

Menu {
    id: menu
    property color themeBlack: "#1c1d20"
    property color themeDarkBlue: "#2c313c"
    property color themeGray: "#23272E"
    property color themeBlue: "#00a1f1"

    topPadding: 2
    bottomPadding: 2

    delegate: MenuDelegate {

    }

    background: Rectangle {
        implicitWidth: 170
        implicitHeight: 40
        color: themeDarkBlue
        border.color: themeBlack
        radius: 2
    }

}