import QtQuick 2.15
import QtQuick.Controls 2.15

ComboBox {
    id: comboBox
    
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.leftMargin: 0
    anchors.rightMargin: 0
    anchors.topMargin: 30
    currentIndex: 0

    textRole: "text"
    valueRole: "value"
    

    onPressedChanged: canvas.requestPaint()
    //CUSTOMIZE
    delegate: ItemDelegate {
        width: comboBox.width
        contentItem: Text {
            text: modelData["text"]
            color: highlighted ? "black" : colorText
            font: comboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        highlighted: comboBox.highlightedIndex === index

    }

    indicator: Canvas {
        id: canvas
        x: comboBox.width - width - comboBox.rightPadding
        y: comboBox.topPadding + (comboBox.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = comboBox.pressed ? colorText : "white";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: comboBox.indicator.width + comboBox.spacing

        text: comboBox.displayText
        font: comboBox.font
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
        border.width: comboBox.visualFocus ? 2 : 1

    }

    popup: Popup {
        y: comboBox.height - 1
        width: comboBox.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: comboBox.popup.visible ? comboBox.delegateModel : null
            currentIndex: comboBox.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator { }

        }

        background: Rectangle {
            color: bgMain
            border.color: colorText
            radius: 2
        }
    }



} //end of ComboBox