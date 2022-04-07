(setq-default indent-tabs-mode nil)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(define-key isearch-mode-map (kbd "C-j") 'isearch-done)
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "M-n") 'ewiki/move-line-region-down)
(global-set-key (kbd "M-p") 'ewiki/move-line-region-up)
(global-set-key (kbd "M-Z") 'zap-up-to-char)
(global-set-key (kbd "M-\\") 'fixup-whitespace)
(global-set-key (kbd "C-a") 'iduh/move-beginning-of-line)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-x O") (lambda ()
                                "source: emacsredux.com"
                                (interactive)
                                (other-window -1)))
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        "source: emacsredux.com"
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'iduh/open-next-line)
(global-set-key (kbd "C-S-o") 'iduh/open-previous-line)

(use-package flyspell
  :straight nil
  :hook
  (text-mode . flyspell-mode))

(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(use-package ws-butler
  :diminish
  :hook
  (prog-mode . ws-butler-mode)
  (ws-butler-mode . (lambda () (setq show-trailing-whitespace t))))

(use-package undo-tree
  :diminish undo-tree-mode
  :straight (undo-tree :type git
                       :host gitlab
                       :repo "tsc25/undo-tree")
  :custom
  ;; in Bytes
  (undo-tree-limit (* 4 1024 1024))
  (undo-tree-strong-limit (* 8 1024 1024))
  (undo-tree-history-directory-alist
   `((".*.gpg" .  "/dev/null")
     (".*straight-stderr-.*" .  "/dev/null")
     (".*.~undo-tree~" .  "/dev/null")
     (".*" .  ,iduh-stray-files-undo-tree-directory)))
  (undo-tree-visualizer-timestamps t)
  :config
  (add-to-list 'undo-tree-incompatible-major-modes #'inferior-python-mode)
  (global-undo-tree-mode))

(provide 'iduh-init-editing)
