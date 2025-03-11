function vif --wraps='nvim ' --wraps='nvim devbox.lock' --wraps='nvim $(fzf --height 40% --layout=reverse)' --wraps='vi $(fzf)' --description 'alias vif vi $(fzf)'
    vi $(fzf --height 40% --layout=reverse) $argv

end
