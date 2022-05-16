 ;;; dot-emacs/mode_config/mypy.el --- python things
;;
;; Copyright (C) 2013-2015  Jack Scott (js@nine78.com)
;;
;; Authors:  Jack Scott (js@nine78.com)
;; Created:  24 March 2013
;; License:  GPL
;;
;; This file is *NOT* part of GNU Emacs.
;; This file is distributed under the same terms as GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA
(eval-when-compile (require 'jedi nil t))

(require 'namespaces)
(namespace my-py
  :import [funcs
           autocomp]
  :packages [python
             flycheck
             ;;pylint
             py-autopep8
             virtualenvwrapper
             ;;company-jedi
             ;;nose
             elpy
             subword
             linum
             jedi
             autopair
             flymake-python-pyflakes
             ]
  :export [my-hook])

(require 'python)
(require 'jedi)
(require 'py-autopep8)
(require 'flycheck)
(require 'elpy)

(setq python-indent-offset 4)

(add-to-list 'auto-mode-alist '("\\.py\\'\\|\\.wsgi\\'" . python-mode))

(funcs/set-list-items '(py-force-py-shell-name-p
                        py-align-multiline-strings-p
                        py-shell-switch-buffers-on-execute-p
                        py-switch-buffers-on-execute-p
                        py-smart-indentation
                        py-tab-indent
                        py-indent-honors-inline-comment)
                      t)

(setq py-load-python-mode-pymacs-p nil
      py-indent-offset 4
      default-tab-width 4
      py-smart-indentation t
      indent-tabs-mode nil
      elpy-rpc-backend "jedi"
      elpy-rpc-python-command "python3.8"
      python-shell-unbuffered nil
      python-shell-prompt-detect-failure-warning nil
      python-shell-prompt-detect-enabled nil)

(setq jedi:setup-keys t
      jedi:complete-on-dot t
      jedi:get-in-function-call-delay 10000000
      ;;projectile-switch-project-action 'venv-projectile-auto-workon
      )


;;(python-shell-prompt-detect)
(add-hook 'after-init-hook #'global-flycheck-mode)



(defvar jedi-config:vcs-root-sentinel ".git")
(defvar jedi-config:python-module-sentinel "__init__.py")
(defvar jedi-config:with-virtualenv (emacsdir+ ".python-environments/default")
  "Set to non-nil to point to a particular virtualenv.")

(defun get-project-root (buf repo-type init-file)
  (vc-find-root (expand-file-name (buffer-file-name buf)) repo-type))

(defvar jedi-config:find-root-function 'get-project-root)

;; (let ((project-root (current-buffer-project-root)))
;;   (message "the project root is %s" project-root))

(defun current-buffer-project-root ()
  (funcall jedi-config:find-root-function
           (current-buffer)
           jedi-config:vcs-root-sentinel
           jedi-config:python-module-sentinel))

(defun jedi-config:setup-server-args ()
  ;; helper macro
  (defmacro add-args (arg-list arg-name arg-value)
    '(setq ,arg-list (append ,arg-list (list ,arg-name ,arg-value))))

  (let ((project-root (current-buffer-project-root)))
    (make-local-variable 'jedi:server-args)

    (when project-root
      (add-args jedi:server-args "--sys-path" project-root))

    (when jedi-config:with-virtualenv
      (add-args jedi:server-args
                "--virtual-env"
                jedi-config:with-virtualenv))))

;;(defvar jedi-config:use-system-python nil)
(setq flycheck-python-flake8-executable "flake8")

(defun elpy-hook ()
  "Wrapper fn for required actions during elpy initialization."
	(remove-hook 'elpy-modules 'elpy-module-flymake)
	(add-hook 'elpy-mode-hook 'flycheck-mode)
;;	(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
    ;; (add-hook 'elpy-mode-hook (lambda ()
    ;;                             (add-hook 'before-save-hook
    ;;                                       'elpy-black-fix-code nil t)))
	(elpy-enable))

(defun mypy-hook ()
  "Python hook, does all of the heavy lifting of initializing python environment."
  ;; (set (make-local-variable 'company-backends)
  ;;      '(company-jedi))
	(elpy-hook)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 2)
  (delete-selection-mode t)
  (disable-paredit-mode)

  (jedi:setup)
  (jedi:ac-setup)
  (electric-pair-mode 1)
  (flyspell-prog-mode)
  (imenu-add-menubar-index)

  (flycheck-mode 1)
  (subword-mode 1)
  (setq flycheck-checker 'python-pylint
        flycheck-checker-error-threshold 900
        flycheck-pylintrc "~/.pylintrc")
  )

(defn my-hook ()
  ;; Exports the hook through the namespace system
  (mypy-hook))

(add-hook 'python-mode-hook 'mypy-hook)

(when (require 'ipython nil t)
  (setq-default py-shell-name "ipython")
  (setq-default py-which-bufname "IPython")
  (setq py-python-command-args '("--matplotlib" "--colors" "LightBG")))

;; (setq ein:use-auto-complete t)
;; (setq ein:use-auto-pepcomplete-superpack t)
;; (setq ein:use-smartrep t))

;; (defn nosetests-all-virtualenv ()
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
