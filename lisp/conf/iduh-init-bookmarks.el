;;; iduh-init-bookmarks.el ---  -*- lexical-binding: t -*-

(use-package bookmark
  :straight nil
  :bind
  ("M-SPC" . iduh/bookmark-immediate-set)
  :init
  (defun iduh/bookmark-immediate-set ()
    (interactive)
    (let ((default-bookmark-name "."))
      (bookmark-set default-bookmark-name t)))
  :custom
  (bookmark-default-file
   (expand-file-name
    (format "bookmarks.%s" iduh-server-name)
    iduh-stray-files-bookmarks))
  (bookmark-save-flag 1)
  (bookmark-sort-flag nil))

(provide 'iduh-init-bookmarks)

;;; iduh-init-bookmarks.el ends here
