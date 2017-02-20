;;; LISP --- 
;;
;; Author: Jack Scott <jscott@viki.local>
;; Copyright © 2017, Jack Scott, all rights reserved.
;; Created: 19 January 2017
;;
;;; Commentary:
;;
;;  
;;
;;; Code:




(require 'cl)
;; load in quicklisp if available
;; (let ((f (expand-file-name "~/quicklisp/slime-helper.el")))
;;   (lambda ()
;;     (if (file-exists-p f)
;;         (load f))))

;; this should really check to see if sbcl is installed & get location
(setq inferior-lisp-program "/usr/local/bin/sbcl")
;; lisp
(when (require 'lisp-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.cl\\'\\|\\.lisp\\'" . lisp-mode)))

;;; lisp.el ends here
