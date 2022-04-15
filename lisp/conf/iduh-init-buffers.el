;;; iduh-init-buffers.el ---  -*- lexical-binding: t -*-

(global-set-key (kbd "⁴") 'save-buffer)
(global-set-key (kbd "Χ") 'kill-current-buffer)
(global-set-key (kbd "Ο") 'iduh/switch-previous-user-buffer)
(setq initial-buffer-choice '(:eval (iduh/get-initial-buffer)))

(provide 'iduh-init-buffers)

;;; iduh-init-buffers.el ends here
