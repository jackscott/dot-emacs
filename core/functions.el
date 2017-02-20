;;; dot-emacs/functions.el --- collection of functions and macros
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

(namespace funcs
	   :use [cl]
	   :export [set-list-items toggle-bars
                             mychmod
                             myrefresh
                             sr-speedbar
                             home-dir
                             emacs-dir
                             dot-dir
                             slurp])


(defn home-dir (pth)
  (homedir+ pth))

(defn emacs-dir (pth)
  (emacsdir+ pth))

(defun emacsdir+ (path)
  "Create an bsolute path to ~/.emacs.d/``path``"
  (format "%s/.emacs.d/%s" (getenv "HOME") path))

(defn dot-dir (pth)
  (format "%s/snippets" *emacs-root*))

(defn toggle-bars ()
  (interactive)
  (scroll-bar-mode)
  (menu-bar-mode)
  (tool-bar-mode)
  (sr-speedbar-open))

(defn mychmod()
  "Performs a chmod & chown on the current file."
  (interactive)
  (shell-command (format "sudo chown :users %s && sudo chmod 775 %s" (buffer-file-name buffer-file-name)))
  ;;(shell-command (concat "sudo chmod 775 " (buffer-file-name)))
  (myrefresh))

(defn myrefresh()
  "Reloads the file from disk"
  (interactive)
  (revert-buffer t t)
  (message (format "Reloaded %s from disk" (buffer-file-name))))

;;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
;"To hit tab to auto-complete (like bash does) put this in your .emacs:"
;<http://www.emacswiki.org/cgi-bin/wiki/EmacsNiftyTricks>
(defun indent-or-complete ()
  "Complete if point is at end of line, and indent line."
  (interactive)
  (if (and (looking-at "$") (not (looking-back "^\\s-*")))
      (hippie-expand nil))
  (indent-for-tab-command))

(add-hook 'find-file-hooks (function (lambda ()
                                       (local-set-key (kbd "<tab>") 'indent-or-complete))))

(defun scroll-down-keep-cursor ()
   ;; Scroll the text one line down while keeping the cursor
   (interactive)
   (scroll-down 1))

(defun scroll-up-keep-cursor ()
   ;; Scroll the text one line up while keeping the cursor
   (interactive)
   (scroll-up 1)) 


(defun files-in-below-directory (directory)
  "List the .el files in DIRECTORY and in its sub-directories."
  (interactive "Dir name: ")
  (let (el-files-list
	(current-directory-list
	 (directory-files-and-attributes directory t)))
    (while current-directory-list
      (cond
       ((equal ".el" (substring (car (car current-directory-list)) -3))
	(setq el-files-list
	      (cons (car (car current-directory-list)) el-files-list)))
       ((eq t (car (cdr (car current-directory-list))))
	(if
	    (equal "."
		   (substring (car (car current-directory-list)) -1))
	    ()
	  (setq el-files-list
		(append
		 (files-in-below-directory
		  (car (car current-directory-list)))
		 el-files-list)))))
      (setq current-directory-list (cdr current-directory-list)))
    el-files-list))

(defn set-list-items (thelist val)
  "Iterate THELIST calling (SET `key` VAL)"
  (mapc #'(lambda (x) (set x val)) thelist))

(defun start-desktop ()
  "Load up previous desktop and turn on autosaving"
  (interactive)
  (let ((desktop-load-locked-desktop "ask"))
    (desktop-read)
    (desktop-save-mode 1)))

