(use-package dired
  :straight nil
  :custom
  (dired-listing-switches "-lhA --group-directories-first"))

(use-package dired-hist
  :straight (dired-hist
             :type git
             :host github
             :repo "karthink/dired-hist")
  :bind (:map dired-mode-map
         ("l" . 'dired-hist-go-back)
         ("r" . 'dired-hist-go-forward))
  :config
  (dired-hist-mode))

(provide 'iduh-init-dired)
