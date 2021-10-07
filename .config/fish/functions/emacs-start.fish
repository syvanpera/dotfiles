# Defined in - @ line 1
function emacs-start --description 'alias emacs-start systemctl --user start emacs'
	systemctl --user start emacs $argv;
end
