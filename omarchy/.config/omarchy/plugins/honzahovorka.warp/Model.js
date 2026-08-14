// Pure helpers for the WARP widget. Kept out of the QML so the parsing is
// readable on its own, matching how the first-party panels are laid out.

// `warp-cli status` prints a state line and usually a reason:
//
//   Status update: Disconnected
//   Reason: Settings Changed
//
// Anything else (daemon down, CLI error) is treated as unavailable rather than
// guessed at.
function parseStatus(raw, exitCode) {
  var text = String(raw || "")
  var state = firstMatch(text, /Status update:\s*(.+)/)
  var reason = firstMatch(text, /Reason:\s*(.+)/)

  if (exitCode !== 0 || state === "") {
    return {
      ok: false,
      connected: false,
      pending: false,
      statusText: "Unavailable",
      reason: reason
    }
  }

  return {
    ok: true,
    // Match the whole word: "Disconnected" must never read as connected.
    connected: /^connected$/i.test(state),
    // WARP reports transient states like "Connecting" while it settles.
    pending: /^(connecting|disconnecting)/i.test(state),
    statusText: state,
    reason: reason
  }
}

function firstMatch(text, pattern) {
  var match = String(text || "").match(pattern)
  return match && match[1] ? match[1].trim() : ""
}

// Collapse whitespace and cap length, so a long CLI error can't stretch the panel.
function elide(text, limit) {
  var value = String(text || "").replace(/\s+/g, " ").trim()
  var max = limit || 140
  return value.length > max ? value.substring(0, max - 1) + "…" : value
}
