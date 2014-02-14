(require 'cl)
(defun homedir+ (path)
  "Return absolute path to users home directory based on environment variables"
  (format "%s/%s" (getenv "HOME") path))

(defun emacsdir+ (path)
  "Create an bsolute path to ~/.emacs.d/``path``"
  (format "%s/.emacs.d/%s" (getenv "HOME") path))

(defvar *pidfile* "emacs-server.pid")
(defvar *emacs-load-start* (current-time))
(defvar user-name (getenv "USER"))
(defvar emacs-root (file-name-directory (or load-file-name buffer-file-name)))

;;(defvar emacs-root (file-name-directory (buffer-file-name)))
(defvar autosave-dir (emacsdir+ "auto-save-list"))

(add-to-list 'load-path (emacsdir+ "elpa"))
(add-to-list 'load-path emacs-root)

;; emacs < 24 doesnt have packages functionality, load this in instead
(if (< (string-to-number emacs-version) 24)
  (let  ((f (emacsdir+ "package.el")))
    (if (file-exists-p f)
        (load f)
      '(lambda ()
        "pull the file and load it"
        (url-copy-file "http://bit.ly/pkg-el23" f)
        (load f)))))

(setq package-archives '(;("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(lexical-let ((pkgs '(namespaces auto-complete bash-completion
				 bookmark+ clojure-mode color-theme
				 color-theme-approximate color-theme-dawn-night
				 color-theme-solarized color-theme-tango
				 concurrent ctable dash deferred epc
				 find-things-fast flymake-easy flymake-jslint
				 flymake-python-pyflakes groovy-mode
				 highlight-parentheses icicles json-mode
				 logito lua-mode magit markdown-mode mmm-mode
				 paredit pcache php+-mode php-mode popup
				 psgml pyflakes pylint python-pep8
				 python-pylint s slime virtualenvwrapper
				 tangotango-theme
                                 naquadah-theme
                                 gist
				 nrepl clojure-test-mode
                                 ein
                                 jedi nose elpy)))
  ;;(package-refresh-contents)
  (cl-dolist (p pkgs)
    (if (not (package-installed-p p))
	(package-install p))))


(dolist (e '("functions" "visual" "keybindings"))
  (load e))

;; autoload all files in the mode_configs directory
(dolist (word (files-in-below-directory (concat emacs-root "mode_configs")))
  (load word))

;; not everyone likes to be told what to do
;; (require 'no-easy-keys)
;; (no-easy-keys 1)

(setq-default abbrev-mode t)
(setq abbrev-file-name (emacsdir+ "abbrev_defs.txt"))
(define-abbrev-table 'global-abbrev-table
  '(("afaict" "as far as I can tell" nil 1)
    ("omuse" "http://www.emacswiki.org/cgi-bin/oddmuse.pl" nil 0)
    ("btw" "by the way" nil 3)
    ("wether" "whether" nil 5)
    ("ewiki" "http://www.emacswiki.org/cgi-bin/wiki.pl" nil 3)
    ("pov" "point of view" nil 1)
    ))

;;; Make Emacs a bitch to close (C-x C-c is sooo easy to hit):
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


(byte-recompile-directory (file-name-directory emacs-root))


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

;; this setup looks decent on macs
(set-face-attribute 'default nil
		    :family "Inconsolata" :height 115 :weight 'normal)
