;;; iduh/repeat.el --- repeat-mode helpers -*- lexical-binding: t -*-

;;; Code:

(defmacro iduh/def-repeatable-keys (name &rest bindings)
  "define repeat key maps.

Usage:
(iduh/def-repeatable-keys resize-window
  (\"^\" . enlarge-window)
  (\"v\" . shrink-window)
  (\"{\" . enlarge-window-horizontally)
  (\"}\" . shrink-window-horizontally))
"
  (let ((var-name (gensym (format "%s-%s" name "repeat-map"))))
    `(progn
       (defvar ,var-name
         (let ((map (make-sparse-keymap)))
           ,@(mapcar (lambda (key-fn)
                       `(define-key map ,(car key-fn)  (quote ,(cdr key-fn))))
                     bindings)
           map))
       ,@(mapcar (lambda (key-fn) `(put  (quote ,(cdr key-fn)) 'repeat-map ,var-name))
                 bindings))))

(provide 'iduh/repeat)
;;; iduh/repeat.el ends here
