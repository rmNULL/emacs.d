;;; winframes --- windows and frames
;;; going with win and frames both in the file name to make fuzzy search easier
;;; in future when i forget the file.
;;;

(global-unset-key (kbd "C-z"))

(use-package winner
  :config
  (winner-mode 1))

(use-package switch-window
  :bind
  ("Φ" . other-window)
  ("∛" . switch-window-then-delete)
  ("¹" . switch-window-then-maximize)
  ("²" . switch-window-then-split-below)
  ("³" . switch-window-then-split-right)
  :config
  (global-set-key (kbd "φ") (lambda ()
                              (interactive)
                              (other-window -1)))
  :custom
  (switch-window-qwerty-shortcuts
   '("a" "s" "d" "f" "j" "k" "l" "g" "h"
     "q" "w" "e" "r" "t" "y" "u" "i" "p"
     "z" "x" "c" "v" "b" "n" "m"))
  (switch-window-minibuffer-shortcut ?z)
  (switch-window-threshold 3)
  (switch-window-shortcut-style 'qwerty))

(use-package perspective
  :bind
  ("Β" . helm-buffers-list)
  :custom
  (persp-sort 'created)
  (persp-state-default-file iduh-stray-files-perspective-default-file)
  (persp-modestring-short t)
  (persp-mode-prefix-key (kbd "C-c w"))
  :init
  (persp-mode))

(provide 'iduh-init-winframes)
