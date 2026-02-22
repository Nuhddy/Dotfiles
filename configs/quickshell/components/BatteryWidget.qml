import QtQuick

import "../services"

Text {
    text: Battery.state + " " + Battery.percentage
    color: root.colText
}
