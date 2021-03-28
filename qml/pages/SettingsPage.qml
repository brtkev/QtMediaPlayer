import QtQuick 2.15
import QtQuick.Controls 2.15

import "../control"


Rectangle {
    //CUSTOM PROPERTIES
    property color bgMain: "#2c313c"
    property color bgMenuHolder: "#3a414f"
    property color bgItem: "#1c1d20"
    property color colorText: "#aaacdd"

    
    property string seekAheadValue : seekAheadTextInput.text
    property string seekBackValue : seekBackTextInput.text

    

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
            anchors.topMargin: 30

            Rectangle{
                id: rectangleLeft1
                x: -23
                y: 8

                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
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

            Rectangle {
                id: rectangleLeft4
                x: 34
                y: 146
                height: 40
                color: "#1c1d20"
                border.color: "#1c1d20"
                border.width: 1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: rectangleLeft3.bottom
                anchors.rightMargin: 0
                anchors.topMargin: 30
                anchors.leftMargin: 0
                Label {
                    id: leftLabel4
                    color: colorText
                    text: qsTr("Seconds to jump back")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 10
                }
            }//end of rectangleLeft4

        }

        Rectangle {
            id: columnRight
            x: 380
            width: 120
            height: 200
            color: "#00000000"
            anchors.top: parent.top
            anchors.horizontalCenterOffset: 120
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle{
                id: itemRight1
                y: 0

                border.color: "#aaacdd"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                height: 40
                color: "#2c313c"
                TextInput {
                    id: itemRightTextInput1
                    color: "#aaacdd"
                    text: qsTr("1.0")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter


                    validator: DoubleValidator{
                        top: 2
                        bottom: 0.5
                        decimals: 2
                        notation: DoubleValidator.StandardNotation

                    }

                }

                TopBarButton{
                    width: 10
                    height: 10
                    anchors.topMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: itemRightTextInput1.right
                    anchors.top: parent.top
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/up_btn.png"
                }
                TopBarButton{
                    width: 10
                    height: 10
                    anchors.bottomMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: itemRightTextInput1.right
                    anchors.bottom: parent.bottom
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/down_btn.png"
                }
            }

            ComboBox {
                id: itemRight2
                y: 71
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: itemRight1.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 30
                currentIndex: 0

                textRole: "text"
                valueRole: "value"
                model: [
                    { text: "disabled", value: 0 },
                    { text: "repeat one", value: 1 },
                    { text: "repeat all", value: 2 },
                ]

                //                    ["First", "Second", "Third"]

                onPressedChanged: canvas.requestPaint()
                //CUSTOMIZE
                delegate: ItemDelegate {
                    width: itemRight2.width
                    contentItem: Text {
                        text: modelData["text"]
                        color: highlighted ? "black" : colorText
                        font: itemRight2.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: itemRight2.highlightedIndex === index

                }

                indicator: Canvas {
                    id: canvas
                    x: itemRight2.width - width - itemRight2.rightPadding
                    y: itemRight2.topPadding + (itemRight2.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = itemRight2.pressed ? colorText : "white";
                        context.fill();
                    }
                }

                contentItem: Text {
                    leftPadding: 0
                    rightPadding: itemRight2.indicator.width + itemRight2.spacing

                    text: itemRight2.displayText
                    font: itemRight2.font
                    color: colorText
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 40
                    color: bgMain
                    border.color: colorText
                    border.width: itemRight2.visualFocus ? 2 : 1

                }

                popup: Popup {
                    y: itemRight2.height - 1
                    width: itemRight2.width
                    implicitHeight: contentItem.implicitHeight
                    padding: 1

                    contentItem: ListView {
                        clip: true
                        implicitHeight: contentHeight
                        model: itemRight2.popup.visible ? itemRight2.delegateModel : null
                        currentIndex: itemRight2.highlightedIndex
                        ScrollIndicator.vertical: ScrollIndicator { }

                    }

                    background: Rectangle {
                        color: bgMain
                        border.color: colorText
                        radius: 2
                    }
                }



            } //end of ComboBox
            Rectangle{
                id: seekAheadSetting
                y: 0

                border.color: "#aaacdd"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: itemRight2.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 30
                height: 40
                color: "#2c313c"
                TextInput {
                    id: seekAheadTextInput
                    color: "#aaacdd"
                    text: qsTr("10")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    validator: DoubleValidator{
                        top: 60
                        bottom: 1
                        decimals: 0
                        notation: DoubleValidator.StandardNotation

                    }
                }

                TopBarButton{
                    width: 10
                    height: 10
                    anchors.topMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: seekAheadTextInput.right
                    anchors.top: parent.top
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/up_btn.png"
                }
                TopBarButton{
                    width: 10
                    height: 10
                    anchors.bottomMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: seekAheadTextInput.right
                    anchors.bottom: parent.bottom
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/down_btn.png"

                }
            }//end of Rectangle

            Rectangle{
                id: seekBackItem
                y: 0

                border.color: "#aaacdd"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: seekAheadSetting.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 30
                height: 40
                color: "#2c313c"
                TextInput {
                    id: seekBackTextInput
                    color: "#aaacdd"
                    text: qsTr("10")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                TopBarButton{
                    width: 10
                    height: 10
                    anchors.topMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: seekBackTextInput.right
                    anchors.top: parent.top
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/up_btn.png"
                }
                TopBarButton{
                    width: 10
                    height: 10
                    anchors.bottomMargin: 5
                    anchors.leftMargin: 30
                    imageSize: 10
                    anchors.left: seekBackTextInput.right
                    anchors.bottom: parent.bottom
                    btnColorDefault: "#00000000"
                    btnIconSource: "../../images/png_images/down_btn.png"

                }
            }//end of Rectangle
        }


    }
    Connections{
        target: backend

        


    }

}



