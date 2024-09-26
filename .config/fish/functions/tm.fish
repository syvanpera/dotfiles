function tm --wraps='tmux new-session -A -m main' --wraps='tmux new-session -A -s main' --description 'alias tm tmux new-session -A -s main'
  tmux new-session -A -s main $argv
        
end
