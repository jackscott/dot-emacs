(eval-when-compile (require 'cl))
(require 'package)
(setq package-enable-at-startup nil) ; To avoid initializing twice

(defvar *pidfile* "emacs-server.pid")
(defvar *emacs-load-start* (current-time))
(defvar *emacs-root* (file-name-directory (or load-file-name buffer-file-name)))
(defvar user-name (getenv "USER"))

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
        (load f)))))

(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

;; (defun read-lines (filePath)
;;   "Return a list of lines of a file at filePath."
;;   (with-temp-buffer
;;     (insert-file-contents filePath)
;;     (split-string (buffer-string) "\n" t)))

;; Load in packages
(mapc
 (lambda (pkgname)
    (if (not (package-installed-p pkgname))
	(package-install pkgname)))
 '(s
auto-complete
bash-completion
bookmark+
concurrent
ctable
dash
deferred
epc
find-things-fast
flymake-easy
groovy-mode
highlight-parentheses
icicles
logito
lua-mode
magit
markdown-mode
paredit
pcache
projectile
gist
no-easy-keys
helm
helm-delicious
yas-jit
ac-ispell
ac-helm
ac-etags
smartparens
rainbow-mode
wanderlust
inf-ruby
projectile
rspec-mode
fullframe
anzu))


(dolist (e '("external/troels"  "core/functions"))
  (load (dotdir+ e)))

;; load everything under these two directories
(mapc
 (lambda (dir)
   (dolist (word (files-in-below-directory (dotdir+ dir)))
     (load word)))
 '("mode_configs" "autoloads"))


;;; 1 Emacs a bitch to close (C-x C-c is sooo easy to hit):
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

;; compile everything below *EMACS-ROOT*
(let ((dir (file-name-directory (or load-file-name buffer-file-name))))
  (byte-recompile-directory dir))
