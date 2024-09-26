function copy-commit --wraps=git\ show\ --oneline\ \|\ head\ -1\ \|\ awk\ \'\{\ print\ \ \}\'\ \|wl-copy --wraps=git\ show\ --oneline\ \|\ head\ -1\ \|\ awk\ \'\{\ print\ \$1\ \}\'\ \|wl-copy --description alias\ copy-commit\ git\ show\ --oneline\ \|\ head\ -1\ \|\ awk\ \'\{\ print\ \$1\ \}\'\ \|wl-copy
  git show --oneline | head -1 | awk '{ print $1 }' |wl-copy $argv
        
end
