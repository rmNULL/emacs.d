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
  


  (provide 'iduh/org)

;;; iduh/org.el ends here
