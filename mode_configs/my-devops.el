(require 'namespaces)
(namespace my-devops
  :import [funcs my-py]
  :packages [mmm-mode
             yaml-mode
             salt-mode]
  )


(defun my-hook ()
  (python-mode-hook)
  )
  
(defun add-to-mode (mode lst)
  (dolist (file lst)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

(define-derived-mode saltstack-mode salt-mode "Saltstack"
  "Minimal Saltstack mode, based on `salt-mode'."
  (setq tab-width 2
        indent-tabs-mode nil))

(add-to-mode 'saltstack-mode (list
                              "\\.sls$"
                              "\\.jinja$"
                              "pillar\\.example$"))

(add-hook 'salt-mode-hook (~ my-hook))

(namespace my-devops
  :export [my-hook])
