// WARP state and actions, split out of the panel the way the first-party
// panels (panels/tailscale, panels/dropbox) separate Service.qml from Panel.qml.

import QtQuick
import Quickshell.Io
import "Model.js" as Model

Item {
  id: root

  property var settings: ({})

  // Whether warp-cli is on PATH at all, so the bar can hide the icon entirely on
  // a machine without WARP rather than showing a dead control.
  property bool probed: false
  property bool installed: false

  property bool connected: false
  property bool pending: false
  property string statusText: "Checking…"
  property string reason: ""
  property string actionStatus: ""
  property string lastError: ""

  // Optimistic state so the toggle throws the instant it is clicked instead of
  // waiting for the next poll: -1 follows reality, 0/1 while a command lands.
  property int desired: -1
  readonly property bool active: desired === -1 ? connected : (desired === 1)

  readonly property bool busy: statusProc.running || actionProc.running || probeProc.running
  readonly property int refreshIntervalSec: {
    var seconds = parseInt(String(setting("refreshIntervalSec", 5)), 10)
    if (!isFinite(seconds)) seconds = 5
    return Math.max(2, Math.min(3600, seconds))
  }

  function setting(name, fallback) {
    var value = settings ? settings[name] : undefined
    return value === undefined || value === null ? fallback : value
  }

  function refresh() {
    if (!probed) {
      if (!probeProc.running) probeProc.running = true
      return
    }
    if (installed && !statusProc.running) statusProc.running = true
  }

  function toggle() {
    if (!installed || actionProc.running) return

    var turningOn = !active
    desired = turningOn ? 1 : 0
    actionStatus = turningOn ? "Connecting…" : "Disconnecting…"
    actionProc.command = ["warp-cli", turningOn ? "connect" : "disconnect"]
    actionProc.running = true
  }

  function resetUnavailable(message) {
    connected = false
    pending = false
    desired = -1
    statusText = message
    reason = ""
  }

  Process {
    id: probeProc
    command: ["which", "warp-cli"]
    onExited: function(exitCode) {
      root.probed = true
      root.installed = exitCode === 0
      if (root.installed) root.refresh()
      else root.resetUnavailable("Not installed")
    }
  }

  Process {
    id: statusProc
    command: ["warp-cli", "status"]
    stdout: StdioCollector { id: statusOut; waitForEnd: true }
    onExited: function(exitCode) {
      var parsed = Model.parseStatus(statusOut.text, exitCode)

      root.connected = parsed.connected
      root.pending = parsed.pending
      root.statusText = parsed.statusText
      root.reason = parsed.reason
      root.lastError = parsed.ok ? "" : "warp-cli did not report a status"

      // Reality caught up with the pending toggle — stop overriding it.
      if (root.desired !== -1 && parsed.connected === (root.desired === 1)) {
        root.desired = -1
        root.actionStatus = ""
      }
    }
  }

  Process {
    id: actionProc
    running: false
    command: []
    stdout: StdioCollector { id: actionOut; waitForEnd: true }
    stderr: StdioCollector { id: actionErr; waitForEnd: true }
    onExited: function(exitCode) {
      if (exitCode !== 0) {
        // The command failed, so drop the optimistic state and show what is real.
        root.desired = -1
        root.lastError = Model.elide(actionErr.text || actionOut.text || "warp-cli command failed")
        root.actionStatus = root.lastError
        actionStatusTimer.restart()
      } else {
        root.lastError = ""
      }
      settleTimer.restart()
    }
  }

  Timer {
    interval: root.refreshIntervalSec * 1000
    repeat: true
    running: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }

  Timer {
    // warp-cli reports the new state a beat after connect/disconnect returns.
    id: settleTimer
    interval: 700
    repeat: false
    onTriggered: root.refresh()
  }

  Timer {
    // Clear a failure message so it doesn't sit in the panel forever.
    id: actionStatusTimer
    interval: 2600
    repeat: false
    onTriggered: if (root.desired === -1) root.actionStatus = ""
  }

  Timer {
    // Each poll is skipped while its own process is still running, so a warp-cli
    // that hangs would stop the widget refreshing for good. Reap it well inside
    // the poll interval and let the next tick start clean.
    interval: 10000
    repeat: true
    running: true
    onTriggered: if (statusProc.running) statusProc.running = false
  }
}
