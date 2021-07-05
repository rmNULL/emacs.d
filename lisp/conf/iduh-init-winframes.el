;;; winframes --- windows and frames
;;; going with win and frames both in the file name to make fuzzy search easier
;;; in future when i forget the file.
;;;

(use-package winner
  :bind (("C-c w u" . winner-undo)
         ("C-c w r" . winner-redo))
  :config
  (winner-mode 1))

(provide 'iduh-init-winframes)
