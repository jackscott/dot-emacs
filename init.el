(eval-when-compile (require 'cl))

(defun homedir+ (path)
  "Return absolute path to users home directory based on environment variables"
  (format "%s/%s" (getenv "HOME") path))

(defun emacsdir+ (path)
  "Create an bsolute path to ~/.emacs.d/``path``"
  (format "%s/.emacs.d/%s" (getenv "HOME") path))

(defvar emacs-root (file-name-directory (or load-file-name buffer-file-name)))
(defun dotdir+ (path)
  "Return an absolute path to DOT-EMACS directory"
  (format "%s%s" emacs-root path))

  

(defvar *pidfile* "emacs-server.pid")
(defvar *emacs-load-start* (current-time))
(defvar user-name (getenv "USER"))

(defvar autosave-dir (emacsdir+ "auto-save-list"))

(mapc
 (lambda (pathdir)
    (add-to-list 'load-path pathdir))
 '((emacsdir+ "elpa") emacs-root ))

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

;; Load in packages
(mapc
 (lambda (pkgname)
    (if (not (package-installed-p pkgname))
	(package-install pkgname)))

 '(namespaces clojure-mode cider better-defaults rainbow-delimiters
              auto-complete bash-completion bookmark+
	      color-theme color-theme-approximate
	      color-theme-solarized color-theme-tango concurrent
	      ctable dash deferred epc find-things-fast flymake-easy
	      flymake-jslint flymake-python-pyflakes groovy-mode
	      highlight-parentheses icicles json-mode logito lua-mode
	      magit markdown-mode mmm-mode paredit pcache php+-mode php-mode
	      popup psgml pyflakes pylint python-pep8 python-pylint s slime
	      virtualenvwrapper tangotango-theme naquadah-theme gist
	      ein jedi nose elpy no-easy-keys
	      helm helm-spotify helm-pydoc helm-delicious yas-jit
              ac-slime ac-nrepl ac-ispell ac-helm ac-etags
              starter-kit-js smartparens))

(dolist (e '("external/troels"  "functions" ;"settings" "visual"
                                        ;"keybindings"
             ))
  (load (concat emacs-root e)))

;; load everything under these two directories
(mapc
 (lambda (dir)
   (dolist (word (files-in-below-directory (dotdir+ dir)))
     (load word)))
 '("mode_configs" "autoloads"))

(require 'no-easy-keys)
(no-easy-keys 1)

;;; 1 Emacs a bitch to close (C-x C-c is sooo easy to hit):
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Last chance, your work would be lost. ")))
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Are you ABSOLUTELY certain that Emacs should close? ")))
(add-to-list 'kill-emacs-query-functions
             (lambda () (y-or-n-p "Should Emacs really close? ")))

;; change default indent level
(setq c-default-style "bsd" c-basic-offset 4)

;;default shell mode
(setq shell-file-name (getenv "SHELL"))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(put 'upcase-region 'disabled nil)

;; ignore byte-compile warnings
(setq byte-compile-warnings '(not nresolved free-vars callargs redefine
                                  obsolete noruntime cl-functions
                                  interactive-only))

;; compile everything below EMACS-ROOT
(byte-recompile-directory (file-name-directory emacs-root))

(display-time)

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
			       (interactive)
			       (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
			       (interactive)
			       (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))
