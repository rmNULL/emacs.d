;;; iduh-init-calc.el
;;; Code:

(use-package calc
  :straight nil
  :bind
  (("<Launch9>" . calc)
   :map calc-mode-map
   (("<Launch9>" . calc-dispatch))
   :map calc-dispatch-map
   (("<Launch9>" . calc-quit))))

(provide 'iduh-init-calc)
;;; iduh-init-calc.el ends here
