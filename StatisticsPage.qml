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
    property string notificationMessage: " "
    property string currentDate: obj.currentDate()
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
            if(allResults.length >= dataBox.currentValue && Style.animations === false) {
                griddate.processingVisible = false
            }
            obj.subDate()
            currentDate = obj.addDate()

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
                loadingRect.width = 0
                buttonText.text = "PARSE DATA"
                parseButton.enabled = true
                griddate.processingVisible = false
            }
        }
    }
    Timer {
        id: notifyTimer
        interval: 4000
        running: false
        repeat: false
        onTriggered: {
            notification.state = "hide"
        }
    }


    Rectangle {
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: dataBox.verticalCenter
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
            if(Date.fromLocaleString(Qt.locale(),currentDate,"dd.MM.yyyy") > Date.fromLocaleString(Qt.locale(),obj.currentDate(), "dd.MM.yyyy"))
            {
                notificationMessage = "Ooops... it's no data here \nPlease, set today or earlier day."
                notification.state = "show"
                notifyTimer.start()
            } else {
                obj.takeData(dataBox.currentValue)
            }
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
            top: dataBox.bottom
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
                    if(gridV.count <= dataBox.currentValue && Style.animations === true) {
                        gridCount = gridV.count / dataBox.currentValue
                        buttonText.text = gridV.count + "/" + dataBox.currentValue + " Completed"
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
        id: dateText
        anchors.top: parent.top
        anchors.horizontalCenter: dateLine.horizontalCenter
        font.pointSize: 16
        horizontalAlignment: Text.AlignHCenter
        color: Style.fontColor
        font.family: "Montserrat"
        style: Text.Raised
        verticalAlignment: Text.AlignVCenter
        text: "Start date: "
    }

    Rectangle {
        id:dateLine
        height: parent.height / 14
        width: parent.width / 4
        anchors {
            left: dataBox.right
            top: dateText.bottom
            leftMargin: parent.width / 9
            topMargin: 5
        }
        radius: 0
        color: Style.unpressedButtonColor
        opacity: 1
        Rectangle {
            id: leftArrow
            anchors {
                right: parent.left
                verticalCenter: parent.verticalCenter
                rightMargin: -5
            }
            Rectangle {
                anchors {
                    right:parent.right
                    verticalCenter: parent.verticalCenter
                }
                height: parent.height
                width: 1
                color: Style.fontColor
            }

            width: height
            height: parent.height
            color: leftArrowArea.pressed ? Style.pressedButtonColor : Style.unpressedButtonColor
            radius: 7
            Image {
                anchors.centerIn: parent
                height: parent.height / 1.2
                width: height
                source: Style.lightTheme ? "qrc:/imgs/icons/leftArrow.png" : "qrc:/imgs/icons/leftArrow_night.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
            MouseArea {
                id: leftArrowArea
                anchors.fill: parent
                onClicked: {
                    currentDate = obj.subDate();
                }
            }
        }

        Rectangle {
            id: rightArrow
            anchors {
                left: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: -5
            }
            Rectangle {
                anchors {
                    left:parent.left
                    verticalCenter: parent.verticalCenter
                }
                height: parent.height
                width: 1
                color: Style.fontColor
            }
            width: height
            height: parent.height
            color: rightArrowArea.pressed ? Style.pressedButtonColor : Style.unpressedButtonColor
            radius: 7
            Image {
                anchors.centerIn: parent
                height: parent.height / 1.2
                width: height
                source: Style.lightTheme ? "qrc:/imgs/icons/rightArrow.png" : "qrc:/imgs/icons/rightArrow_night.png"
                fillMode: Image.PreserveAspectFit
                smooth: true
                antialiasing: true
            }
            MouseArea {
                id: rightArrowArea
                anchors.fill: parent
                onClicked: {
                    currentDate = obj.addDate();

                }
            }
        }
        Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: parent.height / 2
            anchors.centerIn: parent
            color: Style.fontColor
            text: currentDate
        }
    }

    Text {
        id: comboText
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.horizontalCenter: dataBox.horizontalCenter
        font.pointSize: 16
        horizontalAlignment: Text.AlignHCenter
        color: Style.fontColor
        font.family: "Montserrat"
        style: Text.Raised
        verticalAlignment: Text.AlignVCenter
        text: "Data selection: "
    }


    ComboBox {
        id: dataBox
        anchors.top: comboText.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
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
            width: dataBox.width
            height: dataBox.height/1.3
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
            y: dataBox.height - 1
            width: dataBox.width
            implicitHeight: contentItem.implicitHeight
            padding: 1

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: dataBox.popup.visible ? dataBox.delegateModel : null
                currentIndex: dataBox.highlightedIndex

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


    Rectangle {
        id: notification
        radius: 15
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: -parent.height / 10
        }
        Text{
            id: notificationHeader
            font.family: "Montserrat"
            font.pixelSize: parent.height / 3.5
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "Notification"
            color: "white"
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: parent.height / 20
            }

        }
        Text{
            id: notificationText
            font.family: "Montserrat"
            font.pixelSize: parent.height / 4.5
            font.bold: false
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: notificationMessage
            color: "white"
            anchors {
                top: notificationHeader.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: parent.height / 40
            }

        }
        width: parent.width / 3
        height: parent.height/10
        opacity: 1
        color: "#8F000000"
        states:[ State {
                name: "show"
                PropertyChanges {
                    target: notification
                    anchors.topMargin: parent.height / 10
                    opacity: 1
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: notification
                    anchors.topMargin: -parent.height / 10
                    opacity: 0
                }
            }
        ]
        transitions: [ Transition {
                from: "*"
                to: "show"
                NumberAnimation { property: "anchors.topMargin"; duration: 200}
                NumberAnimation { property: "opacity"; duration: 200}

            },
            Transition {
                from: "*"
                to: "hide"
                NumberAnimation { property: "anchors.topMargin"; duration: 200}
                NumberAnimation { property: "opacity"; duration: 200}

            }]
    }
}
