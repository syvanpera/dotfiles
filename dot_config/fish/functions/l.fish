# Defined in - @ line 1
function l --description 'alias l exa -l --color=always --group-directories-first --time-style=long-iso'
	exa -l --color=always --group-directories-first --time-style=long-iso $argv;
end
