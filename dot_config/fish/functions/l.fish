function l --wraps='ls -alh' --wraps='eza -l --group --color=always --group-directories-first --time-style=long-iso --icons' --description 'alias l eza -l --group --color=always --group-directories-first --time-style=long-iso --icons'
  eza -l --group --color=always --group-directories-first --time-style=long-iso --icons $argv
        
end
