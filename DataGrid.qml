import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs
import com.myself 1.0
Page {
    id: grid
    property alias gridV: gridView
    property alias modelL: resultModel
    property bool processingVisible: false
    background: Rectangle {
        anchors.fill: parent
        color: "#996699"
    }
    Rectangle {
        id: loadingRect
        anchors.fill: parent
        z:999
        color: "black"
        opacity: 0.5
        visible: processingVisible
        Text {
            color: "#ffffff"
            anchors.centerIn: parent
            font.pixelSize: parent.height/10
            font.bold: true
            styleColor: "#ffffff"
            text: "Proccessing, Wait..."
        }
    }

    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: parent.width/80
        cellHeight: cellWidth
        model: resultModel
        delegate : numberDelegate
    }

    Component {
        id: numberDelegate
        Rectangle {
            id: circl
            //anchors.fill: parent
            width: gridView.cellWidth
            height: gridView.cellHeight
            color: col
            radius: width/2
            GridView.onAdd: SequentialAnimation {
                NumberAnimation {target: circl; property: "scale"; from: 0; to: 1; duration: 5; easing.type: Easing.InOutQuad }
            }
        }

    }


    ListModel {
        id: resultModel
    }
}

