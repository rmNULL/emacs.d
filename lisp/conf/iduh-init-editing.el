(setq-default indent-tabs-mode nil)

(defun iduh/move-beginning-of-line ()
  "Move to indentation first then to actual beginning.
toggle like that on subsequent presses."
  (interactive)
  (let ((org-point (point)))
    (back-to-indentation)
    (when (equal (point) org-point)
      (move-beginning-of-line nil))))

(global-set-key (kbd "M-\\") 'fixup-whitespace)
(global-set-key (kbd "C-a") 'iduh/move-beginning-of-line)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-?") 'help-command)
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
  (global-set-key [remap mark-sexp] 'easy-kill))

(use-package ws-butler
  :init (setq show-trailing-whitespace t)
  :hook (prog-mode-hook . ws-butler-mode))


(use-package undo-tree
  :bind ()
  :straight (undo-tree :type git
                       :host gitlab
                       :repo "tsc25/undo-tree")
  :config
  (setq undo-tree-history-directory-alist
        `((".*" .  ,iduh-stray-files-undo-tree-directory)))
  (global-undo-tree-mode))

(provide 'iduh-init-editing)
