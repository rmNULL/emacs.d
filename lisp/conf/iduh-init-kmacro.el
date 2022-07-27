;;; iduh-init-kmacro.el
;;; Code:

(use-package kmacro
  :straight nil
  :init
  (defalias 'kmacro-insert-macro 'insert-kbd-macro)
  :bind
  (:map kmacro-keymap
        ("I" . kmacro-insert-macro)))

(provide 'iduh-init-kmacro)
;;; iduh-init-kmacro.el ends here
