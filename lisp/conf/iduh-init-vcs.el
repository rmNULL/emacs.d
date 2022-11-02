(use-package magit
  :bind (("<f7>" . magit-status)
         ("<f8>" . magit-dispatch)))
(use-package git-timemachine
  :straight
  (git-timemachine
   :type git
   :host "https://codeberg.org/"
   :repo "pidu/git-timemachine"))

(use-package git-modes
  :straight t)

(provide 'iduh-init-vcs)
