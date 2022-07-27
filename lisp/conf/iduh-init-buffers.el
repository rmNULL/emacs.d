;;; iduh-init-buffers.el ---  -*- lexical-binding: t -*-

(require 'iduh/buffers)

(global-set-key (kbd "⁴") 'save-buffer)
(global-set-key (kbd "Χ") 'iduh/kill-or-bury-current-buffer)
(global-set-key (kbd "Ο") 'iduh/switch-previous-user-buffer)
(global-set-key (kbd "ο") 'iduh/switch-next-user-buffer)

(setq initial-scratch-message "")
;; (setq initial-buffer-choice "/tmp/hi.org")

(provide 'iduh-init-buffers)

;;; iduh-init-buffers.el ends here
