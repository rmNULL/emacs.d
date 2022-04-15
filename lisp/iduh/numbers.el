;;; iduh/numbers.el --- numerical utils -*- lexical-binding: t -*-

;;; Code:

(defun clamp (n low high)
  "restrict the number n between low and high. low and high are inclusive

(fn n low high)"
  (max low (min n high)))


(provide 'iduh/numbers)

;;; iduh/numbers.el ends here
