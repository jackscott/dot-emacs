;;; dot-emacs/visual.el --- all my keybindings
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
;; (require 'namespaces)
;; (namespace js-visual
;; 	   :use [cl]
;; 	   :import [ (js-functions with-feature) ])

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

;; ;(setq linum-format "%4d \u2502")
;; (setq linum-format "%4d")
;; ;(setq linum-format "%d ")
;; (global-linum-mode t)

(when (require 'color-theme nil t)
   (color-theme-initialize)
   (setq color-theme-is-global 0)
   (setq ring-bell-function 'ignore)
   (menu-bar-mode -1)
   (blink-cursor-mode -1)

   (setq my-color-themes (list 'color-theme-dark-laptop 'color-theme-ld-dark
			       'color-theme-calm-forest
			       'color-theme-gray30 'color-theme-jsc-dark
			       'color-theme-sitaramv-solaris 'color-theme-resolve
			       'color-theme-classic 'color-theme-jonadabian-slate
			       'color-theme-kingsajz 'color-theme-shaman
			       'color-theme-subtle-blue 'color-theme-snowish
			       'color-theme-sitaramv-nt 'color-theme-wheat))

   (setq theme-current my-color-themes)
   (my-theme-set-default)
   (global-set-key [f12] 'my-theme-cycle))


(setf pop-up-windows nil        ; Don't change my windowconfiguration.
      european-calendar-style t         ; Use european date format.
      delete-auto-save-files t   ; Delete unnecessary auto-save files.
      major-mode 'text-mode ; At least this mode won't do anything stupid.
      scroll-step 1                   ; Only move in small increments.
      frame-title-format "%b GNU Emacs" ; Make the frame a bit more useful.
      mail-user-agent 'gnus-user-agent
      fill-column 80
      dired-recursive-copies t)

;; need to override the color coming from color-theme for some reason
;;(set-face-foreground 'mode-line-buffer-id "darkblue")

(global-hl-line-mode nil)
;;(set-face-background 'hl-line "#111")


;"Set up highlighting of special words for selected modes."
; <http://www.metasyntax.net/unix/dot-emacs.html>
(make-face 'taylor-special-words)
(set-face-attribute 'taylor-special-words nil :foreground "White" :background "Firebrick")
(let ((pattern "\\<\\(FIXME\\|TODO\\|NOTE\\|WARNING\\|BUGS\\|USE\\):"))
  (mapc
   (lambda (mode)
     (font-lock-add-keywords mode `((,pattern 1 'taylor-special-words prepend))))
   '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode java-mode haskell-mode
              literate-haskell-mode html-mode lisp-mode php-mode python-mode ruby-mode
              scheme-mode sgml-mode sh-mode sml-mode tuareg-mode)))


;; this setup looks decent on macs
(if (member "Iconsolata" (font-family-list))
    (set-face-attribute 'default t
                        :family "Inconsolata" :height 215 :weight 'normal))
