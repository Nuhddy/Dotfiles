pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
  readonly property var workspaces: Hyprland.workspaces

  Connections {
    target: Hyprland
    function onRawEvent(e) {
      if (e.name === "openwindow" || e.name === "closewindow" || e.name === "movewindow") {
        Hyprland.refreshWorkspaces();
      }
    }
  }
}
