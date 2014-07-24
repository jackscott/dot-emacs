(require 'namespaces)
(namespace clj
	   :import [funcs]
	   :packages [starter-kit-lisp cider clojure-mode bug-reference-github
                                       midje-mode midje-test-mode])

;; (require 'starter-kit-lisp)
;; (require 'cider)
;; (require 'clojure-mode)
(require 'midje-mode)
(require 'clojure-jump-to-file)
(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'bug-reference-github-set-url-format)


(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)

(setq cider-repl-tab-command 'indent-for-tab-command)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-show-error-buffer 'only-in-repl)
(setq nrepl-buffer-name-separator "-")
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")
(setq cider-repl-wrap-history t)
(setq cider-repl-history-size 1000)
;(setq cider-repl-history-file "/home/jscott/.cider-repl.clj")y
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; make a keybinding for this
;;(use 'midje.repl) (autotest)

