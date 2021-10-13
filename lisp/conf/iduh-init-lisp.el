(use-package slime
  :config
  (setq inferior-lisp-program "ros -Q run"))

(if (file-readable-p (expand-file-name "~/.roswell/helper.el"))
    (load (expand-file-name "~/.roswell/helper.el")))


(provide 'iduh-init-lisp)
