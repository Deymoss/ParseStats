pragma Singleton
import QtQuick 2.12

Item {
    property int textSize: 20
    property bool lightTheme: true
    property color unpressedButtonColor: lightTheme ? "#505168" : "#24242D"
    property color appBackColor: lightTheme ? "#546e7a" : "#29434e"
    property color pressedButtonColor: lightTheme ? "#27233A" : "#08080D"
    property color slideColorPrimary: lightTheme ? "#C4D6B0" : "#92977E"
    property color slideColorSecondary: lightTheme ? "#EAEFD3" : "#A9AD99"
    property color fontColor: lightTheme ? "black" : "white"
}
