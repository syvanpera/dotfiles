function clip --wraps=cliphist\ list\ \|\ fzf\ -d\ \'\\t\'\ --with-nth\ 2\ \|\ cliphist\ decode\ \|\ wl-copy --description alias\ clip\ cliphist\ list\ \|\ fzf\ -d\ \'\\t\'\ --with-nth\ 2\ \|\ cliphist\ decode\ \|\ wl-copy
  cliphist list | fzf -d '\t' --with-nth 2 | cliphist decode | wl-copy $argv
        
end
