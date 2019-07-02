;;; dot-emacs/visual.el --- making things pretty
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

;; https://github.com/jscott/dot-emacs
(require 'namespaces)
(namespace visual
	   :use [cl]
	   :import [funcs])

(add-to-list 'custom-theme-load-path (dotdir+ "themes"))

(defun my-theme-set-default ()
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))

(defun my-describe-theme ()
  (interactive)
  (message "%s" (car theme-current)))

(defun my-theme-cycle ()
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (message "%S" (car theme-current)))

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

;; ;(setq linum-format "%4d \u2502")
;; (setq linum-format "%4d")
;; ;(setq linum-format "%d ")
;; (global-linum-mode t)

(setq ring-bell-function 'ignore)
(menu-bar-mode -1)
(blink-cursor-mode -1)

;;(color-theme-initialize)
(setq color-theme-is-global 0)


;;; TODO
;; refactor this, grouping into categroies and changing the theme
;; category depending on the time of day.  maybe cycle themes every 20-30
;; mins, might get annoying
(setq my-color-themes '(list
                        'color-theme-darktooth
                        'color-theme-anti-zenburn-theme
                       'color-theme-ld-dark
                       'color-theme-calm-forest
                       'color-theme-gray30
                       'color-theme-jsc-dark
                       'color-theme-sitaramv-solaris
                       'color-theme-resolve
                       'color-theme-classic
                       'color-theme-jonadabian-slate
                       'color-theme-kingsajz
                       'color-theme-shaman
                       'color-theme-subtle-blue
                       'color-theme-snowish
                       'color-theme-sitaramv-nt
                       'color-theme-wheat))

(setq theme-current my-color-themes)
(my-theme-set-default)

(setf pop-up-windows nil        ; Don't change my windowconfiguration.
      european-calendar-style t         ; Use european date format.
      delete-auto-save-files t   ; Delete unnecessary auto-save files.
      major-mode 'text-mode ; At least this mode won't do anything stupid.
      scroll-step 1                   ; Only move in small increments.
      frame-title-format "%b GNU Emacs" ; Make the frame a bit more useful.
      mail-user-agent 'gnus-user-agent
      fill-column 100
      dired-recursive-copies t)

;; need to override the color coming from color-theme for some reason
(set-face-foreground 'mode-line-buffer-id "blue")

(global-hl-line-mode nil)

;"Set up highlighting of special words for selected modes."
; <http://www.metasyntax.net/unix/dot-emacs.html>
(make-face 'super-special-words)
(set-face-attribute 'super-special-words nil
                    :foreground "White"
                    :background "Firebrick")

(let ((pattern "\\<\\(FIXME\\|TODO\\|NOTE\\|WARNING\\|BUGS\\|USE\\):"))
  (mapc
   (lambda (mode)
     (font-lock-add-keywords mode `((,pattern 1 'super-special-words prepend))))
   ;; NOTE: can't de do `prog-mode` or something like that here?
   '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode java-mode haskell-mode
              literate-haskell-mode html-mode lisp-mode php-mode python-mode
              ruby-mode scheme-mode sgml-mode sh-mode sml-mode tuareg-mode)))


;; this setup looks decent on macs
(if (member "Iconsolata" (font-family-list))
    (set-face-attribute 'default t
                        :family "Inconsolata" :height 215 :weight 'normal))


;; cycle through color themes
(global-set-key [f12] 'my-theme-cycle)
(global-set-key (kbd "M-<return>") 'toggle-fullscreen)
;;(color-theme-dark-laptop)
;;(toggle-fullscreen)

