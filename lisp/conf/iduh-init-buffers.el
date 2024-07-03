;;; iduh-init-buffers.el ---  -*- lexical-binding: t -*-

(require 'iduh/buffers)

(global-set-key (kbd "C-c z v") 'save-buffer)
(global-set-key (kbd "C-c z x") 'iduh/kill-or-bury-current-buffer)
(global-set-key (kbd "C-c z O") 'iduh/switch-previous-user-buffer)
(global-set-key (kbd "C-c z o") 'iduh/switch-next-user-buffer)
(global-set-key (kbd "<f5>") 'revert-buffer-quick)

(setq initial-scratch-message "")
;; (setq initial-buffer-choice "/tmp/hi.org")

(use-package epa
  :straight nil
  :demand t
  :custom
  (epa-file-select-keys 'silent)
  (epa-file-encrypt-to '("rmnull@eos")))

(provide 'iduh-init-buffers)

;;; iduh-init-buffers.el ends here
