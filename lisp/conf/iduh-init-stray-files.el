;;; -*- lexical-binding: t -*-
(require 'recentf)
(require 'tramp)
(require 'savehist)
(require 'saveplace)

(defvar iduh-stray-files-prefix
  (expand-file-name "backup/" user-emacs-directory))

(defvar iduh-stray-files-beeps
  (expand-file-name "beeps/" user-emacs-directory))
(defvar iduh-stray-files-beep-org-clock
  (expand-file-name "tun.wav" iduh-stray-files-beeps))
(defvar iduh-server-name
  (if (boundp 'server-name)
      server-name
    (if (stringp (daemonp)) (daemonp) "default")))

(let ((auto-backup-dir
       (expand-file-name "tildes/" iduh-stray-files-prefix))
      (auto-backup-dir-tramp
       (expand-file-name "tramp-tildes/" iduh-stray-files-prefix))
      (auto-save-dir
       (expand-file-name "auto-saves/" iduh-stray-files-prefix))
      (undo-tree-dir
       (expand-file-name "undo-tree/" iduh-stray-files-prefix))
      (perspective-dir
       (expand-file-name "perspective/" iduh-stray-files-prefix))
      (places-dir
       (expand-file-name "places/" iduh-stray-files-prefix))
      (savehist-dir
       (expand-file-name "history/" iduh-stray-files-prefix)))

  (make-directory auto-backup-dir t)
  (make-directory auto-backup-dir-tramp t)
  (make-directory auto-save-dir t)
  (make-directory undo-tree-dir t)
  (make-directory perspective-dir t)
  (make-directory places-dir t)
  (make-directory savehist-dir t)

  (defvar iduh-stray-files-undo-tree-directory undo-tree-dir)
  (defvar iduh-stray-files-perspective-default-file
    (expand-file-name
     ;; (format-time-string "default-%s-%d_%h_%Y")
     iduh-server-name
     perspective-dir))

  (save-place-mode 1)
  (run-at-time nil (* 4 60) 'recentf-save-list)
  (savehist-mode 1)


  (setq recentf-auto-cleanup 'never
        recentf-max-menu-items 24
        recentf-max-saved-items 24
        save-place-file (expand-file-name iduh-server-name places-dir)
        backup-by-copying t
        backup-directory-alist
        `(("." . ,auto-backup-dir))
        tramp-backup-directory-alist
        `(("." . ,auto-backup-dir-tramp))
        auto-save-file-name-transforms
        `((".*" ,auto-save-dir t))
        version-control t
        delete-old-versions t
        create-lockfiles nil
        kept-new-versions 8
        savehist-file (expand-file-name iduh-server-name savehist-dir))

  (advice-add 'recentf-save-list
              :around (lambda (f) (let ((inhibit-message t)) (funcall f)))))

(provide 'iduh-init-stray-files)
