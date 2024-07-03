(use-package slime
  :config
  ;;; not quite sure but custom variable didn't seem to be always overwritten by "lisp"
  (setq inferior-lisp-program "sbcl"))

(provide 'iduh-init-lisp)
