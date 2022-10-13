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
        anchors.fill: parent
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
            Layout.row: 1
            Layout.column: 1
            Layout.preferredWidth: parent.width/7
        }

    }

}
