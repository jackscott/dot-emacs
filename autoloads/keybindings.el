;;; dot-emacs/keybindings.el --- all my keybindings
;;
;; Copyright (C) 2013-2015  Jack Scott (emacspinky@gmail.com)
;;
;; Authors:  Jack Scott (emacspinky@gmail.com)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
(require 'namespaces)
(namespace keys
  :import [funcs visual]
  :packages [browse-at-remote])

;;(global-set-key (kbd "C-c ") 'browse-at-remote)

;; 
(global-set-keys 
 "\M-`"         'shell
 "\C-xr"        (~ funcs/myrefresh)
 "\C-xl"        'goto-line
 "\C-w"         'backward-kill-word
 "\C-x\C-k"     'kill-region
 "\C-x\C-b"     'buffer-menu
 "\C-cn"        'bs-cycle-next
 "\C-cp"        'bs-cycle-previous
 "\C-ck"        'compile
 "\C-x!"        'shell-command
 "\C- "         'set-mark-command
 "\M-x"         'execute-extended-command
 "\M-c"         'capitalize-word
 "\C-\M-z"      'undo
 "\C-s"         'isearch-forward
 "\C-xe"        'eval-region
 "\C-cg"        'magit-status
 "\C-c\C-o"     'slime-close-all-parens-in-sexp
 "\C-c\C-p"     'paredit-open-round
 "\C-f"		'right-char
 "\M-n" 'forward-paragraph
 "\M-p" 'backward-paragraph
 
 ;Add alternatives to M-x, on the recommendation of Steve Yegge.
 ;<http://steve.yegge.googlepages.com/effective-emacs>
 "\C-x\C-m" 'execute-extended-command
 "\C-c\C-m" 'execute-extended-command

 "\C-x]" 'slime-close-all-parens-in-sexp)

(define-key isearch-mode-map "\C-s" 'isearch-repeat-forward)


;;;;;
;; Mouse Definitions
;;;;;
(defun up-slightly ()   (interactive) (scroll-up 1))
(defun down-slightly () (interactive) (scroll-down 1))

(global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1)))
(global-set-key [mouse-6] '(lambda  () (interactive) (scroll-down 1)))

;; (global-set-key "\M-n" 'forward-paragraph)
;; (global-set-key "\M-p" 'backward-paragraph)

;; for some reason this is necessary for the mac
(global-set-key [mouse-4] 'down-slightly )

(global-set-key (kbd "<C-tab>") 'other-window)
;;(global-set-key "\C-\M-z" 'undo)

;Add alternatives to M-x, on the recommendation of Steve Yegge.
;<http://steve.yegge.googlepages.com/effective-emacs>
;; (global-set-key "\C-x\C-m" 'execute-extended-command)
;; (global-set-key "\C-c\C-m" 'execute-extended-command)

;;(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs)
;;(global-set-key "\C-x]" 'slime-close-all-parens-in-sexp)


;; (define-prefix-command 'Apropos-Prefix nil "Apropos (a,c,d,i,l,v,C-v)")
;; (global-set-key (kbd "C-h C-a") 'Apropos-Prefix)
;; (define-key Apropos-Prefix (kbd "a")   'apropos)
;; (define-key Apropos-Prefix (kbd "C-a") 'apropos)
;; (define-key Apropos-Prefix (kbd "c")   'apropos-command)
;; (define-key Apropos-Prefix (kbd "d")   'apropos-documentation)
;; (define-key Apropos-Prefix (kbd "i")   'info-apropos)
;; (define-key Apropos-Prefix (kbd "l")   'apropos-library)
;; (define-key Apropos-Prefix (kbd "v")   'apropos-variable)
;; (define-key Apropos-Prefix (kbd "C-v") 'apropos-value)

