pragma Singleton
import QtQuick 2.12

Item {
    property int textSize: 20
    property int richTextSize: 30
    property bool lightTheme: true
    property bool animations: true
    //statistics colors
    property color unpressedButtonColor: lightTheme ? "#505168" : "#054461"
    property color appBackColor: lightTheme ? "#5F6EC2" : "#052838"
    property color pressedButtonColor: lightTheme ? "#27233A" : "#08080D"
    property color slideColorPrimary: lightTheme ? "#95AAC9" : "#56525C"
    property color slideColorSecondary: lightTheme ? "#DAA9AF" : "#A9AD99"
    property color loadingColor: lightTheme ? "#9E9FB5" : "#1A7FAD"
    property color fontColor: lightTheme ? "black" : "white"
    property color dialogHeader: lightTheme ? "#323F85" : "black"
    //bot colors

}
