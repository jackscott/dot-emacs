;;; dot-emacs.el --- 
;; 
;; Filename: dot-emacs.el
;; Description: 
;; Author: Jack Scott
;; Maintainer: 
;; Created: Mon Apr 20 23:27:11 2015 (-0400)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: 
;;           By: 
;;     Update #: 0
;; URL: 
;; Doc URL: 
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:


(eval-when-compile (require'cl))
(require 'namespaces)

(namespace dot-emacs
  :use [cl]
  :import [funcs]
  :packages [projectile])

;; sometimes :packages doesnt work
(require 'smartparens-config)

(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)
(setq projectile-file-exists-remote-cache-expire (* 10 60))

;; activate a bunch of modes and things
(funcs/set-list-items '(global-company-mode
                        projectile-global-mode
                        yas-global-mode
                        ido-mode
                        no-easy-keys
                        window-numbering-mode
                        winner-mode)
                      1)

(def *emacs-root* )
(def user-name (getenv "USER"))


;; add `~/.emacs.d/elpa'  to the load path
(mapc
 (lambda (pathdir)
    (add-to-list 'load-path pathdir))
 '((funcs/emacsdir+ "elpa") (file-name-directory (or load-file-name buffer-file-name))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dot-emacs.el ends here
