# Defined in - @ line 1
function emacs-stop --description 'alias emacs-stop systemctl --user stop emacs'
	systemctl --user stop emacs $argv;
end
