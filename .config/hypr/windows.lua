-- Cliamp (TUI music player): float centered at the size that hugs its layout.
-- Launched with a dedicated app-id by ~/.local/share/applications/cliamp.desktop,
-- because static rules match initialClass/initialTitle and the plain terminal
-- window opens as class "kitty" / title "kitty".
o.window("TUI\\.cliamp", { float = true })
o.window("TUI\\.cliamp", { size = { 940, 516 } })
o.window("TUI\\.cliamp", { center = true })

