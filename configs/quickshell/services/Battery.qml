pragma Singleton

import Quickshell
import Quickshell.Services.UPower


Singleton {
    readonly property string percentage: {
        decToPct(UPower.displayDevice.percentage) + "%"
    }

    function decToPct(n: float) { return Math.round(n * 100); }
}
