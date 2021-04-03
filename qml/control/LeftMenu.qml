import QtQuick 2.15
import QtQuick.Controls 2.15


import "menu"

Rectangle {
    id: leftMenu
    width: 70
    color: barColor
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    clip: true
    anchors.bottomMargin: 0
    anchors.topMargin: 0
    anchors.leftMargin: 0
    
    
    
    property alias animationMenu : animationMenu
    
    

    signal btnPlayerClicked()
    signal btnSettingsClicked()
    
    
    function settingMenuClosed() {
        btnPlayer.isActiveMenu = true
        btnSettings.isActiveMenu = false
    }
    

    PropertyAnimation{
        id: animationMenu
        target: leftMenu
        property: "width"
        to: {
            // if(leftMenu.width == 0) return 70; 
            if(leftMenu.width == 70) return 150;
            else return 70;
        }
        duration: 500
        easing.type: Easing.OutQuint
    }

    Column {
        id: columnMenus
        width: 200
        height: 400
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        clip: true
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        LeftMenuButton {
            id: btnPlayer
            width: leftMenu.width
            text: qsTr("Home")
            btnColorPressed: "#00a1f1"
            iconHeight: 18
            iconWidth: 18
            btnIconSource: "../../images/png_images/play.png"
            isActiveMenu: true

            onClicked: {
                btnPlayer.isActiveMenu = true
                btnSettings.isActiveMenu = false
                btnPlayerClicked()
            }
        }

        LeftMenuButton {
            id: btnOpen
            width: leftMenu.width
            text: qsTr("Open")
            btnIconSource: "../../images/svg_images/open_icon.svg"

            onClicked : {
                // fileOpen.open()
                fileMenu.popup(btnOpen, btnOpen.width,0)
            }

            

            FileMenu {
                id : fileMenu
                focus : false
            }
            
            
            

        }

        // LeftMenuButton {
        //     id: btnSave
        //     width: leftMenu.width
        //     text: qsTr("Save")
        //     btnIconSource: "../../images/svg_images/save_icon.svg"
        // }
    }

    LeftMenuButton {
        id: btnSettings
        width: leftMenu.width
        text: "Settings"
        anchors.bottom: parent.bottom
        clip: false
        anchors.bottomMargin: 70
        btnIconSource: "../../images/svg_images/settings_icon.svg"


        onClicked: {
            if(btnSettings.isActiveMenu){
                btnPlayer.isActiveMenu = true
                btnSettings.isActiveMenu = false
            }else{
                btnPlayer.isActiveMenu = false
                btnSettings.isActiveMenu = true
            }
            btnSettingsClicked()
        }

    }

    Label {
        id: leftMenuBottomLabel
        color: "#aaacdd"
        text: qsTr("0.4V")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: btnSettings.bottom
        anchors.bottom: parent.bottom
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 10
        anchors.topMargin: 20
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 20
    }


    
}