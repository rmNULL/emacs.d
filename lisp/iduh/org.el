;;; iduh/org --- helpers for org  -*- lexical-binding: t -*-

;;; Code:

(require 'org-clock)

(defun iduh/org-last-clock-toggle (&rest args)
  (interactive "P")
  (if (org-clocking-p)
      (apply #'org-clock-out args)
    (apply #'org-clock-in-last args)))



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


(provide 'iduh/org)

;;; iduh/org.el ends here
