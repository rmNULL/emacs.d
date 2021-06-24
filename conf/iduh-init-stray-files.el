(make-directory (concat user-emacs-directory "backup/" "backups") t)
(make-directory (concat user-emacs-directory "backup/" "auto-saves") t)
(setq backup-by-copying t
      backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backup/" "backups/")))
      auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "backup/" "auto-saves/") t))
      version-control t
      delete-old-version t
      kept-new-versions 8)

(provide 'iduh-init-stray-files)
