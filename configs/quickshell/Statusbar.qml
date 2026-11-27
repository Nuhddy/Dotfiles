import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.services

RowLayout {
  readonly property int dotSize: 5
  readonly property int dotSpacing: 5

  anchors.centerIn: parent
  spacing: 14

  // Workspace dots
  RowLayout {
    spacing: dotSpacing

    Repeater {
      model: 5

      Rectangle {
        required property int modelData

        readonly property var workspace: HyprlandEvents.workspaces.values.find(ws => ws.id === modelData + 1)

        implicitWidth: dotSize
        implicitHeight: dotSize
        radius: height / 2

        color: {
          if (workspace) {
            if (workspace.urgent) {
              return root.colRed;
            } else if (workspace.focused) {
              return root.colFg;
            } else {
              return Qt.alpha(root.colFg, 0.7);
            }
          } else {
            return Qt.alpha(root.colFg, 0.4);
          }
        }
      }
    }
  }

  // Clock
  Text {
    color: root.colFg
    font: root.fontSans

    text: Clock.format("HH:mm")
  }

  // TODO: Notification dots
  Rectangle {
    implicitWidth: dotSize * 5 + dotSpacing * 4
    implicitHeight: dotSize / 2
    radius: height / 2

    color: Qt.alpha(root.colFg, 0.4)
  }
}
