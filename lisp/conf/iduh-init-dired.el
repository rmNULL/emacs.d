(use-package dired-hist
  :straight (dired-hist
             :type git
             :host github
             :repo "karthink/dired-hist")
  :bind
  (:map dired-mode-map
        ("l" . 'dired-hist-go-back)
        ("r" . 'dired-hist-go-forward))
  :config
  (dired-hist-mode))

(use-package dired
  :straight nil
  :bind
  ("C-c C-j" . dired-jump)
  :custom
  (dired-listing-switches "-lhA --group-directories-first")
  (delete-by-moving-to-trash t))

(use-package helm-zoxide
  :straight (helm-zoxide
             :type git
             :host github
             :repo "rmnull/helm-zoxide")
  :bind
  (:map dired-mode-map
        ("j" . helm-zoxide)
        ("z" . helm-zoxide)
        ("C-j" . dired-goto-file)))


(use-package dired-x
  :straight nil
  :custom
  (dired-guess-shell-alist-user
   (iduh/build-dired-guess-shell-alist
    (mupdf pdf)
    (chromium html)
    (sqlitebrowser db)
    (feh jpg jpeg png webp gif)
    (mpv flac mp3 m4a opus ogg wav webm mkv flv avi mp4 m4v))))
(provide 'iduh-init-dired)
