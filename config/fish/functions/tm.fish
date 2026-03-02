function tm --wraps="tmux new-session -A -s 'default'" --description "alias tm tmux new-session -A -s 'default'"
  tmux new-session -A -s 'default' $argv
        
end
