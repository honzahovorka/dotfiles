// Cloudflare WARP bar widget, ported from the waybar custom/warp module.
// Follows the first-party popup panels (panels/dropbox, panels/tailscale): a bar
// icon that opens a keyboard-navigable panel whose content is a toggle plus status.

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

Panel {
  id: root
  moduleName: "honzahovorka.warp"
  ipcTarget: "honzahovorka.warp"
  manageIpc: false

  property bool cursorActive: false

  readonly property color foreground: bar ? bar.foreground : Color.foreground
  readonly property color accent: bar ? bar.urgent : Color.urgent
  readonly property color dim: Qt.darker(foreground, 1.55)
  readonly property string fontFamily: bar ? bar.fontFamily : Style.font.family

  // Connection state is carried by colour: the theme's accent when WARP is up,
  // and the ordinary bar foreground when it is down, so the idle icon sits in
  // the bar like every other widget instead of looking disabled.
  readonly property color barForegroundColor: bar ? bar.barForeground : Color.foreground
  readonly property color barIconColor: warp.active ? accent : barForegroundColor
  readonly property color heroIconColor: warp.active ? accent : dim

  readonly property string toggleHint: warp.active ? "Disconnect WARP" : "Connect WARP"
  // Only claim the header cursor when there is something to act on — an absent
  // CLI leaves the switch off screen and nothing to highlight.
  readonly property bool headerHasCursor: cursorActive && warp.installed

  function ensureCursor() {
    if (!warp.installed) cursorActive = false
  }

  function setHeaderCursor() {
    cursorActive = true
    if (panelFlick) panelFlick.contentY = 0
  }

  function toggleWarp() {
    if (warp.installed && !warp.busy) warp.toggle()
  }

  function activateCursor() {
    if (cursorActive) toggleWarp()
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  onOpenedChanged: if (opened) {
    cursorActive = false
    if (panelFlick) panelFlick.contentY = 0
    warp.refresh()
    Qt.callLater(function() { keyCatcher.forceActiveFocus() })
  }

  Service {
    id: warp
    settings: root.settings
  }

  Connections {
    target: warp
    function onInstalledChanged() { root.ensureCursor() }
  }

  IpcHandler {
    target: root.ipcTarget

    function open(): void { root.open() }
    function close(): void { root.close() }
    function show(): void { root.open() }
    function hide(): void { root.close() }
    function toggle(): void { root.toggle() }
    function refresh(): string { warp.refresh(); return "ok" }
    function connect(): string { if (!warp.active) root.toggleWarp(); return "ok" }
    function disconnect(): string { if (warp.active) root.toggleWarp(); return "ok" }
    function status(): string { return warp.statusText }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    iconComponent: Component {
      Item {
        Text {
          anchors.centerIn: parent
          text: "󰒃"
          color: root.barIconColor
          font.family: root.fontFamily
          font.pixelSize: Style.font.icon
          // A transient Connecting/Disconnecting state reads as half-committed.
          opacity: warp.pending ? 0.6 : 1.0
        }
      }
    }
    onPressed: function(pressedButton) {
      if (pressedButton === Qt.RightButton) root.toggleWarp()
      else if (pressedButton === Qt.MiddleButton) warp.refresh()
      else root.toggle()
    }
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    focusTarget: keyCatcher
    contentWidth: panel.fittedContentWidth(Style.space(320))
    contentHeight: panel.fittedContentHeight(column.implicitHeight, Style.space(420))

    PanelKeyCatcher {
      id: keyCatcher
      anchors.fill: parent
      onMoveRequested: function(dx, dy) {
        if (!root.cursorActive) root.setHeaderCursor()
      }
      onActivateRequested: root.activateCursor()
      onCloseRequested: root.close()
      onTabRequested: function(direction) { root.switchPanel(direction) }
      onTextKey: function(t) {
        if (t === "t" || t === "T") root.toggleWarp()
        else if (t === "r" || t === "R") warp.refresh()
      }

      Flickable {
        id: panelFlick
        anchors.fill: parent
        contentWidth: width
        contentHeight: column.implicitHeight
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.VerticalFlick
        interactive: contentHeight > height
        ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

        Column {
          id: column
          width: panelFlick.width
          spacing: Style.space(12)

          Item {
            id: header
            width: parent.width
            implicitHeight: hero.implicitHeight
            // Exposed for the hero's trailingControl, whose `root` resolves to
            // PanelHero (not this Panel) — reach panel state via `header`.
            readonly property bool ringVisible: root.headerHasCursor
            function focusHero() { root.setHeaderCursor() }

            PanelHero {
              id: hero
              width: parent.width
              title: "Cloudflare WARP"
              meta: warp.installed ? warp.statusText : "warp-cli is not installed"
              foreground: root.foreground
              fontFamily: root.fontFamily
              iconOpacity: warp.active ? 1.0 : 0.5
              // Status only — the switch owns toggling, mouse and keyboard alike.
              iconComponent: Component {
                Text {
                  text: "󰒃"
                  color: root.heroIconColor
                  font.family: root.fontFamily
                  font.pixelSize: Style.font.display
                }
              }

              trailingControl: Component {
                ToggleSwitch {
                  id: powerSwitch
                  visible: warp.installed
                  checked: warp.active
                  busy: warp.busy
                  hasCursor: header.ringVisible
                  foreground: hero.foreground
                  onHovered: function(on) { if (on) header.focusHero() }
                  onToggled: root.toggleWarp()

                  PanelToolTip {
                    visible: powerSwitch.containsMouse
                    text: root.toggleHint
                    fontFamily: hero.fontFamily
                  }
                }
              }
            }
          }

          Text {
            visible: warp.actionStatus !== "" || warp.lastError !== ""
            width: parent.width
            text: warp.actionStatus !== "" ? warp.actionStatus : warp.lastError
            color: warp.lastError !== "" && warp.actionStatus === "" ? root.accent : root.dim
            font.family: root.fontFamily
            font.pixelSize: Style.font.bodySmall
            wrapMode: Text.WordWrap
          }

          PanelSeparator {
            visible: warp.installed
            foreground: root.foreground
          }

          Column {
            visible: warp.installed
            width: parent.width
            spacing: Style.space(10)

            PanelSectionHeader {
              text: "CONNECTION"
              foreground: root.foreground
              fontFamily: root.fontFamily
            }

            Column {
              width: parent.width
              spacing: Style.spacing.labelGap

              InfoPair { label: "State"; value: warp.statusText }
              InfoPair {
                label: "Reason"
                value: warp.reason
                visible: warp.reason !== ""
              }
            }
          }
        }
      }
    }
  }

  component InfoPair: Row {
    property string label: ""
    property string value: ""

    width: parent.width
    spacing: Style.space(8)

    InfoLabel { text: label }
    Item { width: Math.max(0, parent.width - parent.children[0].implicitWidth - parent.children[2].implicitWidth - parent.spacing * 2); height: 1 }
    InfoValue { text: value }
  }

  component InfoLabel: Text {
    color: root.foreground
    opacity: 0.6
    font.family: root.fontFamily
    font.pixelSize: Style.font.bodySmall
  }

  component InfoValue: Text {
    color: root.foreground
    font.family: root.fontFamily
    font.pixelSize: Style.font.bodySmall
    elide: Text.ElideRight
  }
}
