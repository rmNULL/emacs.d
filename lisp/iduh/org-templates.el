;;; iduh/org-templates.el --- helpers for org-templates  -*- lexical-binding: t -*-

;;; Code:

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


(provide 'iduh/org-templates)

;;; iduh/org-templates.el ends here
