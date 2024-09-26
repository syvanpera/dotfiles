function glc --wraps='git rev-parse HEAD| wl-copy' --description 'alias glc git rev-parse HEAD| wl-copy'
  git rev-parse HEAD| wl-copy $argv
        
end
