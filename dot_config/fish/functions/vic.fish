# Defined in - @ line 1
function vic --description alias\ vic\ cat\ \~/scripts/config-files.csv\ \|\ sed\ \'s/,/\ /\'\ \|\ awk\ \'\{print\ \$2\}\'\ \|\ fzf\ \|\ sed\ \"s\|\\\~\|\$HOME\|\"\ \|\ xargs\ -I\{\}\ nvim\ \{\}
	cat ~/scripts/rofi/config-files.csv | sed 's/,/ /' | awk '{print $2}' | fzf | sed "s|\~|$HOME|" | xargs -I{} nvim {} $argv;
end
