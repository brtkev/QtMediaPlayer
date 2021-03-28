import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Button {
    id: btnTopBar

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorHover: "#23272E"
    property color btnColorPressed: "#00a1f1"

    property int imageSize: 16

    QtObject{
        id: internal

        //MOUSE OVER AND MOUSE CLICK CHANGE COLOR
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorPressed : btnColorDefault
                                   } else {
                                       btnTopBar.hovered ? btnColorHover : btnColorDefault
                                   }
    }


    implicitWidth: 35
    implicitHeight: 35

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            width: imageSize
            height: imageSize
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
