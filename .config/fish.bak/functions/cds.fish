function cds
    set session (tmux display-message -p '#{session_path}')
    cd $session
end
