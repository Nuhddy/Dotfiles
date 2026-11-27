import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.components
import qs.services

ShellRoot {
  id: root

  readonly property color colBg: "#181825"
  readonly property color colFg: "#eae3e6"
  readonly property color colRed: "#e81b33"

  readonly property var fontSans: Qt.font({
    family: "sans",
    pointSize: 11,
    weight: Font.Medium
  })

  readonly property int launcherWidth: 160
  property real launcherTransition: PillState.launcher ? 1 : 0

  Connections {
    target: Quickshell

    function onReloadCompleted() {
      Quickshell.inhibitReloadPopup();
    }
    function onReloadFailed() {
      Quickshell.inhibitReloadPopup();
    }
  }

  Behavior on launcherTransition {
    NumberAnimation {
      duration: 300
      easing.type: Easing.InOutCubic
    }
  }

  PanelWindow {
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: PillState.launcher ? WlrLayer.Overlay : WlrLayer.Top

    anchors {
      top: true
      bottom: true
      left: true
      right: true
    }

    mask: Region {
      item: pill
    }

    MouseArea {
      anchors.fill: pill
      onClicked: PillState.toggleLauncher()
    }

    color: "transparent"

    RectangularShadow {
      anchors.fill: pill
      radius: pill.radius
      blur: 4
      spread: 1
    }

    Rectangle {
      id: pill

      implicitWidth: 200 + launcherWidth * launcherTransition
      implicitHeight: 30
      x: (parent.width - width) / 2
      y: 6 + (parent.height / 2 - 6) * launcherTransition
      radius: height / 2
      color: colBg

      PillModule {
        opacity: PillState.statusbar
        Statusbar {}
      }

      PillModule {
        opacity: PillState.launcher
        Launcher {}
      }
    }
  }
}
