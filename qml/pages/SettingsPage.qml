import QtQuick 2.15
import QtQuick.Controls 2.15

import "../control"
import "components"


Rectangle {
    //CUSTOM PROPERTIES
    property color bgMain: "#2c313c"
    property color bgMenuHolder: "#3a414f"
    property color bgItem: "#1c1d20"
    property color colorText: "#aaacdd"

    
    signal playbackSpeedChanged(real speedValue)
    signal repeatStateChanged(int state)
    signal seekValueChanged(int seekValue)
    
    
    
    

    id: menuHolder
    x: 0
    y: 0
    width: 600
    height: 378
    color: "#1c1d20"

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    Flickable{
        id: flickable
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Rectangle {
            id: columnLeft
            x: 145
            width: 120
            height: 200
            color: "#00000000"
            anchors.top: parent.top
            anchors.horizontalCenterOffset: -120
            anchors.horizontalCenter: parent.horizontalCenter
            

            Rectangle{
                id: rectangleLeft1
                x: -23
                y: 8

                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 60
                border.color: "#1c1d20"
                border.width: 1
                anchors.left: parent.left
                anchors.right: parent.right
                height: 40
                color: "#1c1d20"
                Label {
                    id: leftLabel1


                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Playback Speed")
                    anchors.verticalCenter: parent.verticalCenter
                    color: colorText

                }

            }

            Rectangle {
                id: rectangleLeft2
                x: -3
                y: 8
                height: 40
                color: "#1c1d20"
                border.color: "#1c1d20"
                border.width: 1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleLeft1.bottom
                anchors.rightMargin: 0
                anchors.topMargin: 30
                anchors.leftMargin: 0
                Label {
                    id: leftLabel2
                    color: colorText
                    text: qsTr("repeat")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 10
                }
            }

            Rectangle {
                id: rectangleLeft3
                x: 34
                y: 146
                height: 40
                color: "#1c1d20"
                border.color: "#1c1d20"
                border.width: 1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleLeft2.bottom
                anchors.rightMargin: 0
                anchors.topMargin: 30
                anchors.leftMargin: 0
                Label {
                    id: leftLabel3
                    color: colorText
                    text: qsTr("Seconds to jump ahead")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 10
                }
            }

        }

        Rectangle {
            id: columnRight
            x: 380
            width: 120
            height: 200
            color: "#00000000"
            anchors.top: parent.top
            anchors.horizontalCenterOffset: 120
            // anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            SettingsComboBox{
                id : itemRight1
                anchors.topMargin: 60
                currentIndex : 3
                
                model: [
                    { text: "2.0", value: 2.0 },
                    { text: "1.5", value: 1.5 },
                    { text: "1.25", value: 1.25 },
                    { text: "1.0", value: 1.0 },
                    { text: "0.75", value: 0.75 },
                    { text: "0.5", value: 0.5 },
                ]

                onActivated : {
                    playbackSpeedChanged(itemRight1.currentValue)
                    player.setPlaybackRate(itemRight1.currentValue)
                }
            }

            SettingsComboBox{
                id : itemRight2
                anchors.top: itemRight1.bottom

                model: [
                    { text: "disabled", value: 0 },
                    { text: "repeat one", value: 1 },
                    { text: "repeat all", value: 2 },
                ]

                onActivated : {
                    repeatStateChanged(itemRight2.currentValue)
                    player.setPlaybackMode(itemRight2.currentValue)
                }
            }

            SettingsComboBox{
                id : itemRight3
                anchors.top: itemRight2.bottom

                model: [
                    { text: "10", value: 10 },
                    { text: "20", value: 20 },
                    { text: "30", value: 30 },
                    { text: "60", value: 60 },
                    { text: "120", value: 120 },
                ]

                onActivated : seekValueChanged(itemRight3.currentValue)
            }


        }


    }
    Connections{
        target: player
    }

}



