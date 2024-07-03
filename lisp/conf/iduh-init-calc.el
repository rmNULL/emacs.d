;;; iduh-init-calc.el
;;; Code:

(use-package calc
  :straight nil
  :bind
  (("<XF86Launch9>" . calc)
   :map calc-mode-map
   (("<XF86Launch9>" . calc-dispatch))))

(provide 'iduh-init-calc)
;;; iduh-init-calc.el ends here
