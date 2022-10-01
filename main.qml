import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtMultimedia 5.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs
import com.myself 1.0
import QtQuick.Shapes 1.4
ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    property var allResults: []
    property int currentPos: 0
    Connections {
        target: obj
       function onSendData(data) {
            data.forEach((one) => {
             allResults.push(one)
             griddate.processingVisible = true
             timer.start()
             })
        }
    }
    Timer {
        id: timer
        interval: 10
        repeat: true
        running: false
        onTriggered: {
            if(allResults.length > currentPos) {
            griddate.modelL.append({col: allResults[currentPos] === true? "#CC0000" : "black"})
                currentPos++
            } else {
                stop()
                allResults = []
                griddate.processingVisible = false
            }
        }

    }
    Provider {
        id: obj
        objectName: "object"
    }

    Component {
        id: gridData
        DataGrid{}
    }
    Component {
        id: chartsPg
        ChartStatistics{}
    }
    background: Rectangle {
        color: "#5d8c96"
    }
    Button {
        id: parseButton
        width: parent.width/ 2
        height: parent.height/12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle {
            anchors.fill: parent
            radius: 5
            color: parseButton.pressed ? "#5f0c16" : "#95242a"
        }
        onClicked: {
            obj.takeData(genderBox.currentValue)
        }

        text: "PARSE DATA"
        font.family: "Montserrat"
        font.pointSize: 15
        font.bold: true
    }
    SwipeView {
        id: view
        clip: true
        currentIndex: 0
        anchors {
            top: genderBox.bottom
            bottom: parseButton.top
            left: parent.left
            right: parent.rigth
            bottomMargin: 20
            topMargin: 10
        }
        width: parent.width
        height: parent.height
        Item {
        DataGrid {
            id: griddate
            anchors.fill: parent
            }
        }
        Item {
            ChartStatistics {
                id: chartsPag
                anchors.fill: parent
            }
        }
    }
    Text {
        id: comboText
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: genderBox.verticalCenter
        font.pointSize: 18
        font.family: "Montserrat"
        text: "Chose a data selection: "
    }

    ComboBox {
        id: genderBox
        anchors.top: parent.top
        anchors.left: comboText.right
        anchors.leftMargin: 10
        anchors.topMargin: 10
        height: parent.height / 12
        width: parent.width / 4
        model: [100, 1000, 10000, 100000]
        font.pointSize: 18
        font.family: "Montserrat"
        Text{
            id: genderText
            anchors{
                bottom: parent.top
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 10
            }
            font.pointSize: 16
            font.family: "Montserrat"
            font.bold: true
            color: "white"
        }
        delegate: ItemDelegate {
            width: genderBox.width
            height: genderBox.height/1.3
            contentItem: Text {
                text: modelData
                color: "white"
                font.family: "Montserrat"
                font.pointSize: 16
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            background: Rectangle {
                anchors.fill: parent
                color: "#264F87"
                border.width: 1
                border.color: "#271455"
            }
        }
        popup: Popup {
            y: genderBox.height - 1
            width: genderBox.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: genderBox.popup.visible ? genderBox.delegateModel : null
                currentIndex: genderBox.highlightedIndex

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                color: "#271455"
            }
        }
        background:Rectangle {
            anchors.right: parent.right
            width: parent.width
            height: parent.height
            radius: 13
            color: "#95242a"
            opacity: 0.7
        }
    }
}
