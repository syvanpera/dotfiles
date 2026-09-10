import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.Commons
import qs.Ui
import "SessionList.js" as SessionList

Item {
  id: root

  property string omarchyPath: Quickshell.env("OMARCHY_PATH")
  property var shell: null
  property var manifest: null

  property bool opened: false
  property string filterText: ""
  property int selectedIndex: 0
  property bool loading: false
  property var sessions: []
  property var rows: []   // matched sessions, plus an optional create row

  readonly property string home: Quickshell.env("HOME")

  // Third-party manifests are handed over with `__sourceDir` stripped, so the
  // plugin locates its own helper script relative to this QML file instead.
  readonly property string pluginDir: {
    var url = String(Qt.resolvedUrl("."))
    return url.indexOf("file://") === 0 ? url.substring(7) : url
  }

  // Shares the [menu] surface tokens, so themes that style the Omarchy menu
  // style this picker too.
  property color background: Color.menu.background
  property color foreground: Color.menu.text
  property color border: Color.menu.border
  property var borderSpec: Border.surfaceSpec("menu", "border", border, Math.max(1, Style.space(2)))
  property color scrim: Color.menu.scrim
  property color selectedBackground: Color.menu.selectedBackground
  property color selectedText: Color.menu.selectedText

  readonly property int cornerRadius: Style.cornerRadius
  property string fontFamily: Style.font.menuFamily
  property int contentMargin: Style.spacing.panelPadding
  property int headerHeight: Math.max(Style.space(34), Style.font.title + Style.spacing.controlPaddingY * 2)
  property int contentSpacing: Style.spacing.md
  property int rowHeight: Math.max(Style.space(40), Style.font.heading + Style.font.caption + Style.spacing.lg)
  property int cardWidth: Math.min(Style.space(520), panel.width - Style.gapsOut * 2)
  property int cardHeight: Math.min(Style.space(460), panel.height - Style.gapsOut * 2)

  function open(payloadJson) {
    root.opened = true
    root.filterText = ""
    root.selectedIndex = 0
    root.reload()
    Qt.callLater(function() { keyCatcher.forceActiveFocus() })
  }

  function close() {
    root.opened = false
  }

  function dismiss() {
    root.opened = false
    if (root.shell && typeof root.shell.hide === "function")
      root.shell.hide((root.manifest && root.manifest.id) || "tuomo.herdr")
  }

  // Sessions come and go while the shell stays up, so the list is re-read on
  // every open rather than cached.
  function reload() {
    if (listProc.running) return
    root.loading = true
    listProc.running = true
  }

  function loadSessions(raw) {
    root.loading = false
    root.sessions = SessionList.parse(raw)
    root.rebuildDisplay()
  }

  function rebuildDisplay() {
    var matched = SessionList.filter(root.sessions, root.filterText)
    var candidate = SessionList.createCandidate(root.sessions, root.filterText, matched.length)

    // The create row sits last so a partial filter still leaves the cursor on
    // a real session: Enter attaches instead of creating a near-miss name.
    root.rows = candidate ? matched.concat([candidate]) : matched

    if (root.rows.length === 0) root.selectedIndex = 0
    else if (root.selectedIndex >= root.rows.length) root.selectedIndex = root.rows.length - 1
    else if (root.selectedIndex < 0) root.selectedIndex = 0

    Qt.callLater(function() {
      if (root.rows.length > 0) resultList.positionViewAtIndex(root.selectedIndex, ListView.Contain)
    })
  }

  function select(delta) {
    var count = root.rows.length
    if (count === 0) return
    root.selectedIndex = (root.selectedIndex + delta + count) % count
    resultList.positionViewAtIndex(root.selectedIndex, ListView.Contain)
  }

  function selectPage(delta) {
    var count = root.rows.length
    if (count === 0) return
    var visibleRows = Math.max(1, Math.floor(resultList.height / root.rowHeight))
    var next = root.selectedIndex + delta * visibleRows
    root.selectedIndex = Math.max(0, Math.min(count - 1, next))
    resultList.positionViewAtIndex(root.selectedIndex, ListView.Contain)
  }

  function setFilter(nextFilter) {
    root.filterText = nextFilter
    root.selectedIndex = 0
    root.rebuildDisplay()
  }

  function activateIndex(index) {
    if (index < 0 || index >= root.rows.length) return
    var row = root.rows[index]
    // The invalid row exists only to say why the name was refused.
    if (row.isInvalid) return
    root.openSession(row.name)
  }

  // One path for both cases: open.sh attaches to an existing session and
  // creates one that does not exist yet.
  function openSession(name) {
    if (!name) return
    root.dismiss()
    Quickshell.execDetached([root.pluginDir + "open.sh", name])
  }

  function shortenPath(path) {
    return SessionList.shortenPath(path, root.home)
  }

  Process {
    id: listProc
    command: ["bash", "-lc", "herdr session list --json"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.loadSessions(String(text || ""))
    }
  }

  PanelWindow {
    id: panel
    visible: root.opened
    anchors { top: true; bottom: true; left: true; right: true }
    color: "transparent"
    WlrLayershell.namespace: "omarchy-herdr-sessions"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
      anchors.fill: parent
      color: root.scrim
    }

    MouseArea {
      anchors.fill: parent
      onClicked: root.dismiss()
    }

    BorderSurface {
      id: card
      width: root.cardWidth
      height: root.cardHeight
      radius: root.cornerRadius
      anchors.centerIn: parent
      color: root.background
      borderSpec: root.borderSpec
      padding: root.contentMargin

      MouseArea { anchors.fill: parent; onClicked: {} }

      Item {
        id: keyCatcher
        anchors.fill: parent
        focus: true

        Keys.priority: Keys.BeforeItem
        Keys.onPressed: function(event) {
          if (event.key === Qt.Key_Escape) {
            if (root.filterText) root.setFilter("")
            else root.dismiss()
            event.accepted = true
          } else if (Util.editsFilter(event, root.filterText)) {
            root.setFilter(Util.editedFilter(event, root.filterText))
            event.accepted = true
          } else if (event.key === Qt.Key_Up || (event.key === Qt.Key_P && event.modifiers === Qt.ControlModifier)) {
            root.select(-1)
            event.accepted = true
          } else if (event.key === Qt.Key_Down || (event.key === Qt.Key_N && event.modifiers === Qt.ControlModifier)) {
            root.select(1)
            event.accepted = true
          } else if (event.key === Qt.Key_PageUp) {
            root.selectPage(-1)
            event.accepted = true
          } else if (event.key === Qt.Key_PageDown) {
            root.selectPage(1)
            event.accepted = true
          } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            root.activateIndex(root.selectedIndex)
            event.accepted = true
          } else if (event.text && event.text.length === 1 && event.text.charCodeAt(0) >= 32 && event.text.charCodeAt(0) !== 127) {
            root.setFilter(root.filterText + event.text)
            event.accepted = true
          }
        }
      }

      Column {
        anchors.fill: parent
        anchors.topMargin: card.contentTopInset
        anchors.rightMargin: card.contentRightInset
        anchors.bottomMargin: card.contentBottomInset
        anchors.leftMargin: card.contentLeftInset
        spacing: root.contentSpacing

        Item {
          width: parent.width
          height: root.headerHeight

          Text {
            textFormat: Text.PlainText
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            text: root.filterText || "Search herdr sessions…"
            color: root.foreground
            opacity: root.filterText ? 1 : 0.58
            font.family: root.fontFamily
            font.pixelSize: Style.font.heading
            elide: Text.ElideRight
          }
        }

        Item {
          width: parent.width
          height: parent.height - root.headerHeight - root.contentSpacing

          ListView {
            id: resultList
            anchors.fill: parent
            model: root.rows
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            visible: root.rows.length > 0

            delegate: Rectangle {
              id: row
              required property int index
              required property var modelData

              readonly property bool hasCursor: index === root.selectedIndex
              readonly property bool isCreate: modelData.isCreate === true
              readonly property bool isInvalid: modelData.isInvalid === true

              width: resultList.width
              height: root.rowHeight
              radius: root.cornerRadius
              color: hasCursor ? root.selectedBackground : "transparent"

              Text {
                id: statusGlyph
                textFormat: Text.PlainText
                anchors.left: parent.left
                anchors.leftMargin: Style.spacing.rowPaddingX
                anchors.verticalCenter: parent.verticalCenter
                // Plus to create, warning for a refused name, then filled
                // circle for a live session and hollow for a stopped one.
                text: row.isCreate ? "\uf067"
                  : (row.isInvalid ? "\uf071"
                  : (row.modelData.running ? "\uf111" : "\uf10c"))
                color: row.hasCursor ? root.selectedText : root.foreground
                opacity: (row.isCreate || row.modelData.running) ? 1 : (row.isInvalid ? 0.7 : 0.45)
                font.family: root.fontFamily
                font.pixelSize: Style.font.icon
              }

              Column {
                anchors.left: statusGlyph.right
                anchors.leftMargin: Style.spacing.controlGap
                anchors.right: parent.right
                anchors.rightMargin: Style.spacing.rowPaddingX
                anchors.verticalCenter: parent.verticalCenter
                spacing: Style.spacing.xxs

                Text {
                  textFormat: Text.PlainText
                  width: parent.width
                  // A session literally named "default" needs no marker.
                  text: row.isCreate ? "Create session “" + row.modelData.name + "”"
                    : (row.isInvalid ? "Can’t create “" + row.modelData.name + "”"
                    : row.modelData.name + (row.modelData.isDefault && row.modelData.name !== "default" ? "  (default)" : ""))
                  color: row.hasCursor ? root.selectedText : root.foreground
                  font.family: root.fontFamily
                  font.pixelSize: Style.font.subtitle
                  font.weight: (row.isCreate || row.modelData.running) ? Font.DemiBold : Font.Normal
                  elide: Text.ElideRight
                }

                Text {
                  textFormat: Text.PlainText
                  width: parent.width
                  text: row.isCreate ? "Starts a new herdr session"
                    : (row.isInvalid ? "Names take letters, numbers, “.”, “_” and “-” only"
                    : root.shortenPath(row.modelData.directory))
                  color: root.foreground
                  opacity: 0.6
                  font.family: root.fontFamily
                  font.pixelSize: Style.font.caption
                  elide: Text.ElideLeft
                }
              }

              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: row.isInvalid ? Qt.ArrowCursor : Qt.PointingHandCursor
                onContainsMouseChanged: if (containsMouse) root.selectedIndex = row.index
                onClicked: {
                  root.selectedIndex = row.index
                  root.activateIndex(row.index)
                }
              }
            }
          }

          Column {
            anchors.centerIn: parent
            spacing: Style.space(8)
            visible: root.rows.length === 0

            Text {
              text: "󰆍"
              color: root.selectedText
              opacity: 0.8
              font.family: root.fontFamily
              font.pixelSize: Style.font.displayLarge
              horizontalAlignment: Text.AlignHCenter
              width: parent.width
            }

            Text {
              textFormat: Text.PlainText
              // A non-empty filter now always yields at least one row (a create
              // or a refusal), so this only covers an empty filter.
              text: root.loading ? "Loading sessions…" : "Type a name to create a session"
              color: root.foreground
              opacity: 0.7
              font.family: root.fontFamily
              font.pixelSize: Style.font.title
              horizontalAlignment: Text.AlignHCenter
              width: parent.width
            }
          }
        }
      }
    }
  }
}
