(require 'iduh-init-package-manager)

(use-package beginend
  :config (beginend-global-mode))

(use-package helm
  :bind (("C-t" . helm-mini)
         ("<menu>" . helm-M-x)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring))
  :config
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))
  (helm-mode 1))

(use-package magit)

(provide 'iduh-init-core-packages)
