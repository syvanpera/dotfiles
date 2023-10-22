;;; custom-funcs.el --- Description -*- lexical-binding: t; -*-

(defun +custom/neotree-toggle ()
  "Toggle show the NeoTree window."
  (interactive)
  (if (neo-global--window-exists-p)
      (neotree-hide)
    (+neotree/find-this-file)))

(defun +custom/toggle-frame-undecorated ()
  "Toggle frame decorations."
  (interactive)
  (let ((frame (selected-frame)))
    (if (frame-parameter frame 'undecorated)
        (progn
          (set-frame-parameter frame 'undecorated nil))
      (progn
        (set-frame-parameter frame 'undecorated t)))))

(provide 'custom-funcs)
;;; custom-funcs.el ends here
