function fish_user_key_bindings
    # Enable vi mode
    # fish_vi_key_bindings

    # Disable Alt+V
    bind -M default alt-v repaint
    bind -M insert alt-v repaint

    # Ctrl+F: Accept autosuggestion
    # bind -M insert \cf accept-autosuggestion
    # bind -M default \cf accept-autosuggestion

    # Ctrl+P: History search backward (previous command)
    # bind -M insert \cp up-or-search
    # bind -M default \cp up-or-search

    # Ctrl+N: History search forward (next command)
    # bind -M insert \cn down-or-search
    # bind -M default \cn down-or-search

    # Ctrl+A: Move to the beginning of the line
    # bind -M insert \ca beginning-of-line
    # bind -M default \ca beginning-of-line

    # Ctrl+E: Move to the end of the line
    # bind -M insert \ce end-of-line
    # bind -M default \ce end-of-line
end

