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

;;; Font selections
(when (x-list-fonts "Fira Code Retina")
  (set-frame-font "Fira Code Retina:size=17" nil t))

(use-package apropospriate-theme
  :straight t
  :config
  (load-theme 'apropospriate-dark t t))

(use-package ample-theme
  :straight t
  :init
  (load-theme 'ample t t)
  (load-theme 'ample-flat t t)
  (load-theme 'ample-light t t)
  (enable-theme 'ample-flat))

(use-package all-the-icons
  :straight t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :straight t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(provide 'iduh-init-visual-pleasures)
