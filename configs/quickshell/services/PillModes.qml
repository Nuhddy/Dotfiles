pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property bool main: true
  property bool launcher: false

  function reset() {
    main = true;
    launcher = false;
  }

  function toggleLauncher() {
    main = !main;
    launcher = !launcher;
  }
}
