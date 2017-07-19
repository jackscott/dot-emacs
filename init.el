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

(when (memq window-system '(mac ns))
  
  (exec-path-from-shell-initialize))

(defun homedir+ (path)
  "Return absolute path to users home directory based on environment variables"
  (format "%s/%s" (getenv "HOME") path))

(defun emacsdir+ (path)
  "Create an bsolute path to ~/.emacs.d/``path``"
  (format "%s/.emacs.d/%s" (getenv "HOME") path))

(defun dotdir+ (path)
  "Return an absolute path to DOT-EMACS directory"
  (let ((eroot (file-name-directory (or load-file-name buffer-file-name))))
    (expand-file-name (file-name-sans-versions path) eroot)))

(defun slurp (f)
  ""
  (with-temp-buffer
    (insert-file-contents f)
    (buffer-substring-no-properties
       (point-min)
       (point-max))))

;; add in global site-lisp if it exists
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (if (file-directory-p default-directory)
      (normal-top-level-add-subdirs-to-load-path)))



(mapc
 (lambda (pathdir)
    (add-to-list 'load-path pathdir))
 '((emacsdir+ "elpa")
   *emacs-root*))

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
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ;;("marmalade" . "https://marmalade-repo.org/packages/")
        ;;("gnu" . "http://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(package-initialize)
(setq package-selected-packages '(split-string (slurp (dotdir+ "PACKAGES")) "\n" t))
(package-refresh-contents)
(package-install-selected-packages)


;; load in additional elisp libraries from local dirs
(dolist (e '("external/troels"  "core/functions"))
  (load (dotdir+ e)))

;; Now that everything is loaded and present the mode files can be loaded
(mapc
 (lambda (dir)
   (dolist (word (files-in-below-directory (dotdir+ dir)))
     (load word)))
 '("mode_configs" "autoloads"))


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
