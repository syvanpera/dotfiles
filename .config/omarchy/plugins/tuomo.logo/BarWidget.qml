import QtQuick
import QtQuick.Effects
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "tuomo.logo"

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    iconComponent: logo
    onPressed: function(pressedButton) {
      if (!root.bar) return
      if (pressedButton === Qt.RightButton) root.bar.run("xdg-terminal-exec")
      else root.bar.run("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
    }
  }

  // Recolored to the bar foreground so the mark follows theme switches and
  // the transparent-bar foreground, the way Tray.qml treats symbolic icons.
  // MultiEffect scales colorizationColor by the source's luminance, so
  // logo.svg is filled white on purpose: the brand navy (#090734) has a
  // luminance of ~0.04 and came out near-black on every theme.
  Component {
    id: logo

    Item {
      Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: Qt.resolvedUrl("logo.svg")
        // Decode at physical pixels so the mark stays sharp on HiDPI.
        sourceSize.width: Math.round(width * Screen.devicePixelRatio)
        sourceSize.height: Math.round(height * Screen.devicePixelRatio)
        visible: false
        layer.enabled: true
      }

      MultiEffect {
        anchors.fill: image
        source: image
        colorization: 1.0
        colorizationColor: root.bar ? root.bar.barForeground : Color.foreground
      }
    }
  }
}
