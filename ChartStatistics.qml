import QtQuick 2.12
import QtQuick.Window 2.15
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtCharts
import QtQuick.Layouts 1.3
Page {
    background: Rectangle {
        anchors.fill: parent
        color: "#666666"
    }
    ChartView {
        id:chart4_id
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        width: parent.width / 2
        height: width / 1.5
        backgroundColor: "transparent"
        //legend.visible: false
        antialiasing: true
        layer.enabled: true
        legend.font.pixelSize: 20
        legend.font.bold: true

        layer.effect: Glow { color: "#0266E5";  transparentBorder: true; radius: 10; spread:.1 }
        animationDuration : 2000
        animationOptions: ChartView.AllAnimations;
        // animationEasingCurve.bezierCurve : [ 0.2, 0.2, 0.13, 0.5, 0.3, 0.8, 0.624, 0.98, 0.93, 0.95, 1, 1 ]

        PieSeries {
            size: 1
            id: pieInner
            holeSize: 0.7
            PieSlice { label: "Materials"; value: 10334; color: "#FDFC88" ;borderColor: "#FDFC88";}
            PieSlice { label: "Employee"; value: 3066; color: "#FD2222" ;borderColor: "#FD2222";}
            PieSlice { label: "Logistics"; value: 6111; color: "#09C4F6";borderColor:  "#09C4F6"; }
        }
    }
    ChartView {
      anchors {
          right: parent.right
          verticalCenter: parent.verticalCenter
      }
      width: parent.width/2
      height: width / 1.5
      backgroundColor: "transparent"
      legend.visible: true
      antialiasing: true
      legend.font.pixelSize: 20
      legend.font.bold: true
      layer.enabled: true
      layer.effect: Glow { color: "#18F3F2";  transparentBorder: true; radius: 5; spread:.1 }
      animationDuration : 5000
      animationOptions: ChartView.AllAnimations;
      BarSeries {
              id: mySeries
              labelsVisible:false
              axisY: ValueAxis{  min: 0; max: 100 ;  visible: true ;gridLineColor :"#5515bdff";color :"#FF3333";labelsVisible:true;}
              axisX: BarCategoryAxis {
                  gridVisible:false
                  gridLineColor:"transparent"
                  labelsVisible:true;
              }
              BarSet { label: "Bob"; values: [20, 20, 30, 40, 50, 60]; borderColor: "#55ffffff"; color: "#FFCC33";}
              BarSet { label: "Susan"; values: [50, 10, 20, 40, 10, 70] ; borderColor: "transparent";color: "#6633CC";}
              BarSet { label: "James"; values: [30, 50, 80, 13, 50, 80] ; borderColor: "transparent";color: "#33CC33";}
          }
    }
}
