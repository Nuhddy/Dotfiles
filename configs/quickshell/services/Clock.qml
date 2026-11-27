pragma Singleton

import QtQuick
import Quickshell

Singleton {
  function format(s) {
    return Qt.formatDateTime(clock.date, s);
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
