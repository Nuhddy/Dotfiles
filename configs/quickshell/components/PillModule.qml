import QtQuick

Item {
  visible: opacity > 0

  Behavior on opacity {
    NumberAnimation {
      duration: 300
      easing.type: Easing.InOutCubic
    }
  }

  anchors.fill: parent
}
