import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services

Rectangle {
  visible: PillModes.main

  readonly property int dotSize: 5
  readonly property int dotSpacing: 5

  anchors.fill: parent
  color: "transparent"

  RowLayout {
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
          property bool isPopulated: workspace?.lastIpcObject.windows ?? 0

          implicitWidth: dotSize
          implicitHeight: dotSize
          radius: dotSize / 2

          color: {
            if (workspace?.urgent) {
              return root.colRed;
            } else if (workspace?.focused) {
              return root.colFg;
            } else if (isPopulated) {
              return Qt.alpha(root.colFg, 0.7);
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
      font: Qt.font({
        family: "sans",
        pointSize: 11,
        weight: Font.Medium
      })

      text: Time.clock
    }

    // TODO: Notification dots
    Rectangle {
      implicitWidth: dotSize * 5 + dotSpacing * 4
      implicitHeight: dotSize / 2
      radius: dotSize / 2

      color: Qt.alpha(root.colFg, 0.4)
    }
  }
}
