import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs
import QtQuick.Layouts
import QtQuick.Controls.Material 2.3
import Style 1.0

Dialog {
    id: settingDialog
    anchors.centerIn: parent
    height: parent.height / 3
    width: parent.width / 3
    background: Rectangle {
        anchors.fill: parent
        radius: parent.width / 10
        color: Style.appBackColor
    }
    GridLayout {
        id: settingsLayout
        anchors.top: parent.top
        anchors.bottom: drawer.top
        anchors.left: parent.left
        anchors.right: parent.right
        columns: 2
        rowSpacing: 5
        Text {
            font.family: "Montserrat"
            text: "Choose theme: "
            font.bold: true
            color: Style.fontColor
            font.pointSize: 15
            Layout.row: 0
            Layout.column: 0
            Layout.preferredWidth: parent.width/2
        }
        Rectangle {
            color: themeArea.pressed ? "#8F000000" : "#4F000000"
            radius: height / 2
            Image {
                height: parent.height / 1.3
                width: height
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: Style.lightTheme ? "qrc:/imgs/icons/light.png" : "qrc:/imgs/icons/dark.png"
            }
            MouseArea {
                id: themeArea
                anchors.fill: parent
                onClicked: Style.lightTheme ? Style.lightTheme = false : Style.lightTheme = true
            }
            Layout.row: 0
            Layout.column: 1
            Layout.preferredWidth: parent.width/7
            Layout.preferredHeight: width
        }
        Text {
            font.family: "Montserrat"
            text: "Animations: "
            font.bold: true
            color: Style.fontColor
            font.pointSize: 15
            Layout.row: 1
            Layout.column: 0
            Layout.preferredWidth: parent.width/2
        }
        Switch {
            id: animSwitch
            Layout.row: 1
            Layout.column: 1
            Layout.preferredWidth: parent.width/7
            checked: true
            onToggled: {
                Style.animations = animSwitch.checked ? true : false
            }
        }
    }
    //This rectangle need for perfect button positioning
    Rectangle {
        id: drawer
        width: 1
        height: parent.height/5
        color: "black"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: acceptButton
        width: parent.width / 2.5
        height: parent.height / 5
        anchors.bottom: parent.bottom
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.left: drawer.right
        anchors.verticalCenter: drawer.verticalCenter
        background: Rectangle {
            anchors.fill: parent
            radius: 5
        }
        Text {
            id: acceptText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: acceptButton.pressed ? "#EC814D" : "white"
            text: "ACCEPT"
            font.family: "Montserrat"
            font.pointSize: 15
            font.bold: true
        }

    }
    Button {
        id: declineButton
        width: parent.width / 2.5
        height: parent.height / 5
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.right: drawer.left
        anchors.left: parent.left
        anchors.verticalCenter: drawer.verticalCenter
        background: Rectangle {
            anchors.fill: parent
            radius: 15
        }
        Text {
            id: declineText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: declineButton.pressed ? "#EC814D" : "white"
            text: "DECLINE"
            font.family: "Montserrat"
            font.pointSize: 15
            font.bold: true
        }
    }

}
