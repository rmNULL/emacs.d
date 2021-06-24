(let ((minver "27.2"))
  (when (version< emacs-version minver)
    (message "Untested emacs version, update to v%s or higher" minver)))

(add-to-list 'load-path (concat user-emacs-directory "conf/"))

(require 'iduh-init-stray-files)
(require 'iduh-init-editing)
(require 'iduh-init-package-manager)
(require 'iduh-init-core-packages)
(require 'iduh-init-docker)
; (require 'iduh-init-prolog)

(require 'iduh-init-visual-pleasures)

(when nil ;(executable-find "fd")
  (setq helm-locate-recursive-dirs-command "fd --hidden --type d .*%s.*$ %s"))
(when nil ;(executable-find "rg")
  (setq helm-grep-default-command
        (concat "rg"
                " --smart-case"
                " --max-depth 1"
                " --max-columns 160"
                " --max-columns-preview"
                " --no-heading --with-filename"
                " -e %p %f")
        helm-grep-default-recurse-command
        (concat "rg"
                " --smart-case"
                " --max-columns 160"
                " --max-columns-preview"
                " --no-heading --with-filename"
                " %p %f")
        helm-ag-base-command
        "rg --color=always --smart-case --no-heading --line-number %s %s %s"))


(setq custom-file (concat user-emacs-directory "custom-config.el"))
(when (file-exists-p custom-file)
  (load custom-file))
