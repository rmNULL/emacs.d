(setq-default indent-tabs-mode nil)

(define-key  isearch-mode-map (kbd "C-j") 'isearch-done)

(global-set-key (kbd "M-n") 'ewiki/move-line-region-down)
(global-set-key (kbd "M-p") 'ewiki/move-line-region-up)
(global-set-key (kbd "M-\\") 'fixup-whitespace)
(global-set-key (kbd "C-a") 'iduh/move-beginning-of-line)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-x O") (lambda ()
                                "source: emacsredux.com"
                                (interactive)
                                (other-window -1)))

(global-set-key (kbd "C-<backspace>") (lambda ()
                                        "source: emacsredux.com"
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

(add-hook 'text-mode-hook 'flyspell-mode)


(use-package easy-kill
  :config
  (global-set-key [remap kill-ring-save] 'easy-kill)
  (global-set-key [remap mark-sexp] 'easy-mark))

(use-package ws-butler
 :init (setq show-trailing-whitespace t)
 :hook (prog-mode-hook . ws-butler-mode))


(use-package undo-tree
  :diminish undo-tree-mode
  :straight (undo-tree :type git
                       :host gitlab
                       :repo "tsc25/undo-tree")
  :config
  (setq undo-tree-history-directory-alist
        `((".*" .  ,iduh-stray-files-undo-tree-directory)))
  (global-undo-tree-mode))

(provide 'iduh-init-editing)
