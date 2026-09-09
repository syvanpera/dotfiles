-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- App menu on Alt+Space
o.bind("ALT + SPACE", "Apps menu", "omarchy-menu toggle apps")

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("ALT + Q", "Close window", hl.dsp.window.close())

-- scratchpad
-- hl.unbind("SUPER + SHIFT + S")
-- o.bind("SUPER + SHIFT + S", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
o.bind("section", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("SUPER + section", "Move window to scratchpad", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

hl.unbind("SUPER + SHIFT + RETURN")
o.bind("SUPER + SHIFT + RETURN", "Herdr", { omarchy = "terminal-herdr" })
o.bind("ALT + RETURN", "Terminal", { omarchy = "terminal" })
o.bind("ALT + SHIFT + RETURN", "Herdr", { omarchy = "terminal-herdr" })

-- Vim-style window navigation (Alt+hjkl)
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
o.bind("SUPER + H", "Focus left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Focus down window", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Focus up window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Focus right window", hl.dsp.focus({ direction = "r" }))

-- Vim-style window moving (Alt+Shift+hjkl)
o.bind("SUPER + SHIFT + H", "Move window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Move window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Move window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Move window right", hl.dsp.window.swap({ direction = "r" }))

-- Workspace navigation on Alt+number (replaces Super+number)
-- Move window to workspace on Alt+Shift+number (replaces Super+Shift+number)
local workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
for _, key in ipairs(workspaces) do
  local workspace = key == "0" and "10" or key
  hl.unbind("SUPER + " .. key)
  hl.unbind("SUPER + SHIFT + " .. key)
  o.bind("ALT + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = workspace }))
  o.bind("ALT + SHIFT + " .. key, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = workspace }))
end

-- Clipboard manager on Super+Shift+C (also Super+Ctrl+V)
hl.unbind("SUPER + SHIFT + C")
o.bind("SUPER + SHIFT + C", "Clipboard manager", "omarchy-shell shell toggle omarchy.clipboard")

-- Screenshot on Super+Shift+S (was: Move window to scratchpad)
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")

-- Open agent
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Agent", "omarchy-agent --pick")

