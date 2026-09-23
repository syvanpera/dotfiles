-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- Cursor size, and the theme an application falls back to. Hyprland draws its
-- own cursor and needs no theme, so this was unset -- which left anything asking
-- its theme for a specific shape with nothing to load. slurp asks for
-- "crosshair" when selecting a screenshot region and silently kept the ordinary
-- pointer instead. Adwaita is the installed theme that has one.
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
-- hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland.
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing (Google Meet, Discord, etc).
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Make sure ~/.local/bin is in the path and prioritized
local local_bin_dir = os.getenv("HOME") .. ".local/bin"
local kept = {}
for entry in (os.getenv("PATH") or "/usr/local/bin:/usr/bin"):gmatch("[^:]+") do
  if entry ~= local_bin_dir then table.insert(kept, entry) end
end
table.insert(kept, 1, local_bin_dir)
hl.env("PATH", table.concat(kept, ":"))

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    no_update_news = true,
  },
})

