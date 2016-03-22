(require 'namespaces)
(namespace my-devops
  :import [funcs my-py]
  :packages [mmm-mode
             yaml-mode
             salt-mode]
  )


(defun my-hook ()
  (my-py/my-hook))

(define-derived-mode saltstack-mode yaml-mode "Saltstack"
  "Minimal Saltstack mode, based on `yaml-mode'."
  (setq tab-width 2
        indent-tabs-mode nil))

(add-to-list 'auto-mode-alist '("\\.sls\\'" . saltstack-mode))

(add-hook 'salt-mode-hook (~ my-hook))

(namespace my-devops
  :export [my-hook])
