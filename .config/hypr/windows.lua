--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name = "fsel-launcher",
    match = { title = "launcher" },

    float  = true,
    center = true,
    size   = { 500, 430 },
})

hl.window_rule({
    match = { class = "(Share|localsend)" },

    float  = true,
    center = true,
})

hl.window_rule({
    match = { class = "localsend" },

    size = { 1100, 700 },
})

hl.window_rule({
    match = { class = "^(Bitwarden)$" },

    no_screen_share = true,
    tag             = "+floating-window"
})

hl.window_rule({
    match = { class = "chrome-nngceckbapebfimnlniiiahkandclblb-Default" },
 
    no_screen_share = true,
    tag             = "+floating-window",
})

-- Remove the 1px border around the slurp region selection used by screenshots.
hl.layer_rule({
    match = { namespace = "selection" },

    no_anim   = true,
    animation = "none"
})

-- Floating windows.
hl.window_rule({
    match = { tag = "floating-window" },
    float = true
})

hl.window_rule({
    match = { tag = "floating-window" },
    center = true
})

hl.window_rule({
    match = { tag = "floating-window" },
    size = { 875, 600 }
})

-- kuori marks the focused window itself, with border_size = 0 in looknfeel.lua,
-- but hyprland emits nothing while a window is dragged, so kuori's mark cannot
-- follow a floating window being moved. floating windows get hyprland's own
-- border instead, and kuori leaves them unmarked (Theme.focusMarkFloating).
hl.window_rule({
    name  = "floating-border",
    match = { float = true },

    border_size = 2,
})
