;;; dot-emacs/functions.el --- collection of functions and macros
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
(require'cl)
;; (require 'namespaces)

;; (namespace js-functions
;; 	   :use [ cl]
;; 	   :export [ with-feature
;; 		     with-features
;; 		     scroll-up
;; 		     scroll-down])

;; ;;;;;
;; ;;; noerr-require with-feature and withfeatures came from this guy:
;; ;;; git://github.com/Athas/Configuration-Files.git  but way before it
;; ;;; was in github.
;; ;;;;;

;; (defun noerr-require (feature)
;;   "`require' FEATURE, but don't invoke any Lisp errors.
;; If FEATURE cannot be loaded, this function will print an error
;; message through `message' and return nil. It otherwise behaves
;; exactly as `require'."
;;   (ignore-errors
;;     (require feature (symbol-name feature) t)))

;; (defmacro with-feature (feature &rest body)
;;   "Require FEATURE and execute BODY.
;; If FEATURE can't be loaded, don't execute BODY."
;;   (when (_ noerr-require (car feature))
;;     (push 'progn body)))

;; (defmacro with-features (features &rest body)
;;   "Require FEATURES and execute BODY.
;; If any of FEATURES cannot be loaded, don't execute BODY."
;;   (if features
;;       `(with-feature (,(first features))
;;          (with-features ,(cdr features)
;;            ,@body))
;;     `(progn ,@body)))


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


;; ;Make cursor stay in the same column when scrolling using pgup/dn.
;; ;Previously pgup/dn clobbers column position, moving it to the
;; ;beginning of the line.
;; ;<http://www.dotemacs.de/dotfiles/ElijahDaniel.emacs.html>
;; (defadvice scroll-up (around ewd-scroll-up first act)
;;   "Keep cursor in the same column."
;;   (let ((col (current-column)))
;;     ad-do-it
;;     (move-to-column col)))

;; (defadvice scroll-down (around ewd-scroll-down first act)
;;   "Keep cursor in the same column."
;;   (let ((col (current-column)))
;;     ad-do-it
;;     (move-to-column col)))


;; (defun pkg-check-p (favorite-packages)
;;   "Verifies that the items in FAVORITE_PACKAGES have been installed"
;;     (loop for p in favorite-packages
;;                   when (not (package-installed-p p)) do (return nil)
;;                           finally (return t)))


(defun php-lint ()
  "Performs a PHP lint-check on the current file."
  (interactive)
  (shell-command (concat "php -n -l " (buffer-file-name))))

(defun jslint-thisfile ()
  (interactive)
  (compile (format "jsl -process %s" (buffer-file-name))))

(defun mypylint ()
  "Performs pylint on the current file, will try to look for a pylint.rc file"
  (interactive)
  (let ((h (getenv "HOME"))
        (cmd (s-trim (shell-command-to-string "/usr/bin/which pylint")))
        ;(cmd "/usr/local/share/python/pylint -E")
        (f "/repos/yieldbot/pylint.rc"))
    (if (file-exists-p (concat h f))
        (compile (format "%s -E --rcfile=%s %s" cmd (concat h f) (buffer-file-name)))
      (compile (format "%s -E %s" cmd (buffer-file-name))))))


(defun mychmod()
  "Performs a chmod & chown on the current file."
  (interactive)
  (shell-command (format "sudo chown :users %s && sudo chmod 775 %s" (buffer-file-name buffer-file-name)))
  ;;(shell-command (concat "sudo chmod 775 " (buffer-file-name)))
  (myrefresh))

;;
(defun myrefresh()
  "Reloads the file from disk"
  (interactive)
  (revert-buffer t t)
  (message (format "Reloaded %s from disk" (buffer-file-name))))


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

(defun set-list-items (thelist val)
  "Iterate THELIST and pass VAL to set"
  (mapc #'(lambda (x) (set x val)) thelist))

