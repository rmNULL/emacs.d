;;;

(use-package php-mode)

(use-package emmet-mode
  :diminish " M8"
  :config
  (add-hook 'css-mode-hook  #'emmet-mode)
  (add-hook 'sgml-mode-hook  #'emmet-mode))
    

(provide 'iduh-init-web)
