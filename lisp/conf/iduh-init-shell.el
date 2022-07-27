(require 'iduh/repeat)

(use-package shell
  :requires helm
  :config
  (progn
    (defun comint--advice-send-eof (&rest _args)
      (let ((win (selected-window)))
        (kill-buffer) (delete-window win)))
    (advice-add 'comint-send-eof :after 'comint--advice-send-eof))
  (setq shell-command-switch "-lc")
  (global-set-key (kbd "C-z") 'iduh/shell-or-prev-buffer)
  (iduh/def-repeatable-keys shell-navigation
                            ("p" . comint-previous-prompt)
                            ("n" . comint-next-prompt))
  :bind
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
  (eshell-history-size 8192))

(provide 'iduh-init-shell)
