// Parsing and filtering for `herdr session list --json`.

function parse(raw) {
  var data = null
  try {
    data = JSON.parse(String(raw || ""))
  } catch (e) {
    return []
  }

  var rows = (data && data.sessions) || []
  var out = []

  for (var i = 0; i < rows.length; i++) {
    var row = rows[i] || {}
    var name = String(row.name || "")
    if (!name) continue

    out.push({
      name: name,
      running: row.running === true,
      isDefault: row["default"] === true,
      directory: String(row.session_dir || "")
    })
  }

  // Running sessions first, then the default one, then alphabetical, so the
  // session the user most likely wants sits under the cursor on open.
  out.sort(function(a, b) {
    if (a.running !== b.running) return a.running ? -1 : 1
    if (a.isDefault !== b.isDefault) return a.isDefault ? -1 : 1
    return a.name < b.name ? -1 : (a.name > b.name ? 1 : 0)
  })

  return out
}

function matches(session, needle) {
  if (!needle) return true
  var text = (String(session.name || "") + " " + String(session.directory || "")).toLowerCase()
  return text.indexOf(String(needle).toLowerCase()) !== -1
}

function filter(sessions, needle) {
  var values = Array.isArray(sessions) ? sessions : []
  var out = []
  for (var i = 0; i < values.length; i++) {
    if (matches(values[i], needle)) out.push(values[i])
  }
  return out
}

// herdr's own rule, verified against the CLI: it rejects anything else with
// "session name may only contain ASCII letters, numbers, '.', '_' and '-'".
// Checking it here means the create row only appears when the name will take.
var NAME_PATTERN = /^[A-Za-z0-9._-]+$/

function isValidName(name) {
  return NAME_PATTERN.test(String(name || ""))
}

function hasName(sessions, name) {
  var values = Array.isArray(sessions) ? sessions : []
  for (var i = 0; i < values.length; i++) {
    if (values[i].name === name) return true
  }
  return false
}

// The filter text doubles as the name field for a new session. Returns the
// extra row to append below the matches, or null when there is nothing to
// offer. `matchCount` is how many real sessions the text matched.
function createCandidate(sessions, needle, matchCount) {
  var name = String(needle || "")
  if (!name) return null

  // An existing session of that name is already on screen; `--session` would
  // just attach to it, so a second row would be a duplicate.
  if (hasName(sessions, name)) return null

  if (!isValidName(name)) {
    // Only explain the rejection when the text matched nothing, so filtering
    // by path ("Work/") does not draw a complaint about the slash.
    return matchCount > 0 ? null : { name: name, isInvalid: true }
  }

  return { name: name, isCreate: true }
}

// Collapse $HOME to `~` so long session directories stay readable in the row.
function shortenPath(path, home) {
  var value = String(path || "")
  var prefix = String(home || "")
  if (prefix && value.indexOf(prefix) === 0) return "~" + value.substring(prefix.length)
  return value
}
