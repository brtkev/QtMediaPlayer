import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: topBar
    width: 200
    height: 60
    color: barColor
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.rightMargin: 0
    anchors.leftMargin: 0
    anchors.topMargin: 0

    
    signal dragEvent()
    
    
    signal btnToggleClicked()
    signal btnMinimizeClicked()
    signal btnMaximizeClicked()
    signal btnCloseClicked()
    
    
    
    //PROPS 
    
    property url iconAppTop : "../../images/svg_images/icon_app_top.svg"
    property url iconMaximizeRestore : "../../images/svg_images/maximize_icon.svg"
    property url iconClose : "../../images/svg_images/close_icon.svg"
    
    ToggleButton {
        onClicked: btnToggleClicked()
    }

    Rectangle {
        id: rectangle
        y: 16
        width: 806
        height: 25
        color: "#282c34"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 70
        anchors.bottomMargin: 0

        Label {
            id: labelTopInfo

            
            property string titleName : qsTr("No title")
            

            text: titleName
            color: labelTopInfo.text == "No title" ? "#717393" : "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 300
            anchors.leftMargin: 10
            anchors.bottomMargin: 0
            anchors.topMargin: 0
        }

        Label {

            id: labelRightInfo
            color: "#717393"
            text: qsTr("SAMPLE TEXT")
            anchors.left: labelTopInfo.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 10
            anchors.leftMargin: 0
            visible : false
        }
    }

    Rectangle {
        id: titleBar
        height: 35
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 105
        anchors.leftMargin: 70
        anchors.topMargin: 0

        DragHandler{
            onActiveChanged: if(active){
                topBar.dragEvent()
                
            }
        }


        Image {
            id: appIcon
            width: 22
            height: 22
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: iconAppTop
            anchors.leftMargin: 5
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: titleLabel
            x: 71
            y: 14
            color: "#aaacdd"
            text: qsTr("KBN")
            anchors.left: appIcon.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            anchors.leftMargin: 5
        }

        
    }

    Row {
        id: rowBtns
        x: 951
        width: 105
        height: 35
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.rightMargin: 0

        TopBarButton {
            id: btnMinimize
            onClicked: btnMinimizeClicked()

        }

        TopBarButton {
            id: btnMaximizeRestore
            btnIconSource: iconMaximizeRestore
            onClicked: btnMaximizeClicked()
        }

        TopBarButton {
            id: btnClose
            btnColorPressed: "#ff007f"
            btnIconSource: iconClose
            onClicked: btnCloseClicked()
        }
    }

    
    Connections {
        target: player
        function onTitleChanged(title){
            labelTopInfo.titleName = qsTr(title)
        }
    }
    
}