function ll --wraps=ls --wraps='eza -l --group --color=always --group-directories-first --time-style=long-iso --icons' --wraps='eza -l --group --color=always --group-directories-first --time-style=long-iso --icons --git' --description 'alias ll eza -l --group --color=always --group-directories-first --time-style=long-iso --icons --git'
  eza -l --group --color=always --group-directories-first --time-style=long-iso --icons --git $argv
        
end
