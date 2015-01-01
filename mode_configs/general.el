;;; dot-emacs/mode_config/general.el --- general settings
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
(eval-when-compile (require'cl))
(require 'namespaces)

(namespace general
	   :use [cl uniquify]
	   :export []
	   :packages [yasnippet ido sr-speedbar bug-reference-github])

(require 'no-easy-keys)
(no-easy-keys 1)

;; setup auto-complete stuff.  
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (emacsdir+ "ac-dict"))
(ac-config-default)
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
(setq ac-auto-start 2 ac-ignore-case nil)


;; yasnippet
(yas-global-mode 1)
(add-to-list 'ac-sources 'ac-source-yasnippet)


;; git configuration
(with-feature 'vc-git
  (add-to-list 'vc-handled-backends 'git))

(autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)

;; Apache mdoe
(with-feature 'apache-mode
  (add-to-list 'auto-mode-alist '("commonapache[12]\?\\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("^.+\/vhosts\.d\/.+\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("^.+\/modules\.d\/.+\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("\\.htaccess\\|\\httpd\\.conf\\|\\access\\.conf\\|\\apache[12]\?\\.conf" . apache-mode)))


(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(ido-mode t)

(when (require 'autopair nil t)
  (setq autopair-mode t))


;; (setq-default abbrev-mode t)
;; (setq abbrev-file-name (emacsdir+ "abbrev_defs.txt"))
;; (define-abbrev-table 'global-abbrev-table
;;   '(("afaict" "as far as I can tell" nil 1)
;;     ("omuse" "http://www.emacswiki.org/cgi-bin/oddmuse.pl" nil 0)
;;     ("btw" "by the way" nil 3)
;;     ("wether" "whether" nil 5)
;;     ("ewiki" "http://www.emacswiki.org/cgi-bin/wiki.pl" nil 3)
;;     ("pov" "point of view" nil Make)
;;     ))

(add-hook 'prog-mode-hook 'bug-reference-github-set-url-format)
