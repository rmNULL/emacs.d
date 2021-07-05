(use-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))
(use-package docker-compose-mode)
(use-package docker
  :bind ("C-c d" . docker)
  :init
  (setq
   docker-container-default-sort-key '("Created" . t)
   docker-image-default-sort-key '("Created" . t)))

(provide 'iduh-init-docker)
