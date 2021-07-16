(use-package shell
  :requires helm
  :config
  (progn
    (defun comint--advice-send-eof (&rest _args)
      (let ((win (selected-window)))
        (kill-buffer) (delete-window win)))
    (advice-add 'comint-send-eof :after 'comint--advice-send-eof))
  :bind (:map shell-mode-map
         ("M-p" . helm-comint-input-ring)))

(use-package eshell
  :init
  (setq eshell-history-size 8192)
  :config
  (add-hook 'eshell-mode-hook
            (lambda ()
              (add-to-list 'eshell-visual-commands "ipython"))))
(provide 'iduh-init-shell)
