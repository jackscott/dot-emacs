;;; dot-emacs/mode_configs/mytramp.el --- useful things for tramp
;;; sessions. Came from emacsWiki originally, been riffing on it.

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


;; (eval-when-compile (require'cl))
;; (require 'namespaces)
;; (namespace tramp
;; 	   :use [cl]
;; 	   :export [find-file-root-prefix find-file-root-history
;;                                           find-file-root-hook find-file-root])


;; (defmutable find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
;;   "*The filename prefix used to open a file with `find-file-root'.")

;; (defmutable find-file-root-history nil
;;   "History list for files found using `find-file-root'.")

;; (defmutable find-file-root-hook nil
;;   "Normal hook for functions to run after finding a \"root\" file.")

;; (defn find-file-root ()
;;   "*Open a file as the root user.
;;    Prepends `find-file-root-prefix' to the selected file name so that it
;;    maybe accessed via the corresponding tramp method."

;;   (interactive)
;;   (require 'tramp)
;;   (let* ( ;; We bind the variable `file-name-history' locally so we can
;; 	 ;; use a separate history list for "root" files.
;; 	 (file-name-history (@ find-file-root-history))
;; 	 (name (or buffer-file-name default-directory))
;; 	 (tramp (and (tramp-tramp-file-p name)
;; 		     (tramp-dissect-file-name name)))
;; 	 path dir file)

;;     ;; If called from a "root" file, we need to fix up the path.
;;     (when tramp
;;       (setq path (tramp-file-name-localname tramp)
;; 	    dir (file-name-directory path)))

;;     (when (setq file (read-file-name "Find file (UID = 0): " dir path))
;;       (find-file (concat (@ find-file-root-prefix) file))
;;       ;; If this all succeeded save our new history list.
;;       (setq find-file-root-history file-name-history)
;;       ;; allow some user customization
;;       (run-hooks '(@ find-file-root-hook)))))

;; (global-set-key [(control x) (control r)] (~ find-file-root))
