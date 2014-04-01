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

(require 'auto-complete-config)
(ac-config-default)
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'ac-sources 'ac-source-yasnippet)

;; turn off these variables
(set-list-items '(make-backup-files
		  auto-save-list-file-name
		  auto-save-default
		  indent-tabs-mode
		  scroll-bar-mode)
		nil)

;; activate these vars
(set-list-items '(inhibit-startup-message
		  search-highlight
		  query-replace-highlight
		  mouse-sel-retain-highlight
		  bookmark-save-flag
		  font-lock-maximum-decoration
		  mouse-wheel-mode
		  x-select-enable-clipboard
		  show-paren-mode
		  global-font-lock-mode
		  xterm-mouse-mode
		  read-buffer-completion-ignore-case
		  read-file-name-completion-ignore-case
		  transient-mark-mode
		  line-number-mode
		  column-number-mode
		  show-paren-mode
		  highlight-parentheses-mode)
		t)

(display-time)

;; git configuration
(when (require 'vc-git nil t)
  (add-to-list 'vc-handled-backends 'git))

(autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)

;; Apache mdoe
(when (require 'apache-mode nil t)
  (add-to-list 'auto-mode-alist '("commonapache[12]\?\\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("^.+\/vhosts\.d\/.+\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("^.+\/modules\.d\/.+\.conf$" . apache-mode))
  (add-to-list 'auto-mode-alist '("\\.htaccess\\|\\httpd\\.conf\\|\\access\\.conf\\|\\apache[12]\?\\.conf" . apache-mode)))

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(require 'ido)
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
(require 'sr-speedbar)
(setq sr-speedbar-width 40)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))

