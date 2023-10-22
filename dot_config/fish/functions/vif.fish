function vif --wraps='nvim ' --wraps='nvim devbox.lock' --wraps='nvim $(fzf)' --description 'alias vif nvim $(fzf)'
  nvim $(fzf) $argv
        
end
