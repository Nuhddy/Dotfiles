import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            color: root.colMantle
            implicitHeight: 30
            anchors {
                top: true
                left: true
                right: true
            }

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }

                // Left
                RowLayout {
                    Item { Layout.fillWidth: true } // left-align dummy
                }

                // Center
                RowLayout {
                    anchors.centerIn: parent
                }

                // Right
                RowLayout {
                    Item { Layout.fillWidth: true } // right-align dummy
                    TrayWidget { layoutDirection: Qt.RightToLeft }
                    BatteryWidget {}
                    ClockWidget {}
                }
            }
        }
    }
}
