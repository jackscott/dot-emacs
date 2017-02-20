;;; MYJAVA --- 
;;
;; Author: Jack Scott <jack@nine78.com>
;; Copyright © 2017, Jack Scott, all rights reserved.
;; Created: 19 January 2017
;;
;;; Commentary:
;;
;;  
;;
;;; Code:
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
;;; myjava.el ends here
