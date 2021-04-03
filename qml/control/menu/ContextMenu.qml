import QtQuick 2.15
import QtQuick.Controls 2.15

// import "control"

MenuTemplate {
    id: menu
    property color themeBlack: "#1c1d20"
    property color themeDarkBlue: "#2c313c"
    property color themeGray: "#23272E"
    property color themeBlue: "#00a1f1"

    
    property string seekValue : qsTr("10")

    
    signal fullscreenTriggered()
    
    

    Action { 
        text: qsTr("Jump Back"); 
        onTriggered : player.setPosition(-parseInt(seekValue), true)
    }
    Action { 
        text: qsTr("Jump Ahead");  
        onTriggered : player.setPosition(-parseInt(seekValue), true)
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


    MenuTemplate {
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