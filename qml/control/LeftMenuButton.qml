import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: btnLeftMenu
    /*text: qsTr("left Menu Text")*/

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/home_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorHover: "#23272E"
    property color btnColorPressed: "#00a1f1"
    property int iconWidth: 18
    property int iconHeight: 18
    property color activeMenuColor: "#55aaff"
    property color activeMenuColorRight: "#2c313c"
    property bool isActiveMenu: false

    QtObject{
        id: internal

        //MOUSE OVER AND MOUSE CLICK CHANGE COLOR
        property var dynamicColor: if(btnLeftMenu.down){
            btnLeftMenu.down ? btnColorPressed : btnColorDefault
        } else {
            btnLeftMenu.hovered ? btnColorHover : btnColorDefault
        }
    }


    implicitWidth: 250
    implicitHeight: 60

    background: Rectangle {
        id: bgBtn
        color: internal.dynamicColor


        Rectangle{
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 3
            visible: isActiveMenu
        }
//        Rectangle{
//            anchors{
//                top: parent.top
//                right: parent.right
//                bottom: parent.bottom
//            }
//            color: activeMenuColorRight
//            width: 5
//            visible: isActiveMenu
//        }

    }


    contentItem: Item{
        anchors.fill: parent

        id: content

        Image {
            id: iconBtn
            width: iconHeight
            height: iconHeight
            source: btnIconSource
            anchors.leftMargin: 26
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            fillMode: Image.PreserveAspectFit
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: iconBtn
            anchors.verticalCenter: parent.verticalCenter
            source: iconBtn
            color: "#ffffff"
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

        Text{
            color: "#ffffff"
            text: btnLeftMenu.text
            font: btnLeftMenu.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.margins: 75
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:254}
}
##^##*/
