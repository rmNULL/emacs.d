(define-key key-translation-map (kbd "💖") (kbd "C-c"))

(use-package avy
  :custom
  (avy-timeout-seconds 0.3)
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
  :diminish
  beginend-global-mode
  beginend-prog-mode
  :config
  (beginend-global-mode))

(use-package helm
  :diminish
  :bind-keymap
  ("C-c h" . helm-command-prefix)
  :bind
  (("M-x" . helm-M-x)
   ("<menu>" . execute-extended-command) ;; helm fail backup
   ("C-x C-f" . helm-find-files)
   ("M-y" . helm-show-kill-ring)
   :map helm-command-map
   ("SPC" . helm-all-mark-rings)
   ("o" . helm-occur)
   ("r" . helm-register)
   ("s" . helm-do-grep-ag)
   ("w" . helm-google-suggest)
   ("x" . helm-regexp)
   ("q" . helm-eval-expression-with-eldoc)
   ("!" . helm-run-external-command)
   ("1" . helm-run-external-command))
  :custom
  (helm-completion-style 'flex)
  (helm-buffer-max-length 28)
  (helm-commands-using-frame '(helm-apropos
                               helm-imenu
                               helm-imenu-in-all-buffers))
  :config
  (global-unset-key (kbd "C-x c"))

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
  :init
  (helm-mode 1))

(use-package which-key
  :diminish
  :init
  (which-key-mode))

(use-package projectile
  :requires helm
  :diminish " P"
  :init
  (use-package ripgrep)
  :hook
  (prog-mode . projectile-mode)
  :bind-keymap
  ("Π" . projectile-command-map)
  :bind
  ("C-/" . projectile-ripgrep)
  (:map projectile-command-map
        ("Π" . projectile-find-file)
        ("/" . projectile-ripgrep))
  :custom
  (projectile-completion-system 'helm)
  (projectile-sort-order 'recently-active)
  (projectile-file-exists-remote-cache-expire nil))


(use-package hydra)

(provide 'iduh-init-core-packages)
;;
