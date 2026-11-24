pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property bool main: true

  function reset() {
    main = true;
  }
}
