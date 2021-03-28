import QtQuick 2.0
import QtQuick.Controls 2.15

import "../control"
import Player 1.0


Rectangle {
    
    id: mainRectangle

    property color bgMain: "#2c313c"
    property int verticalMargin: 0
    property int horizontalMargin : 0
    property real aspectRatio : 1

    color: bgMain

    
    
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.rightMargin: horizontalMargin
    anchors.leftMargin: horizontalMargin
    anchors.bottomMargin: verticalMargin
    anchors.topMargin: verticalMargin
    
    
    

    function adaptSize(){

        let w = parent.height * aspectRatio
        let h = parent.width / aspectRatio

        if( parent.height - h >= 0){
            horizontalMargin = 0
            verticalMargin = (parent.height - h ) / 2
        }else if (parent.width - w >= 0){
            verticalMargin = 0
            horizontalMargin = (parent.width - w ) / 2
        } 
    }


    ImageDisplay{
        id: imageDisplay 
        anchors.fill: parent
    }



    Image {
        id: image
        x: 270
        y: 210
        width: 100
        height: 100
        anchors.verticalCenter: parent.verticalCenter
        source: "../../images/png_images/play_screen.png"
        sourceSize.height: 768
        sourceSize.width: 768
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        visible: false
    }


    Connections {
    
        target: player

        function onAspectRatioChanged(ar){
            aspectRatio = ar
            adaptSize()
        }

        
    
    }


}








/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
