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


;; https://github.com/jscott/dot-emacs
(eval-when-compile (require'cl))
(require 'namespaces)

(namespace general
	   :use [cl uniquify]
	   :export []
	   :packages [yasnippet ido sr-speedbar bug-reference-github
                                projectile rainbow-delimiters-mode
                                company-mode magit-gh-pulls])

(require 'no-easy-keys)
(no-easy-keys 1)


(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-file-exists-remote-cache-expire (* 10 60))

(defun global-init-hook ()
  (global-company-mode)
  (projectile-global-mode)
  (yas-global-mode)
  (ido-mode))

(add-hook 'after-init-hook 'global-init-hook)

;; setup auto-complete stuff.  
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (emacsdir+ "ac-dict"))
(ac-config-default)
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
(setq ac-auto-start 2 ac-ignore-case nil)
(add-to-list 'ac-sources 'ac-source-yasnippet)

(defun global-magit-hook ()
  (magit-filenotify-mode)
  (turn-on-magit-gh-pulls))
(add-hook 'magit-mode-hook 'global-magit-hook)

(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")

(defun global-prog-mode-hook ()
  (rainbow-delimiters-mode)
  (bug-reference-github-set-url-format))
(add-hook 'prog-mode-hook 'global-prog-mode-hook)
