function fkill --wraps=ps\ aux\ \|\ fzf\ --height\ 40\%\ --layout=reverse\ --prompt=\"Select\ process\ to\ kill:\ \"\ \|\ awk\ \'\{print\ \}\'\ \|\ xargs\ -r\ kill --description alias\ fkill\ ps\ aux\ \|\ fzf\ --height\ 40\%\ --layout=reverse\ --prompt=\"Select\ process\ to\ kill:\ \"\ \|\ awk\ \'\{print\ \}\'\ \|\ xargs\ -r\ kill
  ps aux | fzf --height 40% --layout=reverse --prompt="Select process to kill: " | awk '{print }' | xargs -r kill $argv
        
end
