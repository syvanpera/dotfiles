---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "fi",
        kb_variant = "nodeadkeys",

        repeat_rate = 40,
        repeat_delay = 500,

        follow_mouse = 2,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.2,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


