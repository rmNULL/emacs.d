;; -*- lexical-binding: t -*-
;;; iduh/pass --- helper or interactive functions related to pass
;;;
;;; Commentary:
;;;

(defun efs/lookup-password (&rest keys)
  "copied from emacs-from-scratch authinfo guide"
  (let ((result (apply #'auth-source-search keys)))
    (if result
        (funcall (plist-get (car result) :secret))
      nil)))

(defun iduh/lookup-password (&rest keys)
  (apply #'efs/lookup-password keys))

(provide 'iduh/pass)
