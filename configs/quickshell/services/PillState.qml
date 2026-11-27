pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  property bool statusbar: true
  property bool launcher: false

  function toggleLauncher() {
    launcher = !launcher;
    statusbar = !statusbar;
  }

  IpcHandler {
    target: "launcher"

    function toggle() {
      PillState.toggleLauncher();
    }
  }
}
