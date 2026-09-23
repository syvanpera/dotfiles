// Parsing and filtering for `sesh list --json`.
//
// sesh merges three kinds of entry into one list: live tmux sessions, any
// sessions declared in sesh's config, and zoxide directories. They all end up
// as rows here, but they are opened differently, so each row carries a `kind`
// that open.sh dispatches on.
//
// A configured session must be opened by its name, never by its path: the name
// is what carries the entry's startup_command. Verified against the CLI —
// `sesh connect "tmux config"` opens ~/.config/tmux with nvim already running,
// while `sesh connect ~/.config/tmux` opens a plain shell in a separate
// session that sesh names after the directory.
//
// Note what this file deliberately does not do: work out the tmux session name
// a directory will produce. sesh's rule is git-aware — a directory inside a
// repo is named after its path within that repo (~/.dotfiles/.config/nvim
// becomes "_dotfiles/_config/nvim") while anything else gets its basename — so
// predicting it would mean a `git rev-parse` for every row in the list. open.sh
// matches a directory to its session by path instead, which needs no guessing.

function parse(raw) {
  var data = null
  try {
    data = JSON.parse(String(raw || ""))
  } catch (e) {
    return []
  }

  var rows = Array.isArray(data) ? data : []
  var out = []

  for (var i = 0; i < rows.length; i++) {
    var row = rows[i] || {}
    var name = String(row.Name || "")
    if (!name) continue

    var source = String(row.Src || "")
    var path = String(row.Path || "")
    // Live sessions and configured ones are both addressed by name. Only a
    // zoxide directory has no name of its own.
    var named = source === "tmux" || source === "config" || source === "tmuxinator"

    out.push({
      kind: source === "tmux" ? "tmux" : (named ? "config" : "path"),
      source: source,
      // sesh labels a zoxide entry with the path itself. The basename is the
      // part worth reading first, with the full path on the line below.
      name: named ? name : basename(path),
      target: named ? name : path,
      path: path,
      command: String(row.StartupCommand || ""),
      attached: Number(row.Attached || 0) > 0,
      windows: Number(row.Windows || 0)
    })
  }

  // sesh already orders the list the way it should be read — live sessions
  // first, then zoxide directories by frecency score — so it is left alone.
  return out
}

function basename(path) {
  var value = String(path || "").replace(/\/+$/, "")
  var slash = value.lastIndexOf("/")
  return slash === -1 ? value : value.substring(slash + 1)
}

function matches(entry, needle) {
  if (!needle) return true
  var text = (String(entry.name || "") + " " + String(entry.path || "")).toLowerCase()
  return text.indexOf(String(needle).toLowerCase()) !== -1
}

function filter(entries, needle) {
  var values = Array.isArray(entries) ? entries : []
  var out = []
  for (var i = 0; i < values.length; i++) {
    if (matches(values[i], needle)) out.push(values[i])
  }
  return out
}

function expandHome(path, home) {
  var value = String(path || "")
  var prefix = String(home || "")
  if (prefix && (value === "~" || value.indexOf("~/") === 0)) return prefix + value.substring(1)
  return value
}

function hasTarget(entries, target) {
  var values = Array.isArray(entries) ? entries : []
  for (var i = 0; i < values.length; i++) {
    if (values[i].target === target) return true
  }
  return false
}

// Anything with a separator in it reads as a directory rather than a session
// name. It is only a guess used for the row's wording — open.sh checks whether
// the path actually exists and picks the right command either way.
function looksLikePath(text) {
  var value = String(text || "")
  return value.indexOf("/") !== -1 || value.charAt(0) === "~"
}

// The filter text doubles as the name field for a new session. Returns the
// extra row to append below the matches, or null when there is nothing to
// offer.
function createCandidate(entries, needle, home) {
  var text = String(needle || "").trim()
  if (!text) return null

  var asPath = looksLikePath(text)

  // The exact thing typed is already on screen, so a create row would only
  // offer a second way to reach the same place. Typing a path is compared
  // against the absolute form sesh lists, so "~/src/app" recognises itself.
  if (hasTarget(entries, asPath ? expandHome(text, home) : text)) return null

  // tmux takes a session name as typed, but ":" is its own target separator
  // and a leading "-" reads as a flag, so neither can survive into a name.
  var name = asPath ? text : text.replace(/:/g, "_").replace(/^-+/, "")
  if (!name) return null

  return {
    kind: "create",
    source: "create",
    name: name,
    target: asPath ? text : name,
    path: "",
    asPath: asPath,
    attached: false,
    windows: 0
  }
}

// Collapse $HOME to `~` so long paths stay readable in the row. sesh already
// does this for the zoxide names it returns, but not for the paths.
function shortenPath(path, home) {
  var value = String(path || "")
  var prefix = String(home || "")
  if (prefix && value.indexOf(prefix) === 0) return "~" + value.substring(prefix.length)
  return value
}
