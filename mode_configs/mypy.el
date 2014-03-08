;; (require 'namespaces)
;; (namespace js-modes-python
;; 	   :import [ js-functions]
;; 	   )

;; python
(require 'python)
(add-to-list 'auto-mode-alist '("\\.py\\'\\|\\.wsgi\\'" . python-mode))



(set-list-items '(py-force-py-shell-name-p
		  py-align-multiline-strings-p
		  py-shell-switch-buffers-on-execute-p
		  py-switch-buffers-on-execute-p
		  py-smart-indentation
		  py-tab-indent
		  py-indent-honors-inline-comment)
		t)


(setq py-load-python-mode-pymacs-p nil)
;;(setq py-split-windows-on-execute-p nil)

(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist)
      python-mode-hook
      '(lambda () (progn
               (set-variable 'py-indent-offset 4)
               (set-variable 'py-smart-indentation t)
               (set-variable 'indent-tabs-mode nil) )))


(eval-when-compile (require 'jedi nil t))
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;; (when (require 'ipython nil t)
;;   (setq-default py-shell-name "ipython")
;;   (setq-default py-which-bufname "IPython")
;;   (setq py-python-command-args '("--matplotlib" "--colors" "LightBG")))

;; (setq ein:use-auto-complete t)
;; (setq ein:use-auto-complete-superpack t)
;; (setq ein:use-smartrep t))


; don't split windows



;; (require 'elpy)
;; (setq elpy-rpc-backend "jedi")
;; (elpy-enable)
;; (elpy-clean-modeline)

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
