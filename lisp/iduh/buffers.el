;; -*- lexical-binding: t -*-
(require 'seq)
;;; iduh/buffers --- helper or interactive functions related to buffers
;;;
;;; Commentary:
;;;   winny's config : https://github.com/winny-/emacs.d

(defun revert-all-buffers ()
  ;; source: winny
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buffer (buffer-list) (message "Refreshed open files"))
    (let ((fn (buffer-file-name buffer)))
      (when (and fn (not (buffer-modified-p buffer)))
        (if (file-exists-p fn)
          (progn
            (set-buffer buffer)
            (revert-buffer t t t))
          (message "Backing file `%s' no longer exists! Skipping." fn))))))

(defun kill-all-missing-buffers (no-ask)
  ;; source: winny
  "Kill all buffers with missing files.

When prefix argument NO-ASK is non-nil, do not ask before killing
each buffer"
  (interactive "P")
  (dolist (buffer (buffer-list))
    (let ((fn (buffer-file-name buffer)))
      (when (and fn (not (file-exists-p fn)))
        (if no-ask
          (kill-buffer buffer)
          (kill-buffer-ask buffer))))))

(defun iduh/get-initial-buffer ()
  (let ((buffer-candidates
         (if (boundp 'server-name)
             (list (format "%s.org" server-name))
           (list))))
    (get-buffer (seq-find 'get-buffer buffer-candidates ""))))
(setq initial-buffer-choice 'iduh/get-initial-buffer)

(provide 'iduh/buffers)
