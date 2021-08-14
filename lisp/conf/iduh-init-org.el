(use-package org
  :bind (("C-c o l" . org-store-link)
         ("C-c o a" . org-agenda)
         ("C-c o c" . org-capture)
         (  "C-c c" . org-capture)
         :map org-mode-map
         ("C-c a" . 'org-agenda)
         (  "M-p" . 'org-metaup)
         (  "M-n" . 'org-metadown))
  :init
  (setq
   org-hide-leading-stars t
   org-adapt-indentation nil
   org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "ON-IT(o)" "|" "CANCELLED(c)" "DONE(d)"))
   org-directory "~/notes/")
  :config
  (let ((iduh-org-private-dir (expand-file-name "private/org" org-directory))
        ( iduh-org-public-dir (expand-file-name "public" org-directory)))
    (setq iduh-gtd-reminder (expand-file-name "reminder.org" iduh-org-private-dir)
          iduh-gtd-inbox (expand-file-name   "eos.org" iduh-org-private-dir)
          iduh-gtd-work  (expand-file-name  "work.org" iduh-org-private-dir)
          iduh-gtd-learn (expand-file-name "learn.org" iduh-org-private-dir)
          iduh-gtd-someday (expand-file-name "long-term.org" iduh-org-private-dir))
    (setq org-capture-templates '(("r" "Reminder" entry
                                   (file+headline iduh-gtd-reminder "Reminder")
                                   "* %i%? \n %U")
                                  ("t" "Todo [inbox]" entry
                                   (file+headline iduh-gtd-inbox "Tasks")
                                   "* TODO %i%?"))
          org-agenda-files (list iduh-gtd-inbox
                                 iduh-gtd-work
                                 iduh-gtd-learn)
          org-refile-targets `((,iduh-gtd-work :maxlevel . 2)
                               (,iduh-gtd-someday :level . 1)
                               (,iduh-gtd-learn :maxlevel . 2)))))
(use-package org-roam
  :bind
  (("C-c n i" . org-roam-node-insert)
   ("C-c n f" . org-roam-node-find))
  :init
  (make-directory (expand-file-name "org-roam/" org-directory) t)
  :custom
  (org-roam-directory (expand-file-name "org-roam/" org-directory))
  :config
  (setq org-roam-v2-ack t))

(provide 'iduh-init-org)
