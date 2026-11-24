pragma Singleton

import QtQuick
import Quickshell

Singleton {
  property string clock: format("HH:mm")

  function format(s) {
    return Qt.formatDateTime(clock.date, s);
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
