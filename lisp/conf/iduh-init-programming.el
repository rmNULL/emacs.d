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
    ("e" flycheck-explain-error-at-point "explain")
    ("C" flycheck-select-checker "change-linter")
    ("V" flycheck-verify-setup "Verify-setup"))
  :bind
  ("C-c 1" . flycheck-hydra/body)
  :init
  (global-flycheck-mode))

(use-package lsp-mode
  :commands lsp
  :custom
  ;; (lsp-clients-typescript-server-args '("--stdio" "--tsserver-log-file" "/tmp/tsserver.log"))
  (lsp-clients-typescript-server-args '("--stdio" ))
  (lsp-log-io nil)
  (lsp-keymap-prefix "C-c l")
  (lsp-keep-workspace-alive nil)
  (gc-cons-threshold (* 200 1024 1024))
  ;; (lsp-phpactor-path
  ;;  (expand-file-name "local/phpactor/binphpactor" (getenv "HOME")))
  (lsp-eslint-enable nil)
  ;; copied from https://github.com/rksm/emacs-rust-config/blob/ec562f005152fabba0447ce64687cbb572a7d49b/init.el#L55
  (lsp-rust-analyzer-server-display-inlay-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  (lsp-rust-analyzer-display-closure-return-type-hints t)
  (lsp-rust-analyzer-display-parameter-hints nil)
  (lsp-rust-analyzer-display-reborrow-hints nil)
  ;; end copy
  :hook
  ((js-mode php-mode rustic-mode web-mode elixir-mode) . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :init
  (with-eval-after-load 'js
    (define-key js-mode-map (kbd "M-.") nil))
  (setq read-process-output-max (* 3 1024 1024))
  :config
  (add-to-list 'lsp--formatting-indent-alist '(web-mode . web-mode-code-indent-offset))
  (add-to-list 'auto-mode-alist '("\\.ts$" . js-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode)))

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

(use-package ruby-mode
  :straight nil)

(use-package inf-ruby
  :hook
  (ruby-mode . inf-ruby-minor-mode)
  :bind
  (:map ruby-mode-map
        ("C-=" . ruby-send-block)
        ("<f6>" . ruby-send-buffer)
        ("C-c C-c" . ruby-send-buffer-and-go)
        ("C-c C-p" . inf-ruby)))

(use-package rustic
  :bind (:map rustic-mode-map
              ("<f6>" . rustic-cargo-run)))

(use-package zig-mode)
(use-package elixir-mode)

(require 'iduh/repeat)
(iduh/def-repeatable-keys iduh-ctrl-meta-prefix
                          ("a" . beginning-of-defun)
                          ("b" . backward-sexp)
                          ("d" . down-list)
                          ("e" . end-of-defun)
                          ("f" . forward-sexp)
                          ("j" . default-indent-new-line)
                          ("k" . kill-sexp)
                          ("n" . forward-list)
                          ("p" . backward-list)
                          ("t" . transpose-sexps)
                          ("u" . backward-up-list))

(provide 'iduh-init-programming)
