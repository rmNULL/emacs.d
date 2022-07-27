;; (electric-pair-mode)
;; (add-to-list 'electric-pair-pairs '(?\< . ?\>))
;; (add-to-list 'electric-pair-pairs '(?\{ . ?\}))

(use-package prog-mode
  :straight nil
  :bind
  (:map prog-mode-map
        ("C-=". eval-defun)
        ("<f6>" . eval-buffer))
  :hook
  (prog-mode . prettify-symbols-mode))

(use-package flycheck
  :diminish "F "
  :custom
  (flycheck-mode-line-prefix "F")
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (flycheck-global-modes '(not org-mode))
  :config
  (defhydra flycheck-hydra
    (:hint nil)
    "Move around flycheck errors"
    ("n" flycheck-next-error "next")
    ("p" flycheck-previous-error "previous")
    ("f" flycheck-first-error "first")
    ("l" flycheck-list-errors "list")
    ("s" flycheck-error-list-set-filter "filter")
    ("C" flycheck-select-checker "change-linter")
    ("V" flycheck-verify-setup "Verify-setup"))
  :bind
  ("C-c 1" . flycheck-hydra/body)
  :init
  (global-flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :custom
  (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/tmp/tsserver.log"))
  (lsp-keymap-prefix "C-c l")
  (lsp-keep-workspace-alive nil)
  (gc-cons-threshold (* 200 1024 1024))
  (lsp-phpactor-path
   (expand-file-name "local/phpactor/binphpactor" (getenv "HOME")))
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
  :requires helm
  :config
  (define-key company-mode-map (kbd "C-:") 'helm-company)
  (define-key company-active-map (kbd "C-:") 'helm-company))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

(use-package editorconfig
  :diminish editorconfig-mode
  :config
  (editorconfig-mode 1))

(use-package lispy
  :diminish
  :hook
  (emacs-lisp-mode . lispy-mode)
  (lisp-mode . lispy-mode)
  (racket-mode . lispy-mode))

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
  :requires julia-mode
  :hook
  (julia-mode . julia-repl-mode))

(use-package python
  :straight nil
  :bind
  (:map python-mode-map
        ("C-=" . python-shell-send-statement)
        ("<f6>" . python-shell-send-buffer))
  :custom
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "--simple-prompt -i"))

(use-package rust-mode)


(provide 'iduh-init-programming)
