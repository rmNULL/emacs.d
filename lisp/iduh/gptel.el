;;; iduh/gptel.el --- Helper functions for GPTel integration -*- lexical-binding: t; -*-

;;; Commentary:
;; This module provides helper functions related to GPTel, including
;; secure API key retrieval via auth-source.

;;; Code:

(defun iduh/gptel-get-key ()
  "Retrieve the API key for openrouter.ai from ~/.authinfo.gpg."
  (let ((auth-info (car (auth-source-search
                         :host "openrouter.ai"
                         :user "apikey"
                         :require '(:secret)
                         :max 1))))
    (when auth-info
      (let ((secret (plist-get auth-info :secret)))
        (if (functionp secret)
            (funcall secret)
          secret)))))

;; Add more GPTel-related helper functions below as needed.

(provide 'iduh/gptel)

;;; iduh/gptel.el ends here
