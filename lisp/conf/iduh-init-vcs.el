(use-package magit
  :bind (("<f7>" . magit-status)
         ("<f8>" . magit-dispatch)))
(use-package git-timemachine
  :straight t)
(use-package git-modes
  :straight t)

(provide 'iduh-init-vcs)
