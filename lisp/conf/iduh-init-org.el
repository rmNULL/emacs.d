(require 'iduh/org)
(require 'iduh/repeat)

(use-package org
  :bind (("C-c o l" . org-store-link)
         ("C-c o a" . org-agenda)
         ("C-c o c" . org-capture)
         ("C-c o p" . org-timer-set-timer)
         ("C-c o t" . iduh/org-last-clock-toggle)
         (  "C-c c" . (lambda () (interactive) (org-capture nil "t")))
         (  "⁵" . org-todo-list)
         :map org-mode-map
         ("Τ" . 'org-todo)
         ("M-p" . 'org-metaup)
         ("M-n" . 'org-metadown)
         ("C-c a" . 'org-agenda)
         ("<f6>" . org-export-dispatch))
  :custom
  (org-hide-leading-stars nil)
  (org-hide-emphasis-markers t)
  (org-adapt-indentation nil)
  (org-log-into-drawer t)
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "ON-IT(o)" "|" "CANCELLED(c)" "DONE(d)")))
  (org-clock-sound iduh-stray-files-beep-org-clock)
  (org-clock-idle-time 8)
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-out-when-done t)
  (org-clock-into-drawer t)
  (org-clock-persist t)
  (org-agenda-span 7)
  (org-agenda-start-day "-3d")
  ;; weird, but org requires this for org-agenda-start-day to be respected, org-agenda-span is 7
  (org-agenda-start-on-weekday nil)
  :hook
  (org-mode . (lambda ()
                (setq org-todo-keyword-faces
                      '(("WAITING" .  "SlateBlue")
                        ("TODO" . "SlateGray")
                        ("ON-IT" . "DarkOrchid")
                        ("CANCELLED" . "Firebrick")
                        ("QA" . "Teal")
                        ("DONE" . "ForestGreen")))))
  :init
  (setq-default org-directory "~/notes/")
  :config
  (require 'org-protocol)
  (let* ((iduh-org-private-dir (expand-file-name "private/org" org-directory))
         (iduh-org-inbox (expand-file-name "eos.org" iduh-org-private-dir))
         (iduh-org-reminder (expand-file-name "reminder.org" iduh-org-private-dir))
         (iduh-refile-targets
          (mapcar (lambda (q) `(,(expand-file-name (format "%s.org" q) iduh-org-private-dir)
                           :maxlevel . 3))
                  '(watch learn listen read long-term bugs work)))
         (iduh-agenda-files
          `(,iduh-org-inbox
            ,iduh-org-reminder
            ,@(mapcar (lambda (e) (car-safe e))
                      (seq-remove (lambda (e)
                                    (let ((basename (file-name-base (car-safe e))))
                                      (or (string= basename "long-term")
                                          (string= basename "watch"))))
                                  iduh-refile-targets))))
         (iduh-lit-filename (lambda () (expand-file-name
                                   (format "private/litmus/%s.org.gpg"
                                           (or (read-string "~~>> ")
                                               "default"))
                                   org-directory))))

    (setq org-capture-templates `(("r" "🕤 Reminder" entry
                                   (file+headline ,iduh-org-reminder "Reminder")
                                   "* %i%? \n %U")
                                  ("t" "📥 Todo" entry
                                   (file+headline ,iduh-org-inbox "Tasks")
                                   "* TODO %T %i%?"
                                   ~:refile-targets iduh-refile-targets)
                                  ("s" "🧯 Solit" plain
                                   (file ,iduh-lit-filename)
                                   "* %t %i%?")
                                  ("p" "Protocol" entry (file+headline ,iduh-org-inbox "Inbox")
                                   "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                                  ("L" "Protocol Link" entry (file+headline ,iduh-org-inbox "Inbox")
                                   "* %U %? [[%:link][%:description]]\n"))
          org-agenda-files iduh-agenda-files
          org-refile-targets iduh-refile-targets
          org-outline-path-complete-in-steps nil
          org-refile-use-outline-path t))

  (iduh/def-repeatable-keys org-heading-navigation
                            ("p" . org-previous-visible-heading)
                            ("n" . org-next-visible-heading)
                            ("b" . org-backward-heading-same-level)
                            ("f" . org-forward-heading-same-level)
                            ("6" . org-up-element)
                            ("^" . org-up-element)))

(use-package org-roam
  :bind
  ("C-c n a" . org-roam-alias-add)
  ("C-c n f" . org-roam-node-find)
  ("C-c n i" . org-roam-node-insert)
  ("C-c n l" . org-roam-buffer-toggle)
  ("C-c n t" . org-roam-tag-add)
  ("C-c d" . org-roam-dailies-map)
  (:map org-mode-map
        ("M-." . org-roam-node-visit))
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode)
  (dolist (directory '(z/diary z/wiki))
    (make-directory (expand-file-name (format "%s" directory) org-directory) t))
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (expand-file-name "z/" org-directory))
  (org-roam-dailies-directory "diary")
  (org-roam-node-display-template
   (concat "${title:*} "
           (propertize "${tags:12}" 'face 'org-tag)))
  (org-roam-mode-sections
   (list #'org-roam-backlinks-section
         #'org-roam-reflinks-section
         ;; #'org-roam-unlinked-references-section
         ))
  (org-roam-capture-templates
   `(("d" "default" plain "%?"
      :target (file+head "${slug}.org"
                         "#+title: ${title}\n#+capture_date: %<%a, %e %b %Y, %H:%M>")
      :unnarrowed t)
     ("w" "wiki")
     ("ww" "wiki/default" plain "%?"
      :target (file+head "wiki/${slug}.org"
                         ,(iduh/org-templates-wiki-template))
      :immediate-finish t
      :unnarrowed t)
     ("wm" "wiki/music" plain "%?"
      :target (file+head "wiki/${slug}.org"
                         ,(iduh/org-templates-wiki-music-template))
      :immediate-finish t
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%H:%M> %?"
      :if-new (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>.org\n")))))

(use-package org-superstar
  :custom
  (org-superstar-special-todo-items 'hide)
  (org-superstar-leading-bullet ?\s)
  :hook
  (org-mode . org-superstar-mode))

(provide 'iduh-init-org)
