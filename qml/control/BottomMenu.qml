import QtQuick 2.15
import QtQuick.Controls 2.2
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15


Rectangle{
    id: container
    height: 70
    //CUSTOM PROPERTIES
    property color themeBlack: "#1c1d20"
    property int seekValue : 10
    property alias functions : internal
    

    
    signal mouseExited()
    
    signal fullScreenBtnClicked()
    
    
    
    width: 800

    
    QtObject {
        id: internal

        function volumeKeyPressed(value){
            if (value === true){
                player.setVolume(0.05, true)
            }else{
                player.setVolume(-0.05, true)
            }
        }

        function moveKeyPressed(value){
            if(value === true ){
                player.setPosition(progressBar.value + seekValue)
            }else{
                player.setPosition(progressBar.value - seekValue)
            }

        }
    }
    


    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onExited: {
            mouseExited()
        }

        Rectangle {
            id: sliderBar

            

            width: 100
            height: 30
            color:  themeBlack
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: buttonBar.top
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0


            Slider {
                id: progressBar
                anchors.left: timeStamp.right
                anchors.right: durationStamp.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                value: 0.
                // focusPolicy : Qt.NoFocus
                stepSize : seekValue
                
                onMoved : player.setPosition(progressBar.value)

                background: Rectangle {
                        x: progressBar.leftPadding
                        y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                        implicitWidth: 200
                        implicitHeight: 4
                        width: progressBar.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#2c313c"

                        Rectangle {
                            width: progressBar.visualPosition * parent.width
                            height: parent.height
                            color: "#bdbebf" 
                            radius: 2
                        }
                }
            handle: Rectangle {
                x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
                y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
                implicitWidth: 5
                implicitHeight: 15
                color: progressBar.pressed ? "white" : "black"
                border.color: "#bdbebf"
            }
            }

            Label {
                id: timeStamp
                height: 15
                visible: true
                color: "#ffffff"
                text: qsTr("00:00")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                font.bold: false
                font.pointSize: 10
                anchors.leftMargin: 10
            }

            Label {
                id: durationStamp
                x: 614
                height: 15
                visible: true
                color: "#ffffff"
                text: qsTr("00:00")
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                font.bold: false
                font.pointSize: 10
                anchors.rightMargin: 10
            }
        }

        Rectangle {
            id: buttonBar
            height: 40
            color: "#1c1d20"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: sliderBar.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0


            TopBarButton{
                id: seekBackBtn
                width: 40
                height: 40
                anchors.right: playBtn.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/back.png"

                onClicked : {
                    internal.moveKeyPressed(false)
                }

            }

            TopBarButton {
                id: playBtn
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                btnIconSource: "../../images/png_images/play_btn.png"

                onClicked:{
                    player.playPause()
                }
            }

            TopBarButton {
                id: seekAheadBtn
                width: 40
                height: 40
                anchors.left: playBtn.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/ahead.png"

                onClicked : {
                    internal.moveKeyPressed(true)
                }
            }

            Slider {
                id: volumeBar
                width: 100
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 10
                anchors.bottomMargin: 10
                anchors.rightMargin: 30
                value: 1
                onMoved: player.setVolume(volumeBar.value)

                background: Rectangle {
                    x: volumeBar.leftPadding
                        y: volumeBar.topPadding + volumeBar.availableHeight / 2 - height / 2
                        implicitWidth: parent.implicitWidth
                        implicitHeight: 4
                        width: volumeBar.availableWidth
                        height: implicitHeight
                        radius: 2
                        color: "#2c313c"

                        Rectangle {
                            width: volumeBar.visualPosition * parent.width
                            height: parent.height
                            color: "#bdbebf" 
                            radius: 2
                        }
                }
            handle: Rectangle {
                x: volumeBar.leftPadding + volumeBar.visualPosition * (volumeBar.availableWidth - width)
                y: volumeBar.topPadding + volumeBar.availableHeight / 2 - height / 2
                implicitWidth: 5
                implicitHeight: 15
                color: volumeBar.pressed ? "white" : "black"
                border.color: "#bdbebf"
            }
            }

            TopBarButton {
                id: muteBtn
                width: 40
                height: 40
                anchors.right: volumeBar.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/reduced-volume.png"

                onClicked : {
                    if(player.mute()){
                        muteBtn.btnIconSource = "../../images/png_images/volume-muted.png"
                    }else{
                        muteBtn.btnIconSource = "../../images/png_images/reduced-volume.png"
                    }
                }
            }

            TopBarButton {
                id: fullscreenBtn
                width: 40
                height: 40
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 30
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/fullscreen.png"

                onClicked : fullScreenBtnClicked()

            }

            TopBarButton {
                id: repeatBtn
                width: 40
                height: 40
                anchors.left: fullscreenBtn.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/repeat.png"

                onClicked : {
                    player.changePlaybackMode()
                }
            }

            TopBarButton {
                id: previousBtn
                width: 40
                height: 40
                anchors.left: repeatBtn.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/previous.png"

                onClicked : player.prev()
            }

            TopBarButton {
                id: nextBtn
                width: 40
                height: 40
                anchors.left: previousBtn.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                btnIconSource: "../../images/png_images/next.png"

                onClicked : {
                    player.next()
                }
            }

        }
    }
    



    
    Connections {
        target: player
        

        //PROGRESSBAR

        function onDurationChanged(dur){
            //set progressbar range
            progressBar.from = 0
            progressBar.to = dur
            //set progressbar initial value
            progressBar.value = 0
            
            //minutes and seconds 
            let m = Math.floor(dur/60);
            let s = dur % 60;
            if (m <= 9){ m = '0'+m }
            if (s <= 9){ s = '0'+s }

            //change timestamp
            durationStamp.text = qsTr(m+':'+s)
        }

        
        function onPositionChanged(pos) {
            //new pb position
            progressBar.value = pos
            
            //minutes and seconds 
            let m = Math.floor(pos/60);
            let s = pos % 60;
            if (m <= 9){ m = '0'+m }
            if (s <= 9){ s = '0'+s }

            //change timestamp
            timeStamp.text = qsTr(m+':'+s)
        }

        function onStateChanged(state) {
            if( state == 1){
                playBtn.btnIconSource = "../../images/png_images/pause.png"
            }else{
                playBtn.btnIconSource = "../../images/png_images/play_btn.png"
            }
        }

        
        function onVolumeChanged(volume) {
            if (volume != 0){
                muteBtn.btnIconSource = "../../images/png_images/reduced-volume.png"
            }
            volumeBar.value = volume
        }

        
        function onPlaybackModeChanged(mode) {
            if( mode == 0){
                repeatBtn.btnIconSource = "../../images/png_images/repeat.png"
            }else if( mode == 1 ){
                repeatBtn.btnIconSource = "../../images/png_images/repeat-one.png"
            }else{
                repeatBtn.btnIconSource = "../../images/png_images/repeat-all.png"
            }
        }
    }
    
}







