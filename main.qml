import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtMultimedia 5.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs
import com.myself 1.0
ApplicationWindow {
    width: 1280
    height: 720
    visible: true
    property var allResults: []
    Connections {
        target: obj
        onSendData: {
            data.forEach((one) => {
             allResults.push(one)
             })

            console.log(allResults)
            console.log(allResults.length)
        }
    }

    Provider {
        id: obj
        objectName: "object"
    }
    background: Rectangle {
        color: "#1A7A63"
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
            color: parseButton.pressed ? "#002B70" : "#2973B8"
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
        }
        width: parent.width
        height: parent.height
        Item {
            id: gridPage
            Rectangle {
                anchors.fill: parent
                color: "#2973B8"
            }
        }
        Item {
            id: chartsPage
            Rectangle {
                anchors.fill: parent
                color: "#9C4529"
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
            color: "#000000"
            opacity: 0.3
        }
    }
}
