pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property string time: Qt.formatDateTime(clock.date, "HH:mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
