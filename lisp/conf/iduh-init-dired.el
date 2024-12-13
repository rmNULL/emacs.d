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
  (("C-c C-j" . dired-jump)
   :map dired-mode-map
   ("6" . dired-up-directory))
  :hook
  (dired-mode . dired-hide-details-mode)
  :custom
;;; sort flag exists, as I keep forgetting the flag.
  (dired-listing-switches "-lohA --group-directories-first")
  (delete-by-moving-to-trash t)
  (dired-dwim-target t))

(use-package helm-zoxide
  :straight (helm-zoxide
             :type git
             :host github
             :repo "rmnull/helm-zoxide")
  :bind
  (("C-c j d" . helm-zoxide)
   (:map dired-mode-map
         ("j" . helm-zoxide)
         ("z" . helm-zoxide)
         ("C-j" . dired-goto-file)))
  :custom
  (helm-zoxide-actions
   `(("Find in dired" . helm-zoxide-find-in-dired)
     ("Exec Shell" . iduh/helm-zoxide-exec-shell))))


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
