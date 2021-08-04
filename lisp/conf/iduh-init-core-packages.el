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
         ("C-c o c" . org-capture)
         (  "C-c c" . org-capture)
         :map org-mode-map
         ("C-c a" . 'org-agenda)
         (  "M-p" . 'org-metaup)
         (  "M-n" . 'org-metadown))
  :init
  (setq
   org-hide-leading-stars t
   org-adapt-indentation nil
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "ON-IT(o)" "|" "CANCELLED(c)" "DONE(d)"))
   org-directory "~/notes/")
  :config
  (let ((iduh-org-private-dir (expand-file-name "private/org" org-directory))
        ( iduh-org-public-dir (expand-file-name "public" org-directory)))
    (setq iduh-gtd-reminder (expand-file-name "reminder.org" iduh-org-private-dir)
          iduh-gtd-inbox (expand-file-name   "eos.org" iduh-org-private-dir)
          iduh-gtd-work  (expand-file-name  "work.org" iduh-org-private-dir)
          iduh-gtd-learn (expand-file-name "learn.org" iduh-org-private-dir)
          iduh-gtd-someday (expand-file-name "long-term.org" iduh-org-private-dir))
    (setq org-capture-templates '(("r" "Reminder" entry
                                   (file+headline iduh-gtd-reminder "Reminder")
                                   "* %i%? \n %U")
                                  ("t" "Todo [inbox]" entry
                                   (file+headline iduh-gtd-inbox "Tasks")
                                   "* TODO %i%?"))
          org-agenda-files (list iduh-gtd-inbox
                                 iduh-gtd-work
                                 iduh-gtd-learn)
          org-refile-targets `((,iduh-gtd-work :maxlevel . 2)
                               (,iduh-gtd-someday :level . 1)
                               (,iduh-gtd-learn :maxlevel . 2)))))

(use-package org-roam
  :bind
  (("C-c n i" . org-roam-node-insert)
   ("C-c n f" . org-roam-node-find))
  :init
  (make-directory (expand-file-name "org-roam/" org-directory) t)
  :custom
  (org-roam-directory (expand-file-name "org-roam/" org-directory))
  :config
  (setq org-roam-v2-ack t))

(use-package projectile
  :bind (:map projectile-mode-map
         ("C-c p" . projectile-command-map))
  :diminish " P"
  :config
  (add-hook 'prog-mode-hook #'projectile-mode)
  (setq projectile-sort-order 'recently-active
        projectile-file-exists-remote-cache-expire nil
        projectile-completion-system 'helm))


(provide 'iduh-init-core-packages)
