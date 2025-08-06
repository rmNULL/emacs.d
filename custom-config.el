(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(electric-pair-mode t)
 '(epg-pinentry-mode 'loopback)
 '(helm-external-programs-associations '(("pdf" . "mupdf")))
 '(projectile-git-fd-args "-H -0 -E .git -tf -c never")
 '(safe-local-variable-values
   '((eval setq-local org-todo-keyword-faces
           '(("SCREEN" :foreground "#1f77b4" :weight bold)
             ("INTERVIEW" :foreground "#ff7f0e" :weight bold)
             ("CEO" :foreground "#2ca02c" :weight bold)
             ("REJECTED" :foreground "#d62728" :weight bold)))
     (eval setq-local org-todo-keyword-faces
           '(("REJECTED" :foreground "#f41885" :weight bold)))
     (js-indent-level . 2)
     (org-todo-keyword-faces ("REJECTED" :foreground "#f41885"))))
 '(show-paren-mode t)
 '(warning-suppress-types '((comp) (iedit))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-base-face ((t (:inherit nil))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "#df9326"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#ee82ee"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#de392e"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#5640d2"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#3d9dce"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#84770e"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#229623"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "#2178C0")))))
