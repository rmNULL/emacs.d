;; -*- lexical-binding: t -*-
(defun iduh/move-beginning-of-line ()
  "Move to indentation first then to actual beginning.
toggle like that on subsequent presses."
  (interactive)
  (let ((org-point (point)))
    (back-to-indentation)
    (when (equal (point) org-point)
      (move-beginning-of-line nil))))

(defun ewiki/move-region (start end n)
  "Move the current region up or down by N lines."
  (interactive "r\np")
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (let ((start (point)))
      (insert line-text)
      (setq deactivate-mark nil)
      (set-mark start))))

(defun ewiki/move-region-up (start end n)
  "Move the current line up by N lines."
  (interactive "r\np")
  (ewiki/move-region start end (if (null n) -1 (- n))))

(defun ewiki/move-region-down (start end n)
  "Move the current line down by N lines."
  (interactive "r\np")
  (ewiki/move-region start end (if (null n) 1 n)))

(defun ewiki/move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun ewiki/move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (ewiki/move-line (if (null n) -1 (- n))))

(defun ewiki/move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (ewiki/move-line (if (null n) 1 n)))


(defun ewiki/move-line-region-up (&optional start end n)
  (interactive "r\np")
  (if (use-region-p) (ewiki/move-region-up start end n) (ewiki/move-line-up n)))

(defun ewiki/move-line-region-down (&optional start end n)
 (interactive "r\np")
 (if (use-region-p) (ewiki/move-region-down start end n) (ewiki/move-line-down n)))


(defun iduh/open-next-line (arg)
  "somewhat like vim's o"
  (interactive "p")
  (end-of-line)
  (newline arg t))

(defun iduh/open-previous-line (arg)
  "somewhat like vim's O"
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (funcall indent-line-function))
;;

(provide 'iduh/lines)
