;;; winframes --- windows and frames
;;; going with win and frames both in the file name to make fuzzy search easier
;;; in future when i forget the file.
;;;

(require 'hydra)

(use-package winner
  :config
  (winner-mode 1))

(use-package switch-window
  :config
  (defhydra hydra-switch-window (:body-pre (other-window 1))
    "switch-window"
    ("a" (other-window -1) "previous")
    ("s" other-window "next")
    ("w" switch-window nil)
    ("e" switch-window-then-swap-buffer "exchange")
    ("u" winner-undo "undo")
    ("r" winner-redo "redo")
    ("b" helm-mini "helm-mini")
    ("d" dired-jump  "dir")
    ("f" helm-find-files "find-file")
    ("z" delete-other-windows nil)
    ("x" delete-window nil)
    ("-" split-window-below nil)
    ("|" split-window-right nil)
    ("\\" split-window-right nil)
    ("0" switch-window-then-delete nil)
    ("1" switch-window-then-maximize nil)
    ("2" switch-window-then-split-below nil)
    ("3" switch-window-then-split-right nil)
    ("j" windmove-down nil)
    ("k" windmove-up nil)
    ("h" windmove-left nil)
    ("l" windmove-right nil)
    ("J" (enlarge-window 5) nil)
    ("K" (enlarge-window -5) nil)
    ("H" (enlarge-window -5 t) nil)
    ("L" (enlarge-window 5 t) nil)
    ("q" nil))
  :bind
  ("C-c z f" . hydra-switch-window/body)
  ("<f1>" . delete-other-windows)
  :custom
  (switch-window-qwerty-shortcuts
   '("a" "s" "d" "f" "j" "k" "l" "g" "h"
     "q" "w" "e" "r" "t" "y" "u" "i" "p"
     "x" "c" "v" "b" "n" "m"))
  (switch-window-minibuffer-shortcut ?z)
  (switch-window-threshold 3)
  (switch-window-shortcut-style 'qwerty))

;; (use-package perspective
;;   :bind
;;   ("Β" . helm-mini)
;;   :custom
;;   (persp-sort 'created)
;;   (persp-state-default-file iduh-stray-files-perspective-default-file)
;;   (persp-modestring-short t)
;;   (persp-mode-prefix-key (kbd "C-c w"))
;;   :init
;;   (persp-mode))

(use-package pulse
  :straight nil
  :init
  (dolist (command '(scroll-up-command scroll-down-command
                   recenter-top-bottom other-window))
    (advice-add command :after #'iduh/pulse-line)))

(use-package follow
  :diminish
  :straight nil
  :init
  (follow-mode))

;; (use-package gif-screencast
;;   :straight
;;   (gif-screencast :type git
;;         :host gitlab
;;         :repo "ambrevar/emacs-gif-screencast"))

(setq view-read-only t)

(provide 'iduh-init-winframes)
