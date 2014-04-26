;;; dot-emacs/mode_config/settings.el --- lots of settings
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

(namespace settings
	   :use [cl]
	   :import [funcs]
	   :packages [sr-speedbar])


(setq sr-speedbar-width 30
      sr-speedbar-right-side nil
      sr-speedbar-skip-other-window-p t)


;; set all of these to TRUE
(funcs/set-list-items '(inhibit-startup-message
		  search-highlight
		  query-replace-highlight
		  mouse-sel-retain-highlight
		  bookmark-save-flag
		  font-lock-maximum-decoration
		  mouse-wheel-mode
		  x-select-enable-clipboard
		  global-font-lock-mode
		  xterm-mouse-mode
		  read-buffer-completion-ignore-case
		  read-file-name-completion-ignore-case
		  transient-mark-mode
		  line-number-mode
		  column-number-mode
		  highlight-parentheses-mode)
		t)

(progn
  (show-paren-mode 1)
  (ido-mode t)
  (setq ido-enable-flex-matching t)
  (menu-bar-mode -1)

  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

  (require 'uniquify)
  (setq uniquify-buffer-name-style 'forward)

  (require 'saveplace)
  (setq-default save-place t)
  (setq x-select-enable-clipboard t
        x-select-enable-primary t
        save-interprogram-paste-before-kill t
        apropos-do-all t
        mouse-yank-at-point t
        save-place-file (concat user-emacs-directory "places")
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups"))))))
