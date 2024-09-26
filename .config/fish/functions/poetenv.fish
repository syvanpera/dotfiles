function poetenv --wraps='. (poetry env info --path)/bin/activate.fish' --description 'alias poetenv . (poetry env info --path)/bin/activate.fish'
  . (poetry env info --path)/bin/activate.fish $argv
        
end
