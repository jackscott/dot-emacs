(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'cl)
  (require 'use-package))

;; (require 'namespaces)

;; (namespace mygo
;;   :use [cl]
;;   :import []
;;   :packages [lsp-mode
;;              lsp-ui])
(setq lsp-keymap-prefix "C-c l")
(use-package lsp-mode
             :commands (lsp lsp-deferred)
             ;; :config
             ;; (lsp-enable-which-key-integration t)
             :hook
             ((go-mode) . lsp))

(use-package lsp-ui
             :hook (lsp=mode . lsp-ui-mode)
             :config
             (setq lsp-ui-doc-enable t))

;; To set the garbage collection threshold to high (100 MB) since LSP client-server communication generates a lot of output/garbage
(setq gc-cons-threshold 100000000)
;; To increase the amount of data Emacs reads from a process
(setq read-process-output-max (* 1024 1024))
