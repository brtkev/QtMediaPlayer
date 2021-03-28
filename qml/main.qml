import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15

import "control"
import "pages"


Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#00000000"
    title: qsTr("kbn")
    
    

    //REMOVE TITLE BAR
    flags: Qt.Window | Qt.FramelessWindowHint

    //PROPERTIES
    property int windowStatus: 0
    property int windowMargin: 10
    property color bgMain: "#2c313c"
    property color barColor: "#1c1d20"
    property bool initialised: false

    //INTERNAL FUNCTIONS
    QtObject{
        id: internal

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowMargin = 0
                windowStatus = 1
                //resize visibility
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false
                topBar.iconMaximizeRestore = "../images/svg_images/restore_icon.svg"
            }else{
                mainWindow.showNormal()
                internal.restoreMargin()
            }
        }

        function ifMaximizeWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                internal.restoreMargin()
            }
        }

        function restoreMargin(){
            windowMargin = 10
            windowStatus = 0
            topBar.iconMaximizeRestore = "../images/svg_images/maximize_icon.svg"
            //resize visibility
            resizeLeft.visible = true
            resizeRight.visible = true
            resizeBottom.visible = true
            resizeWindow.visible = true
        }

        function setupFullScreen(){
            if( windowStatus != 2){
                windowMargin = 0
                windowStatus = 2
                resizeLeft.visible = false
                resizeRight.visible = false
                resizeBottom.visible = false
                resizeWindow.visible = false

                topBar.visible = false
                leftMenu.visible = false

                content.anchors.top = appContainer.top

                contentPages.anchors.left= content.left
                contentPages.anchors.bottom= content.bottom
                
                bottomMenu.anchors.right = undefined
                bottomMenu.anchors.left = undefined
                bottomMenu.width = 800
                bottomMenu.anchors.horizontalCenter = content.horizontalCenter
                bottomMenu.anchors.bottom = content.bottom
                bottomMenu.visible = false
            }else{
                internal.maximizeRestore()
                topBar.visible = true
                leftMenu.visible = true
                content.anchors.top = topBar.bottom

                bottomMenu.anchors.horizontalCenter = undefined
                bottomMenu.anchors.right = content.right
                bottomMenu.anchors.left = leftMenu.right
                bottomMenu.visible = true

                contentPages.anchors.bottom= bottomMenu.top
                contentPages.anchors.left = leftMenu.right

            }
            playerPage.adaptSize()      
        }

    }

    onAfterRendering: {
        if (!initialised) {
            initialised = true;
            backend.startBackend()

            
        }
    }

    onWidthChanged: () => {

        playerPage.adaptSize()
    }

    onHeightChanged: () => {

        playerPage.adaptSize()
    }


    
    Connections {
        target: backend
        
    }

    //MainRectangle
    Rectangle {
        id: bg
        color: bgMain
        border.color: "#353b48"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.topMargin: windowMargin
        z:1


        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            ///topbar///
            TopBar{
                id : topBar
                onDragEvent: () => {
                    mainWindow.startSystemMove()
                    internal.ifMaximizeWindowRestore()
                }
                
                onBtnToggleClicked : {
                    leftMenu.animationMenu.running = true
                    playerPage.adaptSize()
                }

                onBtnMinimizeClicked : {
                    mainWindow.showMinimized()
                    internal.restoreMargin()
                }

                onBtnMaximizeClicked : {
                    internal.maximizeRestore()
                }
                
                onBtnCloseClicked : {
                    mainWindow.close()
                }
            }

            Rectangle {
                id: content
                color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                ///leftMenu///
                LeftMenu{
                    id: leftMenu

                    onBtnPlayerClicked : {
                        settingsPage.visible = false
                    }

                    onBtnSettingsClicked : {
                        if (settingsPage.visible){
                            settingsPage.visible = false
                        }else {
                            settingsPage.visible = true
                        }

                    }

                    
                }


                
                Rectangle {
                    id: contentPages
                    width: 200
                    color: "#00000000"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: bottomMenu.top
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    MouseArea{
                        id: playerPageMouseArea
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        
                        Connections {
                            target: player
                        }
                        
                        
                        onDoubleClicked : {
                            if(mainWindow.windowStatus != 2){
                                mainWindow.showFullScreen()
                                internal.setupFullScreen()
                            }else{
                                mainWindow.showNormal()
                                internal.setupFullScreen()
                            }
                            player.playPause()
                        }
                        
                        onClicked : {
                            if (mouse.button == Qt.LeftButton){
                                player.playPause()
                            }else if(mouse.button == Qt.RightButton){
                                contextMenu.popup()
                            }
                        }

                        ContextMenu {
                            id: contextMenu
                            
                            seekAheadValue : settingsPage.seekAheadValue
                            seekBackValue : settingsPage.seekBackValue

                            onFullscreenTriggered : {
                                if(mainWindow.windowStatus != 2){
                                    mainWindow.showFullScreen()
                                    internal.setupFullScreen()
                                }else{
                                    mainWindow.showNormal()
                                    internal.setupFullScreen()
                                }
                            }

                        }


                        MouseArea{
                            width : bottomMenu.width
                            height : bottomMenu.height
                            y : bottomMenu.y
                            x : bottomMenu.x
                            hoverEnabled : true
                            

                            onEntered :() => {
                                if(!bottomMenu.visible && mainWindow.windowStatus == 2){
                                    bottomMenu.visible = true
                                }
                            }
                        }

                        
                    }

                    PlayerPage{
                        id : playerPage
                        
                        anchors.fill: parent

                        
                        
                    }

                    SettingsPage{
                        id : settingsPage
                        // anchors.fill : parent
                        visible : false
                        
                    }
                    


                }



                BottomMenu {
                    id: bottomMenu
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    
                    seekAheadValue : settingsPage.seekAheadValue
                    seekBackValue : settingsPage.seekBackValue

                    onMouseExited :{
                        if(mainWindow.windowStatus == 2){
                            bottomMenu.visible = false
                        }
                    }

                    onFullScreenBtnClicked : {
                        if(mainWindow.windowStatus != 2){
                            mainWindow.showFullScreen()
                            internal.setupFullScreen()
                        }else{
                            mainWindow.showNormal()
                            internal.setupFullScreen()
                        }
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 953
                        y: 17
                        width: 25
                        height: 25
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if(active){
                                mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                            }
                        }

                        Image {
                            id: resizeImage
                            opacity: 0.5
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }

                
            }
        }
    }


    DropShadow{
        anchors.fill: bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: bg
        z:0
    }

    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }
        }
    }

    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }
        }
    }

    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        anchors.rightMargin: 10
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                             }
        }
    }


}


