# Defined in - @ line 1
function ls --description 'alias ls exa --group --color=always --group-directories-first --time-style=long-iso --icons'
	exa --group --color=always --group-directories-first --time-style=long-iso --icons $argv;
end
