function ttmux
    if test -z $TMUX
        if not tmux attach
            command tmux new-session \; new-window "tmux set-option -ga terminal-overrides \",$TERM:Tc\"; tmux detach"
            command tmux attach
        end
    end
end
