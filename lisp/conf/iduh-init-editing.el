(setq-default indent-tabs-mode nil)
(setq mouse-yank-at-point t)            ; middle button paste
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

(define-key isearch-mode-map (kbd "C-j") 'isearch-done)
;; (global-set-key (kbd "<f12>") 'ctl-x-map)
;(global-set-key (kbd "C-x") 'kill-region)
(global-set-key (kbd "C-z") 'keyboard-quit)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "M-j") 'join-line)
(global-set-key (kbd "M-n") 'ewiki/move-line-region-down)
(global-set-key (kbd "M-p") 'ewiki/move-line-region-up)
(global-set-key (kbd "M-Z") 'zap-to-char)
(global-set-key (kbd "M-z") 'zap-up-to-char)
(global-set-key (kbd "M-\\") 'fixup-whitespace)
(global-set-key (kbd "C-a") 'iduh/move-beginning-of-line)
;; (global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        "source: emacsredux.com"
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))
(global-set-key (kbd "C-o") 'iduh/open-next-line)
(global-set-key (kbd "C-S-o") 'iduh/open-previous-line)
(global-set-key (kbd "C-c z n") 'hippie-expand)


(use-package rect
  :straight nil
  :config
  ;; source: hyra/wiki/Rectangle-Operations#rectangle-2
  (defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                                       :color pink
                                       :hint nil
                                       :post (deactivate-mark))
    "
  ^_k_^       _w_ copy      _o_pen       _N_umber-lines            |\\     -,,,--,,_
_h_   _l_     _y_ank        _t_ype       _e_xchange-point          /,`.-'`'   ..  \-;;,_
  ^_j_^       _d_ kill      _c_lear      _r_eset-region-mark      |,4-  ) )_   .;.(  `'-'
^^^^          _u_ndo        _g_ quit     ^ ^                     '---''(./..)-'(_\_)
"
    ("k" rectangle-previous-line)
    ("j" rectangle-next-line)
    ("h" rectangle-backward-char)
    ("l" rectangle-forward-char)
    ("d" kill-rectangle)                    ;; C-x r k
    ("y" yank-rectangle)                    ;; C-x r y
    ("w" copy-rectangle-as-kill)            ;; C-x r M-w
    ("o" open-rectangle)                    ;; C-x r o
    ("t" string-rectangle)                  ;; C-x r t
    ("c" clear-rectangle)                   ;; C-x r c
    ("e" rectangle-exchange-point-and-mark) ;; C-x C-x
    ("N" rectangle-number-lines)            ;; C-x r N
    ("r" (if (region-active-p)
             (deactivate-mark)
           (rectangle-mark-mode 1)))
    ("u" undo nil)
    ("g" nil))
  :bind
  (("C-c z SPC" . hydra-rectangle/body)))


(use-package flyspell
  :straight nil
  :bind
  ("C-M-i" . flyspell-auto-correct-word)
  :hook
  (text-mode . flyspell-mode)
  (prog-mode . flyspell-prog-mode)
  :config
  (let ((keys '("C-," "C-;" "C-.")))
    (dolist (key keys)
      (unbind-key key flyspell-mode-map))))


(use-package tiny
  :straight
  (tiny :type git
        :host github
        :repo "abo-abo/tiny")
  :bind
  ("C-;" . tiny-expand))

(use-package easy-kill
  :bind
  ("C-c z w" . easy-mark)
  ([remap kill-ring-save] . easy-kill)
  ([remap mark-sexp] . easy-mark)
  :config
  ;; just unset usable ones, ignore lengthy bindings
  (let ((keys '("C-M-h" "M-?" "M-@")))
    (dolist (key keys)
      (unbind-key key))))


(use-package ws-butler
  :diminish
  :hook
  (prog-mode . ws-butler-mode)
  (ws-butler-mode . (lambda () (setq show-trailing-whitespace t))))


(use-package undo-tree
  :diminish undo-tree-mode
  :straight (undo-tree :type git
                       :host gitlab
                       :repo "tsc25/undo-tree")
  :bind
  ((:map undo-tree-map
         ("C-z" . undo-tree-undo)
         ("C-c z r" . undo-tree-redo)
         ("C-c j u" . undo-tree-visualize)
         ("C-/" . nil)
         ("C-_" . nil)
         ("M-_" . nil)
         ("C-?" . nil)))
  :custom
  ;; in Bytes
  (undo-tree-limit (* 4 1024 1024))
  (undo-tree-strong-limit (* 8 1024 1024))
  (undo-tree-history-directory-alist
   `((".*.gpg" . "/dev/null")
     (".*straight-stderr-.*" . "/dev/null")
     (".*.~undo-tree~" . "/dev/null")
     (".*.gz" . "/dev/null")
     (".*.xz" . "/dev/null")
     (".*.trashinfo" . "/dev/null")
     ("/sudo:.*:.*" . "/dev/null")
     ("/su:..*:.*" . "/dev/null")
     (".*" . ,iduh-stray-files-undo-tree-directory)))
  (undo-tree-visualizer-timestamps t)
  :init
  (global-undo-tree-mode)
  :config
  (let ((kbmap (current-global-map))
        (keys '("C-/" "C-_" "M-_" "C-?")))
    (dolist (key keys)
      (when (and
             (lookup-key kbmap (kbd key))
             (string-match-p "undo"
                             (symbol-name (lookup-key kbmap (kbd key)))))
        (unbind-key key kbmap))))
  (add-to-list 'undo-tree-incompatible-major-modes #'inferior-python-mode))


(use-package cycle-quotes
  :straight t
  :bind
  ("M-'" . cycle-quotes))

(use-package simple
  :straight nil
  :hook
  (org-mode . visual-line-mode)
  (markdown-mode . visual-line-mode)
  (fundamental-mode . visual-line-mode))

(provide 'iduh-init-editing)
