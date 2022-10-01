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

    property var stats: []
    property var otherSlice
    property var otherBar
    property var updatedStats: []
    Connections {
        target: obj
        function onEndOfProcess() {
            stats = obj.takeStats()
            console.log(stats)
            for(var i = 0; i < stats.length; i++) {
                if(stats[i] > 0) {
                    otherSlice =  pieInner.append(i+" in a row", stats[i])
                    otherSlice.color = Qt.hsva(Math.random(),1,0.7,1);
                    lineSeries.append(i,stats[i])
                    updatedStats.push(stats[i])
//                    qwe.append(stats[i])
//                    qwe.color = Qt.hsva(Math.random(),1,0.7,1);
                }
            }

            console.log(updatedStats)
        }
    }

    ChartView {
        id:chartView
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        width: parent.width / 2
        height: parent.height / 1.1
        backgroundColor: "transparent"
        ToolTip {
            id: tip
            anchors.centerIn: parent
            contentItem: Text{
                color: "white"
                text: tip.text
            }

            background: Rectangle {
                color: "black"
                radius: 10
            }
        }
        legend.visible: false

        antialiasing: true
        layer.enabled: true
        legend.enabled: false
        layer.effect: Glow { color: "#0266E5";  transparentBorder: true; radius: 3; spread:.1 }
        animationDuration : 1000
        animationOptions: ChartView.AllAnimations;
        // animationEasingCurve.bezierCurve : [ 0.2, 0.2, 0.13, 0.5, 0.3, 0.8, 0.624, 0.98, 0.93, 0.95, 1, 1 ]

        PieSeries {
            size: 0.85
            id: pieInner
            holeSize: 0.4
            onHovered: {
                if(state) {
                    slice.exploded = true
                    tip.show(slice.label + ":" + slice.value)
                    slice.borderWidth = 5
                } else {
                    slice.exploded = false
                    slice.borderWidth = 1
                    tip.hide()
                }
            }
        }
    }
    ChartView {
      id:lineChart
      anchors {
          right: parent.right
          verticalCenter: parent.verticalCenter
      }
      width: parent.width/2
      height: width / 1.5
      backgroundColor: "transparent"
      legend.visible: false
      antialiasing: true
      layer.enabled: true
      layer.effect: Glow { color: "red";  transparentBorder: true; radius: 5; spread:.1 }
       animationDuration : 3000
       animationOptions: ChartView.AllAnimations;
       ToolTip {
           id: id_tooltip
           contentItem: Text{
               color: "#21be2b"
               text: id_tooltip.text
           }
           background: Rectangle {
               border.color: "#21be2b"
           }
       }
     //  animationEasingCurve.bezierCurve : [ 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.78, 0.93, 0.95, 1, 1 ]
      LineSeries {
          id:lineSeries
                  axisX: ValueAxis{  min: 0; max: 20 ;  visible: true ;color :"#00ffffff";labelsColor :"#22ffffff";labelsVisible:false; gridVisible:false;}
                  axisY: ValueAxis{  min: 0; max: 100 ;  visible: true ;gridLineColor :"#5515bdff";color :"#00ffffff";labelsVisible:false;}
                  width:2
                  color: "#f00"
                  onHovered: {
                      var p = lineChart.mapToPosition(point)
                       var text = qsTr("x: %1, y: %2").arg(new Date(point.x).toLocaleDateString(Qt.locale("en_US"))).arg(point.y)
                       id_tooltip.x = p.x
                       id_tooltip.y = p.y - id_tooltip.height
                       id_tooltip.text = text
                       //id_tooltip.timeout = 1000
                       id_tooltip.visible = true
                  }
       }
    }
}
