;;; iduh-init-media.el --- video and audio related packages   -*- lexical-binding: t -*-

;;; Code:

(use-package helm-mpd
  :straight (helm-mpd
             :type git
             :host github
             :repo "uemurax/helm-mpd")
  :bind
  (:map helm-command-map
        ("u" . helm-mpd)))

(use-package mpdel
  :straight t
  :init
  (defun iduh/mpdel-do-delete (arg)
    (interactive "P")
    (debug)
    (tablist-do-delete t))
  :bind
  (:map mpdel-playlist-mode-map
        ("<deletechar>" . iduh/mpdel-do-delete)
        ("C-k" . iduh/mpdel-do-delete)
        ("C-K" . iduh/mpdel-do-delete))
  (:map mpdel-core-map
        ("~" . mpdel-browser-open)
        ("0" . mpdel-browser-open)
        ("1" . mpdel-playlist-open)
        ("2" . mpdel-core-open-artists)
        ("3" . mpdel-core-open-albums)))

(provide 'iduh-init-media)

;;; iduh-init-media.el ends here
