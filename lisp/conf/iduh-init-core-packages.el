(use-package avy
  :init
  (setq avy-timeout-seconds 0.3)
  :bind (("C-'" . 'avy-goto-char-timer)
         ("M-g M-g" . 'avy-goto-line)
         ("M-g c" . 'avy-goto-char)
         ("M-g w" . 'avy-goto-word-1)
         ("M-g e" . 'avy-goto-word-0)))
(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'electric-pair-mode))

(use-package beginend
  :diminish (beginend-global-mode
              beginend-prog-mode)
  :config (beginend-global-mode))

(use-package helm
  :diminish
  :bind (("C-t" . helm-mini)
         ("<menu>" . helm-M-x)
         ("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring))
  :config
  (global-unset-key (kbd "C-z"))
  (helm-mode 1)
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-set-key (kbd "C-c h o") 'helm-occur)
  (global-set-key (kbd "C-c h SPC") 'helm-all-mark-rings)
  (global-set-key (kbd "C-c h x") 'helm-regexp)
  (global-set-key (kbd "C-c h r") 'helm-register)
  (global-set-key (kbd "C-c h s") 'helm-do-grep-ag)
  (global-set-key (kbd "C-c h w") 'helm-surfraw)
  (global-unset-key (kbd "C-x c"))

  (define-key shell-mode-map
    (kbd "C-c C-l")
    'helm-comint-input-ring)

  (add-hook 'eshell-mode-hook
            (lambda ()
              (eshell-cmpl-initialize)
              (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
              (define-key eshell-mode-map (kbd "M-p") 'helm-eshell-history)))

  (setq
   helm-commands-using-frame '(completion-at-point
                               helm-apropos
                               helm-eshell-prompts helm-imenu
                               helm-imenu-in-all-buffers)
   helm-completion-style 'flex
   helm-external-programs-associations '(("pdf" . "mupdf")))


  (when (executable-find "fd")
        nil)

  (when (executable-find "rg")
    (setq helm-grep-default-command
          (concat "rg"
                  " --smart-case"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --max-depth 1"
                  " --max-columns 160"
                  " --max-columns-preview"
                  " --no-heading --with-filename"
                  " -e %p %f")
          helm-grep-default-recurse-command
          (concat "rg"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --smart-case"
                  " --max-columns 160"
                  " --max-columns-preview"
                  " --no-heading --with-filename"
                  " %p %f")
          helm-grep-ag-command
          (concat "rg"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --smart-case"
                  " --no-heading"
                  " --line-number"
                  " %s %s %s")
          helm-grep-ag-pipe-cmd-switches
          '("--colors 'match:fg:black'" "--colors 'match:bg:yellow'")))
  (setq helm-occur-key-closest-position nil))


(use-package which-key
  :diminish
  :init  (which-key-mode))


(use-package org
  :bind (("C-c o l" . org-store-link)
         ("C-c o a" . org-agenda)
         ("C-c o s" . org-capture))
  :config
  (let ((iduh-org-private-dir "~/notes/private/org/")
        ( iduh-org-public-dir "~/notes/public/"))
    (setq org-directory "~/notes/")
    (setq org-agenda-files
          (list
           (expand-file-name  "work.org" iduh-org-private-dir)
           (expand-file-name "learn.org" iduh-org-private-dir)
           (expand-file-name "eos.org" iduh-org-private-dir)))))

(use-package projectile
  :diminish " P"
  :config
  (add-hook 'prog-mode-hook #'projectile-mode)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-sort-order 'recently-active)
  (setq projectile-file-exists-remote-cache-expire nil)
  (setq projectile-completion-system 'helm))


(provide 'iduh-init-core-packages)
