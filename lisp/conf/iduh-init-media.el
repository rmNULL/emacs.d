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

(provide 'iduh-init-media)

;;; iduh-init-media.el ends here
