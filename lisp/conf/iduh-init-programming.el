;; (electric-pair-mode)
;; (add-to-list 'electric-pair-pairs '(?\< . ?\>))
;; (add-to-list 'electric-pair-pairs '(?\{ . ?\}))

(use-package flycheck
  :custom
  (flycheck-mode-line-prefix "F")
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  :config
  (global-flycheck-mode))


(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/tmp/tsserver.log"))
  (lsp-keymap-prefix "C-c l")
  (lsp-keep-workspace-alive nil)
  (gc-cons-threshold (* 200 1024 1024))
  (lsp-phpactor-path
        (expand-file-name "local/phpactor/bin/phpactor" (getenv "HOME")))
  :hook
  ((js-mode php-mode rust-mode web-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :init
  (with-eval-after-load 'js
    (define-key js-mode-map (kbd "M-.") nil))
  (setq read-process-output-max (* 3 1024 1024))
  :config
  (add-to-list 'lsp--formatting-indent-alist '(web-mode . web-mode-code-indent-offset))
  (add-to-list 'auto-mode-alist '("\\.ts$" . js-mode)))

(use-package helm-lsp
  :commands helm-lsp-workspace-symbol
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

(use-package company
  :diminish company-mode
  :custom
  (company-minimum-prefix-length 4)
  (company-idle-delay 0)
  :config
  (global-company-mode))

(use-package helm-company
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

;; (use-package parinfer-rust-mode
;;   :hook ((emacs-lisp-mode . (lambda ()
;;                               (electric-pair-mode 0)
;;                               (parinfer-rust-mode))))
;;   :init
;;   (setq parinfer-rust-auto-download t)
;;   (setq parinfer-rust-dim-parens nil)
;;   :config
;;   (diminish 'parinfer-rust-mode
;;           '(:eval (cond
;;                     ((equal parinfer-rust--mode  "paren") "()")
;;                     ((equal parinfer-rust--mode "indent") " ⭾")
;;                     (t "")))))


(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package yasnippet-snippets)

(use-package yasnippet
  :diminish
  (yas-minor-mode . " Y")
  :hook
  (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

(use-package julia-mode)
(use-package julia-repl
  :hook
  (julia-mode . julia-repl-mode))

(use-package python
  :custom
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -i"))

(use-package rust-mode)

;; (use-package topsy
;;   :straight (topsy :type git
;;                    :host github
;;                    :repo "alphapapa/topsy.el")
;;   :hook (prog-mode . topsy-mode))

(provide 'iduh-init-programming)
