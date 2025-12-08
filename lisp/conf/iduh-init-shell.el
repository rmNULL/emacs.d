(require 'iduh/repeat)

(use-package helm-comint)

(use-package shell
  :straight nil
  :demand t
  :hook
  (shell-mode . iduh/shell-kill-buffer-on-exit)
  :config
  (setq shell-command-switch "-lc")
  (iduh/def-repeatable-keys shell-navigation
                            ("p" . comint-previous-prompt)
                            ("n" . comint-next-prompt))
  :bind
  ("C-c j z" . iduh/shell-buffer)
  (:map shell-mode-map
        ("M-r" . helm-comint-input-ring)))

(use-package eshell
  :hook
  (eshell-mode . (lambda ()
                   (eshell-cmpl-initialize)
                   (define-key eshell-mode-map (kbd "M-p") 'helm-eshell-history)
                   (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
                   (add-to-list 'eshell-visual-commands "ipython")))
  :custom
  (eshell-history-size 8192)
  (eshell-visual-subcommands
   '(("git" "help" "log" "diff" "show")
     ("npm" "help")
     ("guix" "search"))))


(use-package eat
  :straight 
  '(eat :type git
        :host codeberg
        :repo "akib/emacs-eat"
        :files ("*.el" ("term" "term/*.el") "*.texi"
                "*.ti" ("terminfo/e" "terminfo/e/*")
                ("terminfo/65" "terminfo/65/*")
                ("integration" "integration/*")
                (:exclude ".dir-locals.el" "*-tests.el"))))



(provide 'iduh-init-shell)
