(require 'namespaces)
(namespace clj
	   :import [funcs]
	   :packages [starter-kit-lisp cider clojure-mode
                                       bug-reference-github
                                       midje-mode
                                       ;midje-test-mode
                                       ;clojure-jump-to-file
                                       ])

;; (require 'starter-kit-lisp)
;; (require 'cider)
;; (require 'clojure-mode)
(require 'midje-mode)
;; (require 'clojure-jump-to-file)
(add-hook 'clojure-mode-hook 'midje-mode)

;; docs are good
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; log output to *nrepl-messages*
(setq nrepl-log-message t)

;; should hide the *nrepl-server* and *nrepl-connection* buffers
(setq nrepl-hide-special-buffers t)

(setq cider-prefer-local-resources t)
(setq cider-repl-tab-command 'indent-for-tab-command)

;; open up the new buffer once the connection is established
(setq cider-repl-pop-to-buffer-on-connect t)

(setq cider-show-error-buffer 'only-in-repl)
(setq nrepl-buffer-name-separator "-")
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 10000)
(setq cider-repl-history-file (emacsdir+ "cider-repl.clj"))

(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)


;; make a keybinding for this
;(use 'midje.repl) (autotest)

