;; (require 'namespaces)
;; (namespace js-modes-python
;; 	   :import [ js-functions]
;; 	   )

;; (defun electric-pair ()
;;   "If at end of line, insert character pair without surrounding spaces.
;;    Otherwise, just insert the typed character."
;;   (interactive)
;;   (if (eolp) (let (parens-require-spaces) (insert-pair)) 
;;     (self-insert-command 1)))

;; python
(require 'python)
(add-to-list 'auto-mode-alist '("\\.py\\'\\|\\.wsgi\\'" . python-mode))
(setq py-align-multiline-strings-p t)
(setq py-load-python-mode-pymacs-p nil)
(setq py-tab-indent t)
(setq py-indent-honors-inline-comment t)
;; (define-key python-mode-map "\"" 'electric-pair)
;; (define-key python-mode-map "\'" 'electric-pair)
;; (define-key python-mode-map "(" 'electric-pair)
;; (define-key python-mode-map "[" 'electric-pair)
;; (define-key python-mode-map "{" 'electric-pair)
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
               (set-variable 'py-indent-offset 4)
               (set-variable 'py-smart-indentation nil)
               (set-variable 'indent-tabs-mode nil) )))

;; (require 'jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:setup-keys t)
;; (setq jedi:complete-on-dot t)

;; (require 'elpy)
;; (setq elpy-rpc-backend "jedi")
;; (elpy-enable)
;; (elpy-clean-modeline)

;; ;; (when (require 'ipython nil t)
;; ;;   (setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))
;; ;;   (setq ein:use-auto-complete t)
;; ;;   (setq ein:use-auto-complete-superpack t)
;; ;;   (setq ein:use-smartrep t))

;; (require 'nose)
;; (defun nosetests-all-virtualenv ()
;;   (interactive)
;;   (let ((nose-global-name
;;          (format
;;           "~/.virtualenvs/%s/bin/nosetests"
;;           (car
;;            (last
;;             (delete
;;              ""
;;              (split-string
;;               (nose-find-project-root)
;;               "/")))))))
;;     (nosetests-all)))
