import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnToggle

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorHover: "#23272E"
    property color btnColorPressed: "#00a1f1"

    QtObject{
        id: internal

        //MOUSE OVER AND MOUSE CLICK CHANGE COLOR
        property var dynamicColor: if(btnToggle.down){
                                       btnToggle.down ? btnColorPressed : btnColorDefault
                                   } else {
                                       btnToggle.hovered ? btnColorHover : btnColorDefault
                                   }
    }


    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            width: 25
            height: 25
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
