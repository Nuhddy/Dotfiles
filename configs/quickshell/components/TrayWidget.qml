import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

RowLayout {
    Repeater {
        model: SystemTray.items
        IconImage {
            required property SystemTrayItem modelData
            source: modelData.icon
            implicitSize: 15
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                onClicked: e => {
                    if (e.button == Qt.LeftButton) parent.modelData.activate();
                }
            }
        }
    }
}
