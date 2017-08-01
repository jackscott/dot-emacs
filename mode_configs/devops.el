(require 'namespaces)
(namespace devops
  :import [funcs my-py]
  :packages [mmm-mode
             yaml-mode
             ;;salt-mode
])


(require 'yaml-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(setq yaml-indent-offset 2)
(defn my-hook ()
;;  (salt-mode 1)
  (python-mode-hook)
	)
  
;; (defn add-to-mode (mode lst)
;;   (dolist (file lst)
;;     (add-to-list 'auto-mode-alist
;;                  (cons file mode))))

;; (define-derived-mode saltstack-mode yaml-mode "Saltstack"
;;   "Minimal Saltstack mode, based on `salt-mode'."
;;   (setq tab-width 2
;;         indent-tabs-mode nil))

;;(add-to-list 'auto-mode-alist
;;             '("\\.sls\\'\\|pillar\\.example\\'\\|\\.jinja\\'" . salt-mode))


;;(add-hook 'salt-mode-hook (~ my-hook))
