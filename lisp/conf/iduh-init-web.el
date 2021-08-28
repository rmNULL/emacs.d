;;;
(use-package emmet-mode
  :diminish " M8"
  :config
  (add-hook 'css-mode-hook  #'emmet-mode)
  (add-hook 'sgml-mode-hook  #'emmet-mode))

(use-package php-mode)

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'")))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))


(provide 'iduh-init-web)
