;; don't prompt for symlink follow, but display warning.
(setq vc-follow-symlinks t)

(use-package magit
  :bind (("<f7>" . magit-status)
         ("C-c j g" . magit-status)
         ("<f8>" . magit-dispatch)))

;; (use-package magit-delta
;;   :straight t
;;   :ensure-system-package delta
;;   :hook
;;   (magit-mode . magit-delta-mode))

(use-package git-timemachine
  :straight
  (git-timemachine
   :type git
   :host codeberg
   :repo "pidu/git-timemachine"))

(use-package git-modes
  :straight t)

(provide 'iduh-init-vcs)
