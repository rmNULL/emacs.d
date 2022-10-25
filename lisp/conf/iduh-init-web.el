;;;
(use-package emmet-mode
  :diminish " M8"
  :hook
  (css-mode sgml-mode web-mode))

(use-package php-mode)

(use-package web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")
                                  ("tsx" . "\\.ts[x]?\\'")))
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))


(provide 'iduh-init-web)
