(require 'namespaces)
(require 'cider)
(namespace clj
	   :import [funcs]
	   :packages [starter-kit-lisp clojure-mode
                                       bug-reference-github
                                       clojure-mode-extra-font-locking
                                       clj-refactor
                                       smartparens
                                       ;midje-mode
                                       ;midje-test-mode
                                       ;clojure-jump-to-file
                                       ])
;; handle CamelCase shit in java
(add-hook 'clojure-mode-hook 'subword-mode)

;(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)

;; docs are good
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; ;; Set a bunch of truths 
(funcs/set-list-items '(nrepl-log-message nrepl-hide-special-buffers
                                          cider-prefer-local-resources
                                          cider-repl-pop-to-buffer-on-connect
                                          cider-repl-wrap-history)
                      t)

(setq cider-repl-tab-command 'indent-for-tab-command)

(setq cider-show-error-buffer 'only-in-repl)
(setq nrepl-buffer-name-separator "-")
(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")

(setq cider-repl-history-file (emacsdir+ "cider-repl.clj"))
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

;; (map '(lambda (x) (add-hook 'cider-repl-mode-hook x))
;;      '(subword-mode
;;        paredit-mode
;;        rainbow-delimiters-mode))

;; ;; (setq '([cider-show-error-buffer only-in-repl]
;; ;;         [nrepl-buffer-name-separator "-"]
;; ;;         [cider-prompt-save-file-on-load nil]
;; ;;         [cider-repl-result-prefix ";; => "]
;; ;;         [cider-repl-history-size 10000]
;; ;;         ))


;; -
