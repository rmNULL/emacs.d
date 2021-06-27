(use-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))
(use-package docker-compose-mode)
(use-package docker
  :bind ("C-c d" . docker))

(provide 'iduh-init-docker)
