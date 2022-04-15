;;; iduh-init-buffers.el ---  -*- lexical-binding: t -*-

(require 'iduh/buffers)

(global-set-key (kbd "⁴") 'save-buffer)
(global-set-key (kbd "Χ") 'iduh/kill-current-buffer)
(global-set-key (kbd "Ο") 'iduh/switch-previous-user-buffer)
;; (setq initial-buffer-choice
;;       (get-buffer-create "free-park.org"))

(provide 'iduh-init-buffers)

;;; iduh-init-buffers.el ends here
