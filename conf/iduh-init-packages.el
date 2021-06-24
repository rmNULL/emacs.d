(require 'iduh-init-package-manager)

(use-package beginend
  :config (beginend-global-mode))

(use-package helm
  :bind (("C-t" . helm-mini)
         ("<menu>" . helm-M-x)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring))
  )

(use-package magit)

(provide 'iduh-init-core-packages)
