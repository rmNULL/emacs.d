(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker-compose-mode)
(use-package docker
  :bind
  ("C-c d" . docker)
  :custom
  (docker-image-default-sort-key '("Created" . t))
  (docker-container-default-sort-key '("Created" . t)))

(provide 'iduh-init-docker)
