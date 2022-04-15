(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package calendar
  :straight nil
  :custom
  (calendar-week-start-day 6)
  (scroll-preserve-screen-position 'always)
  (inhibit-startup-screen t))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(setq frame-title-format
      '(:eval (if (boundp 'server-name)
                  (list server-name " --- %b")
                "%b")))

(add-hook 'emacs-startup-hook (load-theme 'wombat))
(provide 'iduh-init-visual-pleasures)
