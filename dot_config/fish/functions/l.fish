function l --wraps='ls -alh' --wraps='exa -l --group --color=always --group-directories-first --time-style=long-iso --icons' --description 'alias l exa -l --group --color=always --group-directories-first --time-style=long-iso --icons'
  exa -l --group --color=always --group-directories-first --time-style=long-iso --icons $argv
        
end
