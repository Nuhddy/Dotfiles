pragma Singleton

import Quickshell
import Quickshell.Services.UPower


Singleton {
    readonly property string percentage: {
        decToPct(UPower.displayDevice.percentage) + "%"
    }
    readonly property string state: {
        stateToString(UPower.displayDevice.state)
    }

    function decToPct(n: float) { return Math.round(n * 100); }

    function stateToString(n: int) {
        switch (n) {
            case 1:
                return "CHR";
                break;
            case 2:
                return "BAT";
                break;
            case 4:
                return "FULL";
                break;
            default:
                return "";
        }
    }
}
