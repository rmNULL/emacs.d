(add-hook 'prog-mode-hook (lambda ()
                            (flyspell-prog-mode)
                            (diminish 'flyspell-mode)
                            (electric-pair-mode)
                            (add-to-list 'electric-pair-pairs '(?\< . ?\>))
                            (add-to-list 'electric-pair-pairs '(?\{ . ?\}))))

(use-package flycheck
  :config
  (global-flycheck-mode)
  (setq-default flycheck-mode-line-prefix "F")
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package lsp-mode
   :commands lsp
   :hook ((js-mode . lsp)
          (php-mode . lsp)
          (lsp-mode . lsp-enable-which-key-integration))
   :init
   (with-eval-after-load 'js
     (define-key js-mode-map (kbd "M-.") nil))
   (setq lsp-phpactor-path
         (expand-file-name "local/phpactor/bin/phpactor" (getenv "HOME")))
   (setq lsp-keymap-prefix "C-c l")
   (setq gc-cons-threshold (* 200 1024 1024))
   (setq read-process-output-max (* 3 1024 1024)))


(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

(use-package company
  :diminish company-mode
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 4)
  (setq company-idle-delay 0))

(use-package helm-company
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

(use-package parinfer-rust-mode
  :hook ((emacs-lisp-mode . (lambda ()
                              (electric-pair-mode 0)
                              (parinfer-rust-mode))))
  :init
  (setq parinfer-rust-auto-download t)
  (setq parinfer-rust-dim-parens nil)
  :config
  (diminish 'parinfer-rust-mode
          '(:eval (cond
                    ((equal parinfer-rust--mode  "paren") "()")
                    ((equal parinfer-rust--mode "indent") " ⭾")
                    (t "")))))

  
(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package yasnippet-snippets)

(use-package yasnippet
  :config
  (diminish 'yas-minor-mode " Y")
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))


(provide 'iduh-init-programming)
