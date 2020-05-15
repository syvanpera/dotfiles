# Defined in - @ line 1
function emacs-restart --description 'alias emacs-restart systemctl --user restart emacs'
	systemctl --user restart emacs $argv;
end
