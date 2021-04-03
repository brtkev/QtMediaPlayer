import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.0
// import "control"
import ".."

MenuTemplate {
    id: menu
    property color themeBlack: "#1c1d20"
    property color themeDarkBlue: "#2c313c"
    property color themeGray: "#23272E"
    property color themeBlue: "#00a1f1"

    Action { 
        text: qsTr("Open new File"); 
        onTriggered : {
            fileOpen.title = "Please choose your file"
            fileOpen.selectFolder = false
            fileOpen.selectMultiple = false
            fileOpen.open()
        }
    }
    Action { 
        text: qsTr("Open new Files");  
        onTriggered : {
            fileOpen.title = "Please choose your files"
            fileOpen.selectFolder = false
            fileOpen.selectMultiple = true
            fileOpen.open()
        }
    }    

    MenuSeparator {
        contentItem: Rectangle {
            implicitWidth: 170
            implicitHeight: 1
            color: themeBlue
        }
    }

    Action { 
        text : qsTr("Open Folder");  
        onTriggered : {
            fileOpen.title = "Please choose your directory"
            fileOpen.selectMultiple = false
            fileOpen.selectFolder = true
            fileOpen.open()
        }
    }

    Action {
        text: qsTr("Open playlist");  
        onTriggered : print("needs implementation")
    }

    FileDialog{
        id : fileOpen
        title : "Please choose your files"
        folder : shortcuts.desktop
        selectMultiple : true
        nameFilters : ["Media Files(*.avi *.mp3 *.mp4  *.mkv)"]
        onAccepted: {
            menu.parent.focus = true
            let urls = []
            fileOpen.fileUrls.forEach(
                (url, index) => {
                    urls.push(url.toString().slice(8)); 
                }
            )
            if(fileOpen.selectFolder == true){
                player.fromDir(urls[0])
            }else{
                player.fromUrls(urls)
            }

            
        }
        onRejected: {
            menu.parent.focus = true
            console.log("Canceled")
            // Qt.quit()
        }
    }
    Connections {
        target: player       
    }
}