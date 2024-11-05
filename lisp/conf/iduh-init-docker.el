(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker-compose-mode)
(use-package docker
  :bind
  ("C-c r" . docker)
  :custom
  (docker-image-default-sort-key '("Created" . t))
  (docker-container-default-sort-key '("Created" . t))
  ;;; dummy holder, replace with actual values as required
  (docker-image-run-custom-args `(("debian" ("-e SECRET_KEY=MMMV-test-prod-env"
                                             "-p 13535:80"
                                             ,@docker-image-run-default-args)))))

(provide 'iduh-init-docker)
