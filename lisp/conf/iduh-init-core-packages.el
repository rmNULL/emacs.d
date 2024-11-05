(use-package auth-source
  :straight nil
  :custom
  (auth-sources '("~/.authinfo.gpg")))

(use-package avy
  :custom
  (avy-timeout-seconds 0.3)
  :bind (("C-'" . 'avy-goto-char-timer)
         ("M-g M-g" . 'avy-goto-line)
         ("M-g c" . 'avy-goto-char)
         ("M-g s" . 'avy-goto-symbol-1)
         ("M-g w" . 'avy-goto-word-1)
         ("M-g e" . 'avy-goto-word-0)
         ("M-g '" . 'avy-goto-char-timer)))

(use-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'electric-pair-mode))

(use-package beginend
  :diminish
  beginend-global-mode
  beginend-prog-mode
  :config
  (beginend-global-mode))

(use-package helm
  :straight t
  :diminish
  :bind
  (("M-x" . helm-M-x)
   ("<menu>" . execute-extended-command) ;; helm fail backup
   ("C-c j f" . helm-find-files)
   ("C-c j r" . helm-bookmarks)
   ("M-y" . helm-show-kill-ring)
   ("C-c z b" . helm-mini)
   ("C-h i" . helm-info)
   :map helm-command-map
   ("SPC" . helm-all-mark-rings)
   ("o" . helm-occur)
   ("r" . helm-bookmarks)
   ("s" . helm-do-grep-ag)
   ("w" . helm-surfraw)
   ("x" . helm-regexp)
   ("q" . helm-eval-expression-with-eldoc)
   ("!" . helm-run-external-command)
   ("1" . helm-run-external-command))
  :custom
  (helm-completion-style 'flex)
  (helm-buffer-max-length 28)
  (helm-commands-using-frame '(helm-apropos
                               helm-imenu
                               helm-imenu-in-all-buffers))
  (helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-bookmarks
                               helm-source-recentf
                               helm-source-buffer-not-found))
  (helm-recentf-fuzzy-match t)
  (helm-buffers-fuzzy-matching t)
  (helm-M-x-fuzzy-matching t)
  (helm-candidate-number-limit 64)
  (helm-default-external-file-browser "Thunar")
  (helm-raise-command "wmctrl -xa %s")
  (helm-top-command "env COLUMNS=%s top -e m -b -c -n 1")
  (helm-command-prefix-key "C-c h")
  :config
  (global-unset-key (kbd "C-x c"))
  (when (executable-find "rg")
    (setq helm-grep-default-command
          (concat "rg"
                  " --smart-case"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --max-depth 1"
                  " --max-columns 160"
                  " --max-columns-preview"
                  " --no-heading --with-filename"
                  " -e %p %f")
          helm-grep-default-recurse-command
          (concat "rg"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --smart-case"
                  " --max-columns 160"
                  " --max-columns-preview"
                  " --no-heading --with-filename"
                  " %p %f")
          helm-grep-ag-command
          (concat "rg"
                  " --color=always"
                  " --colors 'match:fg:black'"
                  " --colors 'match:bg:yellow'"
                  " --smart-case"
                  " --no-heading"
                  " --line-number"
                  " %s %s %s")
          helm-grep-ag-pipe-cmd-switches
          '("--colors 'match:fg:black'" "--colors 'match:bg:yellow'")))
  :init
  (helm-mode 1))

(use-package helpful
  :straight t
  :bind
  (:map help-map
   ("f" . helpful-callable)
   ("k" . helpful-key)
   ("v" . helpful-variable)
   ("x" . helpful-command)))

(use-package hydra)

(use-package projectile
  :straight t
  :diminish " P"
  :init
  (use-package ripgrep)
  :hook
  (prog-mode . projectile-mode)
  :bind-keymap
  ("C-c z p" . projectile-command-map)
  :bind
  ("C-/" . projectile-ripgrep)
  (:map projectile-command-map
        ("C-c z p" . projectile-switch-project)
        ("C-c z f" . projectile-find-file)
        ("/" . projectile-ripgrep))
  :custom
  (projectile-completion-system 'helm)
  (projectile-sort-order 'recently-active)
  (projectile-file-exists-remote-cache-expire nil))

(use-package repeat
  :straight nil
  :config
  (repeat-mode))

(use-package which-key
  :diminish
  :init
  (which-key-mode))

;; (use-package keyfreq
;;   :straight (keyfreq
;;              :type git
;;              :host github
;;              :repo "dacap/keyfreq")
;;   :init
;;   (setq iduh-stray-files-keyfreq
;;         (expand-file-name "keyfreq" iduh-stray-files-prefix))
;;   (make-directory iduh-stray-files-keyfreq t)
;;   :config
;;   (keyfreq-mode 1)
;;   (keyfreq-autosave-mode 1)
;;   :custom
;;   (keyfreq-autosave-timeout 900) ;; value in seconds
;;   (keyfreq-file (expand-file-name "freq" iduh-stray-files-keyfreq))
;;   (keyfreq-file-lock
;;    (expand-file-name "freq.lock" iduh-stray-files-keyfreq)))

(use-package kbd-mode
  :straight (kbd-mode
             :host github :repo "kmonad/kbd-mode"
             :type git))

(use-package ellama
  :straight t
  :bind ("C-c e" . ellama-transient-main-menu)
  :init
  ;; setup key bindings
  (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  ;; (setopt ellama-language "German")
  ;; could be llm-openai for example
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   ;; this model should be pulled to use it
	   ;; value should be the same as you print in terminal during pull
	   :chat-model "llama3.2:latest"
	   ;; :embedding-model "nomic-embed-text"
	   :default-chat-non-standard-params '(("num_ctx" . 8192))))
  (setopt ellama-summarization-provider
	  (make-llm-ollama
	   :chat-model "qwen2.5:7b"
	   :embedding-model "nomic-embed-text"
	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; Predefined llm providers for interactive switching.
  ;; You shouldn't add ollama providers here - it can be selected interactively
  ;; without it. It is just example.
  ;; (setopt ellama-providers
  ;;           '(("zephyr" . (make-llm-ollama
  ;;       		   :chat-model "zephyr:7b-beta-q6_K"
  ;;       		   :embedding-model "zephyr:7b-beta-q6_K"))
  ;;             ("mistral" . (make-llm-ollama
  ;;       		    :chat-model "mistral:7b-instruct-v0.2-q6_K"
  ;;       		    :embedding-model "mistral:7b-instruct-v0.2-q6_K"))
  ;;             ("mixtral" . (make-llm-ollama
  ;;       		    :chat-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"
  ;;       		    :embedding-model "mixtral:8x7b-instruct-v0.1-q3_K_M-4k"))))
  ;; Naming new sessions with llm
  ;; (setopt ellama-naming-provider
  ;;           (make-llm-ollama
  ;;            :chat-model "llama3:8b-instruct-q8_0"
  ;;            :embedding-model "nomic-embed-text"
  ;;            :default-chat-non-standard-params '(("stop" . ("\n")))))
  ;; (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; Translation llm provider
  ;; (setopt ellama-translation-provider
  ;;         (make-llm-ollama
  ;;          :chat-model "qwen2.5:3b"
  ;;          :embedding-model "nomic-embed-text"
  ;;          :default-chat-non-standard-params
  ;;          '(("num_ctx" . 32768))))
  )

(provide 'iduh-init-core-packages)
;;
