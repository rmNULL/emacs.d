;; -*- lexical-binding: t -*-
;;; iduh/buffers --- helper or interactive functions related to buffers
;;;
;;; Commentary:
;;;
(require 'seq)
(require 'iduh/numbers)

;;;   winny's config : https://github.com/winny-/emacs.d
(defun revert-all-buffers ()
  ;; source: winny
  "Refreshes all open buffers from their respective files."
  (interactive)
  (dolist (buffer (buffer-list) (message "Refreshed open files"))
    (let ((fn (buffer-file-name buffer)))
      (when (and fn (buffer-modified-p buffer))
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
  (let ((buffer-candidate
         (if (boundp 'server-name)
             (format "%s.org" server-name)
           "")))
    (dolist (file org-agenda-files)
      (find-file-noselect file t nil nil))
    (get-buffer buffer-candidate)))

(defun iduh/nth-user-buffer (count from-buffer &optional user-buffer-p)
  "get the nth user-buffer starting from the given buffer.
Whether a buffer is user-buffer or not is determined by user-buffer-p which
defaults to iduh/switch-next-user-buffer.

If count is negative it travels in the opposite direction by the given count.
If count is not specified, it defaults to zero and returns the from-buffer itself.
If count exceeds the total number of user-buffers
then the last user buffer will be returned.

In the case of no user buffers,
the from-buffer is returned as it is.
The returned buffer is not always guaranteed to be user-buffer.

(fn count from-buffer &optional user-buffer-p)
"
  (cond
   ((not (get-buffer from-buffer))
    (error "non existing buffer given as a source buffer."))
   (t
    (let* ((pred (or user-buffer-p #'iduh/user-buffer-p))
           (source-buffer (get-buffer from-buffer))
           (full-buffer-list (frame-parameter nil 'buffer-list))
           (buffer-list (seq-filter (lambda (buffer)
                                      (or (eq source-buffer buffer)
                                          (funcall pred buffer)))
                                    full-buffer-list))
           (buffer-list-length (length buffer-list))
           (source-buffer-idx (seq-position buffer-list source-buffer))
           (relative-idx
            (clamp (or count 0) (- (1- buffer-list-length)) (1- buffer-list-length)))
           (idx (mod (+ (or source-buffer-idx 0) relative-idx) buffer-list-length))
           (user-buffer (seq-elt buffer-list idx)))
      user-buffer))))

(defun iduh/user-buffer-p (buffer)
  (let ((buffer-name (buffer-name buffer)))
    (and
     (not (string-prefix-p "magit:" buffer-name))
     (and (not (string-prefix-p "*" buffer-name))
          (not (string-suffix-p "*" buffer-name))))))


;; TODO: replace these functions and instead use `switch-to-prev-buffer-skip` variable
(defun iduh/switch-previous-user-buffer (count)
  (interactive "P")
  (let  ((user-count (cond ((eq ?\- count) -1)
                           ((numberp count) count)
                           ((listp count) (or (car count) 1))
                           (t 1)))
         (user-buffer nil)
         (source-buffer (current-buffer)))

    (setq user-buffer (iduh/nth-user-buffer user-count source-buffer))
    (when user-buffer
      (switch-to-buffer user-buffer t))
    (format "user-buffer = %s; " user-buffer)
    ;; (message (format "user-count = %s ; fun = %s ; v = %s" user-count switch-buffer-fn v))
    ))

(defun iduh/switch-next-user-buffer (count)
  (interactive "P")
  (iduh/switch-previous-user-buffer (if count (- count) -1)))

(defun iduh/shell-or-prev-buffer ()
  (interactive)
  (if (and (string= major-mode "shell-mode")
           (< (string-distance (buffer-name (current-buffer)) "*shell*") 2))
      (iduh/switch-previous-user-buffer 1)
    (shell)))

(defun iduh/kill-or-bury-current-buffer (force-kill)
  "only kill the buffer if its associated with a file, or force kill is passed.
   don't destroy a buffer with contents just like that."
  (interactive "P")

  (let ((practically-empty (lambda (buffer)
                             (zerop (length  (with-current-buffer buffer
                                               (whitespace-cleanup)
                                               (buffer-string))))))
        (buffer (current-buffer)))
    (if (or force-kill
            (buffer-file-name buffer)
            (not (iduh/user-buffer-p buffer))
            (funcall practically-empty buffer))
        (kill-buffer buffer)
      (switch-to-prev-buffer nil 'append))))


(provide 'iduh/buffers)
