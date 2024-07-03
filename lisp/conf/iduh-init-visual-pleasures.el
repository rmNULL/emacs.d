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

(defun iduh/detect-user-preffered-theme (light-theme night-theme)
  (let ((hour (string-to-number
               (substring (current-time-string) 11 13))))
    (if (member hour (number-sequence 8 18))
        light-theme
      night-theme)))

(defun iduh/load-user-theme (light-theme night-theme)
  (let ((theme-name
         (iduh/detect-user-preffered-theme light-theme night-theme)))
   (load-theme theme-name)))

(add-hook 'emacs-startup-hook
          (iduh/load-user-theme 'modus-operandi 'modus-vivendi))
(provide 'iduh-init-visual-pleasures)
