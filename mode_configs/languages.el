;;; dot-emacs/mode_config/languages.el --- general settings
;;
;; Copyright (C) 2013  Jack Scott (js@nine78.com)
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

;; https://github.com/jscott/dot-emacs

;; javascript
(when (require 'javascript-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode)))
;; php
(when (require 'php-mode nil t)
  (add-hook 'php-mode-user-hook 'turn-on-font-lock)
  ;; PHP-Mode
  (add-to-list 'auto-mode-alist
	       '("\\.php[34]\\'\\|\\.php\\'\\|\\.phtml\\'\\|\\.module\\'\\|\\.inc\\'"
		 . php-mode)))



;; CSS-Mode
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)

(defun bash-mode ()
  (shell-script-mode)
  (sh-set-shell "bash"))

(setq auto-mode-alist (cons '("\\.bash\\'\\|\\.sh\\'" . bash-mode) auto-mode-alist))

;;Taken from the default .emacs file on a gentoo-system
;; Copyright Gentoo Foundation 
;;ebuild-mode settings
(defun ebuild-mode ()
  (shell-script-mode)
  ;;(sh-set-shell "bash") 
  (make-local-variable 'tab-width)
  (setq tab-width 4))

(setq auto-mode-alist (cons '("\\.ebuild\\'" . ebuild-mode) auto-mode-alist)) 
(setq auto-mode-alist (cons '("\\.eclass\\'" . ebuild-mode) auto-mode-alist))

;"Rebind <RET> key to do automatic indentation in certain modes (not haskell-mode)."
;<http://www.metasyntax.net/unix/dot-emacs.html>
(mapc
 (lambda (mode)
   (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
     (add-hook mode-hook (lambda nil (local-set-key (kbd "RET") 'newline-and-indent)))))
 '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode java-mode html-mode
            lisp-mode perl-mode php-mode prolog-mode ruby-mode scheme-mode
            sgml-mode sh-mode sml-mode tuareg-mode python-mode))
