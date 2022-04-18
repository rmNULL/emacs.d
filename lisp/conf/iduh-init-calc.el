;;; iduh-init-calc.el
;;; Code:

(use-package calc
  :straight nil
  :bind
  ("⁸" . calc-dispatch)
  (:map calc-dispatch-map
        ("⁸" . calc)))


(provide 'iduh-init-calc)
;;; iduh-init-calc.el ends here
