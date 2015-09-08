;;; dot-emacs/mode_config/general.el --- general settings
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


;; https://github.com/jackscott/dot-emacs
(eval-when-compile (require'cl))
(require 'namespaces)

(namespace general
	   :use [cl uniquify]
           :import [funcs]
	   :export []
	   :packages [yasnippet
                      ido
                      sr-speedbar
                      bug-reference-github
                      projectile
                      rainbow-delimiters
                      company
                      window-numbering
                      helm-ag
                      swiper
                      swiper-helm
                      yafolding])


;;for some reason these dont work with :packages 
(require 'smartparens-config)
(require 'no-easy-keys)

(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-file-exists-remote-cache-expire (* 10 60))


(require 'anzu)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; setup auto-complete stuff.  
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (emacsdir+ "ac-dict"))
(ac-config-default)
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)

(setq ac-auto-start 2 ac-ignore-case nil)
(add-to-list 'ac-sources 'ac-source-yasnippet)



;; Magit stuff
(setq magit-auto-revert-mode nil
      magit-last-seen-setup-instructions "1.4.0")


(require 'fullframe)
(fullframe magit-status magit-mode-quit-window nil)

;; I like uniquify but not vanilla
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;"Rebind <RET> key to do automatic indentation in certain modes (not haskell-mode)."
;<http://www.metasyntax.net/unix/dot-emacs.html>
(defun auto-indent ()
  (let ((modes '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode
                          java-mode html-mode lisp-mode perl-mode
                          php-mode prolog-mode ruby-mode scheme-mode
                          sgml-mode sh-mode sml-mode tuareg-mode python-mode))
        (mode-hook (lambda (mode) (intern (concat (symbol-name mode) "-hook"))))
        (myfn (lambda (mode)
                (add-hook (mode-hook mode)
                          (lambda nil (local-set-key (kbd "RET") 'newline-and-indent))))))
    (mapc myfn modes)))


;; these will be enabled in all prog-mode descendant modes
(defun global-prog-mode-hook ()
  (rainbow-delimiters-mode)
  (bug-reference-github-set-url-format)
  (smartparens-global-mode t)
  (flyspell-prog-mode)
  (show-smartparens-global-mode t))

(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t))

(add-hook 'prog-mode-hook 'global-prog-mode-hook)
