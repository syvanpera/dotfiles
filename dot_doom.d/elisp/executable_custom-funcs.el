;;; custom-funcs.el --- Description -*- lexical-binding: t; -*-

(defun +custom/neotree-toggle ()
  "Toggle show the NeoTree window."
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-hide)
    (+neotree/find-this-file)))

(provide 'custom-funcs)
;;; custom-funcs.el ends here

