(require 'recentf)

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


(run-at-time nil (* 4 60) 'recentf-save-list)
(setq backup-by-copying t
      backup-directory-alist
      `(("." . ,auto-backup-dir))
      auto-save-file-name-transforms
      `((".*" ,auto-save-dir t))
      version-control t
      delete-old-versions t
      recentf-max-menu-items 16
      recentf-max-menu-items 16
      recentf-max-saved-items 16
      kept-new-versions 8)

(provide 'iduh-init-stray-files)
