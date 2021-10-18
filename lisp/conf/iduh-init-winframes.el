;;; winframes --- windows and frames
;;; going with win and frames both in the file name to make fuzzy search easier
;;; in future when i forget the file.
;;;

(use-package winner
  :bind (("C-c w u" . winner-undo)
         ("C-c w r" . winner-redo))
  :config
  (winner-mode 1))

(use-package switch-window
  :bind
  ("C-x o" . switch-window)
  ("C-x 1" . switch-window-then-maximize)
  ("C-x 2" . switch-window-then-split-below)
  ("C-x 3" . switch-window-then-split-right)
  ("C-x 0" . switch-window-then-delete)
  ("C-x 4 d" . switch-window-then-dired)
  ("C-x 4 f" . switch-window-then-find-file)
  ("C-x 4 0" . switch-window-then-kill-buffer)
  :custom
  (switch-window-threshold 3)
  :config
  (setq switch-window-shortcut-style 'qwerty))

(use-package burly
  :straight (burly
             :type git
             :host github
             :repo "alphapapa/burly.el"))

(provide 'iduh-init-winframes)
