(defvar iduh-stray-files-prefix
  (expand-file-name "backup/" user-emacs-directory))

(defvar-local auto-backup-dir
  (expand-file-name "tildes/" iduh-stray-files-prefix))
(defvar-local auto-save-dir
  (expand-file-name "auto-saves/" iduh-stray-files-prefix))
(defvar iduh-stray-files-undo-tree-directory
  (expand-file-name "undo-tree/" iduh-stray-files-prefix))
(defvar-local undo-tree-dir iduh-stray-files-undo-tree-directory)

(make-directory auto-backup-dir  t)
(make-directory auto-save-dir t)
(make-directory undo-tree-dir t)

(setq backup-by-copying t
      backup-directory-alist
      `(("." . ,auto-backup-dir))
      auto-save-file-name-transforms
      `((".*" ,auto-save-dir t))
      version-control t
      delete-old-version t
      kept-new-versions 8)

(provide 'iduh-init-stray-files)
