;;;; package  ---- This is my init, there are many others out there but this one is mine
;;;; Commentary:
;;;;
;;;; Code:
(eval-when-compile (require 'cl))
(setq debug-on-error t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(defvar *pidfile* "emacs-server.pid")
(defvar *emacs-load-start* (current-time))
(defvar *emacs-root* (file-name-directory (or load-file-name buffer-file-name)))
(defvar user-name (getenv "USER"))


;; avoid package init twice
(setq package-enable-at-startup nil)


(defun homedir+ (path)
  "Return absolute path to users home directory based on environment variables"
  (format "%s/%s" (getenv "HOME") path))

(defun emacsdir+ (path)
  "Create an bsolute path to ~/.emacs.d/``path``"
  (format "%s/.emacs.d/%s" (getenv "HOME") path))

(defun dotdir+ (path)
  "Return an absolute path to DOT-EMACS directory"
  (let (eroot (file-name-directory (or load-file-name buffer-file-name)))
    (expand-file-name (file-name-sans-versions path) eroot)))

(defun slurp (f)
  ""
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties
       (point-min)
       (point-max))))

;; add in global site-lisp if it exists
(let ((default-directory "/usr/share/emacs/site-lisp/"))
  (if (file-directory-p default-directory)
      (normal-top-level-add-subdirs-to-load-path)))

(mapc
 (lambda (pathdir)
    (add-to-list 'load-path pathdir))
 '((emacsdir+ "elpa") *emacs-root* (dotdir+ "external")))

;;(require 'exec-path-from-shell)
;; emacs on OSX has always been lame, luckily Steve Purcell solved this years ago.
;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))

;; emacs < 24 doesnt have packages functionality, load this in instead
(if (< (string-to-number emacs-version) 24)
    (lexical-let ((f (emacsdir+ "package.el")))

    (if (file-exists-p f)
        (load f)
      '(lambda ()
        "pull the file and load it"
        (url-copy-file "http://bit.ly/pkg-el23" f)
        (load f))))
  (require 'package))

(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
        ;;("melpa" . "https://melpa.org/packages/")
        ;;("marmalade" . "https://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/"))
      ;; setup a list of packages to install
      package-selected-packages '(split-string (slurp (dotdir+ "PACKAGES")) "\n" t)
      )

(package-initialize)
(package-refresh-contents)
(package-install-selected-packages)

(setq ;; activate path monkey-patching
      exec-path-from-shell t )
;; load in additional elisp libraries from local dirs
(dolist (e '("external/troels" "core/functions"))
  (load (dotdir+ e)))


;; Now that everything is loaded and present the mode files can be loaded
(mapc
 (lambda (dir)
   (dolist (word (files-in-below-directory (dotdir+ dir)))
     (load word)))
 '("mode_configs" "autoloads" "external"))


;;; I like to make Emacs a bitch to close (C-x C-c is sooo easy to hit):
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Last chance, your work would be lost. ")))
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Are you ABSOLUTELY certain that Emacs should close? ")))
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Should Emacs really close? ")))


;; ignore byte-compile warnings
(setq byte-compile-warnings '(not nresolved free-vars callargs redefine
                                  obsolete noruntime cl-functions
                                  interactive-only))


;; compile everything below *EMACS-ROOT* to help with startup next time around
(let ((dir (file-name-directory (or load-file-name buffer-file-name))))
  (byte-recompile-directory dir))

(require 'server)

(defun my--server-start ()
  "Custom function to start a named server."
  (let ((server-num 0))
    (while (server-running-p (unless (eq server-num 0) (concat "server" (number-to-string server-num))))
      (setq server-num (+ server-num 1)))
    (unless (eq server-num 0)
      (setq server-name (concat "server" (number-to-string server-num))))
    (server-start)
    (setq frame-title-format server-name)))

;;(my--server-start)
;;; init.el ends here
