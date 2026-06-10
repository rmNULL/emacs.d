;;; iduh/org --- helpers for org  -*- lexical-binding: t -*-

;;; Code:

(require 'org-clock)

(defun iduh/org-last-clock-toggle (&rest args)
  (interactive "P")
  (if (org-clocking-p)
      (apply #'org-clock-out args)
    (apply #'org-clock-in-last args)))


(defun iduh/days-between (date1 date2)
  "Calculate the number of days until the selected date in the calendar.
date1 and date2 are expected to be in the org time format"
  (/ (time-subtract (org-time-string-to-time date2) (org-time-string-to-time date1))
     86400))

(defun iduh/days-until ()
  "Open a date selector and calculate days until the selected date."
  (interactive)
  (let ((today (format-time-string "%Y-%m-%d"))
        (selected-date (org-read-date nil nil nil "Select a date: ")))
    (let* ((days (days-between selected-date today))
           (year (/ days 365))
           (mons (/ (- days (* year 365)) 30)))
      (message "There are %d days until %s." days selected-date)
      (message "Approx Breakdown. %dy %dm" year mons))))

;;; Templates for org-roam

(defmacro iduh/org-templates-wiki-template ()
  "\
#+title: ${title}
#+capture_date: %<%a, %e %b %Y, %H:%M>
#+FILETAGS: :inf_writings:\
")

(defmacro iduh/org-templates-wiki-music-template ()
  "\
#+title: ${title}
#+capture_date: %<%a, %e %b %Y, %H:%M>
#+FILETAGS: :inf_writings:media:music:album:review:\

* Artist
  
* Album
  
* Rating
  / 100
* Liked Tracks
**
* Summary
")


(defmacro iduh/org-templates-blog-template ()
  "
#+TITLE: ${title}
#+SUBTITLE: 
#+DATE: %<%a, %e %b %Y, %H:%M>
#+AUTHOR: rmnull
#+FILETAGS: :blog:\


* Level 1 heading
some content
"
  )
  



(defun iduh/org-habit-stats-all (days)
  (let* ((since (time-subtract (current-time) (days-to-time days)))
         (files (org-agenda-files))
         (table (make-hash-table :test 'equal)))
    (dolist (file files)
      (with-current-buffer (find-file-noselect file)
        (org-map-entries
         (lambda ()
           (let* ((title (nth 4 (org-heading-components)))
                  (done 0)
                  (miss 0))
             (save-excursion
               (when (re-search-forward ":LOGBOOK:" nil t)
                 (let ((end (save-excursion
                              (re-search-forward ":END:" nil t)
                              (point))))
                   (while (re-search-forward
                           "- State \"\\(DONE\\|CANCELLED\\)\".*\\[\\(.*\\)\\]"
                           end t)
                     (let ((state (match-string 1))
                           (ts (org-time-string-to-time (match-string 2))))
                       (when (time-less-p since ts)
                         (if (string= state "DONE")
                             (setq done (1+ done))
                           (setq miss (1+ miss)))))))))
             (let ((prev (gethash title table '(0 0))))
               (puthash title
                        (list (+ (car prev) done)
                              (+ (cadr prev) miss))
                        table))))
         "+STYLE=\"habit\"")))
    table))

(defun iduh/org-habit-report-all (arg)
  (interactive "P")
  (let* ((days
          (cond
           ;; C-u → prompt
           ((equal arg '(4))
            (read-number "Days: " 10))
           ;; C-u <number> → use numeric prefix
           ((numberp arg)
            arg)
           ;; no prefix → default 10
           (t 10)))
         (data (iduh/org-habit-stats-all days))
         rows)

    (maphash
     (lambda (k v)
       (let* ((done (car v))
              (miss (cadr v))
              (total (+ done miss))
              (pct (if (> total 0)
                       (* 100 (/ (float done) total))
                     0)))
         (push (list k done miss pct) rows)))
     data)

    (setq rows
          (sort rows (lambda (a b) (> (nth 3 a) (nth 3 b)))))

    (with-current-buffer (get-buffer-create "*habit-report*")
      (erase-buffer)
      (insert (format "| Task | Done | Missed | %% (last %d days) |\n|-\n" days))
      (dolist (r rows)
        (insert (format "| %s | %d | %d | %.1f |\n"
                        (nth 0 r) (nth 1 r) (nth 2 r) (nth 3 r))))
      (org-mode)
      (org-table-align)
      (pop-to-buffer (current-buffer)))))


(provide 'iduh/org)

;;; iduh/org.el ends here
