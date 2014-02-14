(require 'cl)
;; load in quicklisp if available
(let ((f (expand-file-name "~/quicklisp/slime-helper.el")))
  (lambda ()
    (if (file-exists-p f)
        (load f))))

;; this should really check to see if sbcl is installed & get location
(setq inferior-lisp-program "/usr/local/bin/sbcl")
;; lisp
(when (require 'lisp-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.cl\\'\\|\\.lisp\\'" . lisp-mode)))
