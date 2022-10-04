import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtMultimedia 5.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs
import com.myself 1.0
import QtQuick.Shapes 1.4
import QtQuick.Controls.Material 2.3
import Style 1.0
ApplicationWindow {
    id: theWindow
    width: 1280
    height: 720
    visible: true
    property double topCoef: 1.322
    property double bottomLenght: 0
    property double screenStep: (theWindow.height / 2) / (theWindow.width / 4.9)
    property int value: theWindow.width / 2
    onValueChanged: {
        if(value > theWindow.width / 2) {
            choseRect.state = "leftOption"
        } else if(value < theWindow.width / 2) {
            choseRect.state = "rightOption"
        }
        rightCanvas.requestPaint()
    }
    Behavior on value {
        NumberAnimation {
            duration: 500
        }
    }
    Provider {
        id: obj
        objectName: "object"
    }

    Component {
        id: statPg
        StatisticsPage{}
    }

    Rectangle {
        id: choseRect
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }

        width: parent.width
        Canvas{
            id: rightCanvas
            anchors.fill: parent
            Text {
                id: statsEntery
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: parent.width/4
                }
                font.pointSize: Style.richTextSize
                font.bold: true
                color: "White"
                font.family: "Monsterrat"
                text: "STATISTICS"
            }
            Text {
                id: botEntery
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: parent.width/4
                }
                font.pointSize: Style.richTextSize
                font.bold: true
                color: "White"
                font.family: "Monsterrat"
                text: "SEEK BOT"
            }

            onPaint:{
                var context = getContext("2d");

                // the triangle
                context.beginPath();
                context.moveTo(0.0);
                context.lineTo(value + parent.width / 4.9, 0);
                context.lineTo(value - parent.width / 4.9, parent.height);
                context.lineTo(0, parent.height);
                context.lineTo(0,0);
                context.closePath();

                // the fill color
                context.fillStyle = "#08415C";
                context.fill();
                context.beginPath();
                context.moveTo(parent.width, 0);
                context.lineTo(value + parent.width / 4.9, 0);
                context.lineTo(value - parent.width / 4.9, parent.height);
                context.lineTo(parent.width, parent.height);
                context.lineTo(parent.width, 0);
                context.closePath();

                // the fill color
                context.fillStyle = "#CC2936";
                context.fill();
            }
            onContextChanged: requestPaint()

            MouseArea {
                property int halfOfHeight: parent.height / 2
                property double xtoy: mouseY < parent.height / 2? (halfOfHeight - mouseY)/1.37 : ((mouseY - halfOfHeight)/1.37) * (-1)
                anchors.fill: parent
                hoverEnabled: true
                onPositionChanged: {
                    if(mouseX > value + xtoy){
                        value = parent.width / 4.96
                    } else if(mouseX < value + xtoy){
                        value = parent.width / 1.26
                    }
                }

                //                onEntered: {
                //                    if(mouseX > value + parent.width / 4.9) {
                //                        value = parent.width / 4.96
                //                    } else if(mouseX < value + parent.width / 4.9) {
                //                        value = parent.width / 1.26
                //                    }
                //                }

                onClicked: {
                    value = parent.width / 1.26
                    console.log(screenStep)
                }
            }
        }
        states:[ State {
                name: "leftOption"
                PropertyChanges {target: statsEntery; anchors.leftMargin: theWindow.width / 3}
                PropertyChanges {target: botEntery; anchors.rightMargin: theWindow.width / 10}
                PropertyChanges {target: botEntery; opacity: 0}
            },
            State {
                name: "rightOption"
                PropertyChanges {target: statsEntery; anchors.leftMargin: theWindow.width / 10}
                PropertyChanges {target: botEntery; anchors.rightMargin: theWindow.width / 3}
                PropertyChanges {target: statsEntery; opacity: 0}
            }]
        transitions: [ Transition {
                from: "*"
                to: "rightOption"
                NumberAnimation { property: "anchors.rightMargin"; duration: 200}
                NumberAnimation { property: "anchors.leftMargin"; duration: 200}
                NumberAnimation { property: "opacity"; duration: 200}
            },
            Transition {
                from: "*"
                to: "leftOption"
                NumberAnimation { property: "anchors.leftMargin"; duration: 200}
                NumberAnimation { property: "anchors.rightMargin"; duration: 200}
                NumberAnimation { property: "opacity"; duration: 200}
            }]
    }

    background: Rectangle {
        color: Style.appBackColor
    }

}
