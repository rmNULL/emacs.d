;;; init.el --- self explanatory
;;
;; Commentary
;; ----------
;; 1) Module naming convention:
;;   iduh/name - these files contain only function definitions
;;      and requiring this file should have no side effect on the system apart from
;;      those functions being loaded.
;;
;;   iduh-* - these are config files that modify system variables or
;;            change the environment in some way
(let ((minver "27.2"))
  (when (version< emacs-version minver)
    (message "Untested emacs version, update to v%s or higher" minver)))

(add-to-list 'load-path (concat user-emacs-directory "lisp/"))
(add-to-list 'load-path (concat user-emacs-directory "lisp/conf/"))

(require 'iduh/buffers)
(require 'iduh/lines)
(require 'iduh/dired)
(require 'iduh/pass)

(require 'iduh-init-stray-files)
(require 'iduh-init-package-manager)
(require 'iduh-init-org)

;; (setq custom-file (concat user-emacs-directory "custom-config.el"))
;; (when (file-exists-p custom-file)
;;   (load custom-file))
