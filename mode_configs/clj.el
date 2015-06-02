(require 'namespaces)
(require 'cider)
(namespace clj
	   :import [funcs]
	   :packages [starter-kit-lisp
                      clojure-mode
                      cider
                      better-defaults
                      rainbow-delimiters
                      bug-reference-github
                      clojure-mode-extra-font-locking
                      clj-refactor
                      smartparens
                      ac-cider
                      align-cljlet
                      
                      ac-nrepl
                                        ;midje-mode
                                       ;midje-test-mode
                                       ;clojure-jump-to-file
                      ])
;; ;; Set a bunch of truths 
(funcs/set-list-items '(nrepl-hide-special-buffers
                        cider-prefer-local-resources
                        cider-repl-pop-to-buffer-on-connect
                        cider-repl-wrap-history
                        nrepl-log-messages)
                      t)

(setq nrepl-buffer-name-separator "-")
(setq cider-repl-tab-command 'indent-for-tab-command)
(setq cider-repl-history-file (emacsdir+ "cider-repl.clj"))
;; (setq cider-show-error-buffer 'only-in-repl)

(setq cider-prompt-save-file-on-load nil)
(setq cider-repl-result-prefix ";; => ")

(defun my-clojure-hook ()
  (subword-mode)
  (paredit-mode)
  (smartparens-strict-mode)
  (rainbow-delimiters-mode))

(add-hook 'clojure-mode-hook 'my-clojure-hook)


(eval-after-load 'cider
  '(progn
     (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
     (add-hook 'cider-mode-hook 'ac-cider-setup)
     (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
     (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)))

(defun my-cider-hook ()
  (my-clojure-hook)
  (ac-cider-setup))

(add-hook 'cider-repl-mode-hook 'my-cider-hook)

(eval-after-load "auto-complete"
  '(progn
     (add-to-list 'ac-modes 'cider-mode)
     (add-to-list 'ac-modes 'cider-repl-mode)
     (add-to-list 'ac-modes 'clojure-mode)))
