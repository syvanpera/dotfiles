# Defined in - @ line 1
function ls --description 'alias ls exa --color=always --group-directories-first --time-style=long-iso'
	exa --color=always --group-directories-first --time-style=long-iso $argv;
end
