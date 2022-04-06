;;; winframes --- windows and frames
;;; going with win and frames both in the file name to make fuzzy search easier
;;; in future when i forget the file.
;;;

(use-package winner
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
  (switch-window-shortcut-style 'qwerty))

;; (use-package burly
;;   :straight (burly
;;              :type git
;;              :host github
;;              :repo "alphapapa/burly.el"))

(use-package perspective
  :bind
  ("C-x C-b" . helm-buffers-list)
  :custom
  (persp-sort 'created)
  (persp-state-default-file iduh-stray-files-perspective-default-file)
  (persp-modestring-short t)
  (persp-mode-prefix-key (kbd "C-c w"))
  (display-buffer-base-action
   '((display-buffer-reuse-window display-buffer-pop-up-window)
     (reusable-frames . t)))
  :init
  (persp-mode))

(provide 'iduh-init-winframes)
