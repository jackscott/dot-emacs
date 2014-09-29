;;; dot-emacs/keybindings.el --- all my keybindings
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
(require 'namespaces)
(namespace keys
	   :import [funcs visual])

(defn mychmod()
  "Performs a chmod & chown on the current file."
  (interactive)
  (shell-command (format "sudo chown :users %s && sudo chmod 775 %s" (buffer-file-name buffer-file-name)))
  ;;(shell-command (concat "sudo chmod 775 " (buffer-file-name)))
  (myrefresh))

;;
(defn myrefresh()
  "Reloads the file from disk"
  (interactive)
  (revert-buffer t t)
  (message (format "Reloaded %s from disk" (buffer-file-name))))

(global-set-keys 
 "\M-`"         'shell
 "\C-xh"        (~ funcs/mychmod)
 "\C-xr"        (~ funcs/myrefresh)
 "\C-xl"        'goto-line
 "\C-w"         'backward-kill-word
 "\C-x\C-k"     'kill-region
  "\C-xw"        'goto-line
 "\C-x\C-b"     'buffer-menu
 "\C-cn"        'bs-cycle-next
 "\C-cp"        'bs-cycle-previous
 "\C-ce"        'eshell
 "\C-c\C-e"     'eshell
 "\C-ck"        'compile
 "\C-x!"        'shell-command
 "\C- "         'set-mark-command
 "\M-x"         'execute-extended-command
 "\M-c"         'capitalize-word

 "\C-\M-z"      'undo
 "\C-s"         'isearch-forward
 "\C-xp"        'mypylint
 "\C-x\C-e"     'eval-region
 "\C-cg"        'magit-status
 
 "\C-c\C-o"     'slime-close-all-parens-in-sexp
 "\C-c\C-p"     'paredit-open-round
 "\C-f"		'right-char
)

(define-key isearch-mode-map "\C-s" 'isearch-repeat-forward)


;;;;;
;; Mouse Definitions
;;;;;
(defun up-slightly ()   (interactive) (scroll-up 1))
(defun down-slightly () (interactive) (scroll-down 1))

(global-set-key "\M-n" 'forward-paragraph)
(global-set-key "\M-p" 'backward-paragraph)

(global-set-key [mouse-5] 'up-slightly )
(global-set-key [mouse-6] 'down-slightly )
;; for some reason this is necessary for the mac
(global-set-key [mouse-4] 'down-slightly )

(global-set-key (kbd "<C-tab>") 'other-window)
;;(global-set-key "\C-\M-z" 'undo)

;Add alternatives to M-x, on the recommendation of Steve Yegge.
;<http://steve.yegge.googlepages.com/effective-emacs>
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;;(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs)
(global-set-key "\C-x]" 'slime-close-all-parens-in-sexp)

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

;"Rebind <RET> key to do automatic indentation in certain modes (not haskell-mode)."
;<http://www.metasyntax.net/unix/dot-emacs.html>
(mapc
 (lambda (mode)
   (let ((mode-hook (intern (concat (symbol-name mode) "-hook"))))
     (add-hook mode-hook (lambda nil (local-set-key (kbd "RET") 'newline-and-indent)))))
 '(ada-mode c-mode c++-mode cperl-mode emacs-lisp-mode java-mode html-mode
            lisp-mode perl-mode php-mode prolog-mode ruby-mode scheme-mode
            sgml-mode sh-mode sml-mode tuareg-mode python-mode))
