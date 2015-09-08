(require 'namespaces)
(namespace myjava
	   :import [funcs]
	   :packages [])

;; zaius likes 
(defun my-java-hook ()
  (setq c-basic-offset 2
        tab-width 2
        indetnt-tabs-mode t))

(add-hook 'java-mode-hook 'my-java-hook)
