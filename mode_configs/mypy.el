;;; dot-emacs/mode_config/myppy.el --- python things
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
(namespace mypy
	   :import [funcs]
	   :packages [python
                      pyflakes
                      pylint
                      python-pep8
                      python-pylint
                      virtualenvwrapper
                      jedi
                      nose
                      helm-pydoc
                      elpy
                      autopair
                      flymake-python-pyflakes])

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
      jedi:setup-keys t
      jedi:complete-on-dot t
      py-indent-offset 4
      py-smart-indentation t
      indent-tabs-mode nil
      elpy-rpc-backend "jedi")

(defun my-python-mode-hook ()
  (autopair-mode 1)
  (elpy-enable)
  (jedi:setup)
  (jedi:ac-setup))

(add-hook 'python-mode-hook 'my-python-mode-hook)

(when (require 'ipython nil t)
  (setq-default py-shell-name "ipython")
  (setq-default py-which-bufname "IPython")
  (setq py-python-command-args '("--matplotlib" "--colors" "LightBG")))

;; (setq ein:use-auto-complete t)
;; (setq ein:use-auto-complete-superpack t)
;; (setq ein:use-smartrep t))

(defn nosetests-all-virtualenv ()
  (interactive)
  (let ((nose-global-name
         (format
          "~/.virtualenvs/%s/bin/nosetests"
          (car
           (last
            (delete
             ""
             (split-string
              (nose-find-project-root)
              "/")))))))
    (nosetests-all)))
