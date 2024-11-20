;; -*- lexical-binding: t -*-

(require 'iduh/string)

(defun iduh/--build-dired-guess-shell-alist (pairs)
  (mapcar (lambda (cmd-extensions)
            (let ((cmd (iduh/stringify (car cmd-extensions)))
                  (extensions (mapcar #'iduh/stringify (cdr cmd-extensions))))
              (list (rx-to-string `(seq "." (or ,@extensions) eol) t)
                    cmd)))
          pairs))

(defmacro iduh/build-dired-guess-shell-alist (&rest pairs)
  `(quote ,(iduh/--build-dired-guess-shell-alist pairs)))

(defun iduh/helm-zoxide-exec-shell (candidate)
  "Open the given directory in shell"
  (let ((default-directory (directory-file-name candidate)))
    (shell (format "*shell-<%s>*" (file-name-nondirectory default-directory)))))

(provide 'iduh/dired)
