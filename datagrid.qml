import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Dialogs
import com.myself 1.0
Page {
    id: grid
    GridView {
        id: gridView
        anchors.fill: parent
        cellWidth: width/100
        cellHeight: cellWidth
        model: ListModel {
                    ListElement {
                        name: "Apple"
                        cost: 2.45
                    }
                    ListElement {
                        name: "Orange"
                        cost: 3.25
                    }
                    ListElement {
                        name: "Banana"
                        cost: 1.95
                    }
                }
        delegate : Rectangle {
            //anchors.fill: parent
            width: grid.cellWidth
            height: grid.cellHeight
            color: "red"
            radius: width/2
        }
    }
}
