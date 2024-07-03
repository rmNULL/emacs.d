;;; iduh-init-kmacro.el
;;; Code:

(use-package kmacro
  :straight nil
  :init
  (defalias 'kmacro-insert-macro 'insert-kbd-macro)
  :bind
  (:map kmacro-keymap
        ("I" . kmacro-insert-macro)))

(fset 'iduh/daily-task-timestamp-insert-in-my-todo-macro
   (kmacro-lambda-form [?\C-e C-return ?\C-u ?\C-c ?. return ? ] 0 "%d"))


(provide 'iduh-init-kmacro)
;;; iduh-init-kmacro.el ends here
