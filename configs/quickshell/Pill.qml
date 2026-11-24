import QtQuick
import QtQuick.Effects
import Quickshell
import qs.services

Variants {
  id: pill

  readonly property int width: 200
  readonly property int height: 30
  readonly property int margin: 12

  model: Quickshell.screens

  PanelWindow {
    exclusionMode: ExclusionMode.Ignore

    anchors.top: true
    implicitWidth: pill.width + pill.margin
    implicitHeight: pill.height + pill.margin

    color: "transparent"

    RectangularShadow {
      anchors.fill: background
      radius: background.radius
      blur: 4
      spread: 1
    }

    Rectangle {
      id: background

      anchors.centerIn: parent
      implicitWidth: pill.width
      implicitHeight: pill.height
      radius: pill.height / 2

      color: root.colBg

      Main {}
    }
  }
}
