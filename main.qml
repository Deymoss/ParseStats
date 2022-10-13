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

    Provider {
        id: obj
        objectName: "object"
    }

    Component {
        id: statPg
        StatisticsPage{}
    }
    Component {
        id: menuPg
        MenuPage{}
    }
    StackView {
        id: stack
        anchors.fill: parent
        initialItem: menuPg
        focus: true

    }

}
