# Defined in - @ line 1
function l --description 'alias l exa -l --group --color=always --group-directories-first --time-style=long-iso --icons'
	exa -l --group --color=always --group-directories-first --time-style=long-iso --icons $argv;
end
