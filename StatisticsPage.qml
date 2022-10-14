import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtMultimedia 5.15
import QtQuick.Dialogs
import QtQuick.Layouts
import com.myself 1.0
import QtQuick.Shapes 1.4
import QtQuick.Controls.Material 2.3
import Style 1.0
Page {
    id: statPg
    property double gridCount
    property var allResults: []
    property int currentPos: 0
    background: Rectangle {
        color: Style.appBackColor
    }
    Connections {
        target: obj
        function onSendData(data) {
            data.forEach((one) => {
                             allResults.push(one)
                             griddate.processingVisible = true
                             if(Style.animations === true) {
                                 timer.start()
                                 parseButton.enabled = false
                             } else {
                                 griddate.modelL.append({col: one === true? "#CC0000" : "black"})
                             }

                         })
            if(allResults.length >= genderBox.currentValue && Style.animations === false) {
                 griddate.processingVisible = false
            }
        }
    }
    Component {
        id: gridData
        DataGrid{}
    }
    Component {
        id: chartsPg
        ChartStatistics{}
    }
    Component {
        id: settingsDlg
        SettingsDialog{}
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
                loadingRect.width = 0
                buttonText.text = "PARSE DATA"
                parseButton.enabled = true
                griddate.processingVisible = false
            }
        }
    }


    Rectangle {
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: genderBox.verticalCenter
        }
        height: parent.height / 14
        width: height
        radius: height / 2
        Image {
            height: parent.height / 1.3
            width: height
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/imgs/icons/settings.png"
        }
        color: settingsArea.pressed ? "#8F000000" : "#4F000000"
        //        Image {
        //            height: parent.height / 1.3
        //            width: height
        //            anchors.centerIn: parent
        //            fillMode: Image.PreserveAspectFit
        //            source: Style.lightTheme ? "qrc:/imgs/icons/light.png" : "qrc:/imgs/icons/dark.png"
        //        } Style.lightTheme ? Style.lightTheme = false : Style.lightTheme = true
        MouseArea {
            id: settingsArea
            anchors.fill: parent
            onClicked: settingsDialog.open()
        }
    }

    SettingsDialog {
        id: settingsDialog
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
            color: parseButton.pressed ? Style.pressedButtonColor : Style.unpressedButtonColor
        }
        onClicked: {
            obj.takeData(genderBox.currentValue)
        }
        Rectangle {
            id: loadingRect
            height: parent.height
            anchors.centerIn: parent
            width: Style.animations === true ? parent.width * gridCount : 0
            radius: 10
            color: Style.loadingColor
        }

        contentItem: Text {
            id: buttonText
            font.family: "Montserrat"
            text: "PARSE DATA"
            z: 100
            font.pixelSize: parent.height / 3
            font.bold: true
            color: Style.fontColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

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
                gridV.onCountChanged: {
                    if(gridV.count <= genderBox.currentValue && Style.animations === true) {
                        gridCount = gridV.count / genderBox.currentValue
                        buttonText.text = gridV.count + "/" + genderBox.currentValue + " Completed"
                    }
                }
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
        anchors.leftMargin: parent.width / 3
        anchors.verticalCenter: genderBox.verticalCenter
        font.pointSize: 16
        color: Style.fontColor
        font.family: "Montserrat"
        text: "Data selection: "
    }


    ComboBox {
        id: genderBox
        anchors.top: parent.top
        anchors.left: comboText.right
        anchors.leftMargin: 10
        anchors.topMargin: 5
        height: parent.height / 14
        width: parent.width / 4
        model: [100, 1000, 10000, 100000]
        font.pointSize: 20
        font.family: "Montserrat"
        Material.foreground: Style.fontColor
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
            color: Style.fontColor
        }
        delegate: ItemDelegate {
            width: genderBox.width
            height: genderBox.height/1.3
            contentItem: Text {
                text: modelData
                color: Style.fontColor
                font.family: "Montserrat"
                font.pointSize: 16
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            background: Rectangle {
                anchors.fill: parent
                color: Style.unpressedButtonColor
                border.width: 1
                border.color: Style.pressedButtonColor
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
                color: Style.appBackColor
            }
        }
        background:Rectangle {
            anchors.right: parent.right
            width: parent.width
            height: parent.height
            radius: 5
            color: Style.unpressedButtonColor
            opacity: 0.7
        }
    }
}
