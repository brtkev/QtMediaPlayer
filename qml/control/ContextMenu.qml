import QtQuick 2.15
import QtQuick.Controls 2.15

// import "control"

Menu {
    id: menu
    property color themeBlack: "#2c313c"
    property color themeGray: "#23272E"
    property color themeBlue: "#00a1f1"

    
    property string seekBackValue : qsTr("10")
    property string seekAheadValue : qsTr("10")

    
    signal fullscreenTriggered()
    
    

    Action { 
        text: qsTr("Jump Back"); 
        onTriggered : player.setPosition(-parseInt(seekBackValue), true)
    }
    Action { 
        text: qsTr("Jump Ahead");  
        onTriggered : player.setPosition(-parseInt(seekAheadValue), true)
    }
    

    MenuSeparator {
        contentItem: Rectangle {
            implicitWidth: 170
            implicitHeight: 1
            color: themeBlue
        }
    }

    Action { id : actionPlay; text: qsTr("Play"); 
        onTriggered : player.playPause()
    }
    Action { 
        text: qsTr("Stop");
        onTriggered : player.stop()
    }
    Action { 
        id : actionMute
        text: qsTr("Mute");
        onTriggered : {
            if(player.mute()){
                actionMute.text = qsTr("Mute");
            }else{
                actionMute.text = qsTr("Unmute");
            }
        }
    }
    Action { 
        text: qsTr("Previous");
        onTriggered : player.prev()
    }
    Action { 
        text: qsTr("Next"); 
        onTriggered : player.next()
    }

    MenuSeparator{
        contentItem: Rectangle {
            implicitWidth: 170
            implicitHeight: 1
            color: themeBlue
        }
    }

    Action{
        text : qsTr("FullScreen")
        onTriggered : fullscreenTriggered()
    }


    Menu {
        title: qsTr("playback Mode")

        Action {
            text : qsTr("No repeat")
            onTriggered : player.setPlaybackMode(0)
        }
        Action {
            text : qsTr("repeat One")
            onTriggered : player.setPlaybackMode(1)
        }
        Action {
            text : qsTr("repeat All")
            onTriggered : player.setPlaybackMode(2)
        }
        
        background: Rectangle {
            implicitWidth: 170
            implicitHeight: 40
            color: themeBlack
            border.color: themeGray
            radius: 2
        }
        
        delegate : ContextMenuDelegate{

        }
    }

    topPadding: 2
    bottomPadding: 2

    delegate: ContextMenuDelegate {

    }

    background: Rectangle {
        implicitWidth: 170
        implicitHeight: 40
        color: themeBlack
        border.color: themeGray
        radius: 2
    }

    
    Connections {
        target: player
        
        function onStateChanged(state) {
            if(state == 1){
                actionPlay.text = qsTr("Pause");
            }else{
                actionPlay.text = qsTr("Play");
            }
        }
    }
    
}