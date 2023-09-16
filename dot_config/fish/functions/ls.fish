function ls --wraps='exa --group --color=always --group-directories-first --time-style=long-iso --icons' --description 'alias ls exa --group --color=always --group-directories-first --time-style=long-iso --icons'
  exa --group --color=always --group-directories-first --time-style=long-iso --icons $argv
        
end
