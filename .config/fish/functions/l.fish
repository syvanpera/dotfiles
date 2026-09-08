function l --wraps='ls -alh' --wraps='eza -l --group --color=always --group-directories-first --time-style=long-iso --icons' --wraps='eza --color=always --long --group-directories-first --git --no-filesize --icons=always --no-time --no-user --no-permissions' --wraps='ls -l' --description 'alias l ls -l'
  ls -l $argv
        
end
