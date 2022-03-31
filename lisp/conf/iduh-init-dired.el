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
