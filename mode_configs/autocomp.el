;;; autocomp --- Configurations for auto completions and snippets
;;
;; Author: Jack Scott <jscott@nine78.com>
;; Copyright © 2017, Jack Scott, all rights reserved.
;; Created: 19 January 2017
;;
;;; Commentary:
;;
;;
;;
;;; Code:
(eval-when-compile (require 'cl))
(require 'namespaces)

(namespace autocomp
  :use [cl]
  :import []
  :export []
  :packages [yasnippet
             anzu
             helm-ag
             ;;swiper
             ;;swiper-helm
             ])

(require 'anzu)
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; setup auto-complete
(setq-default ac-sources (add-to-list 'ac-sources
                                      'ac-source-dictionary
                                      'ac-source-yasnippet))

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories (funcs/emacs-dir "ac-dict"))
(global-auto-complete-mode t)

(setq ac-auto-start 3
      ac-ignore-case 'smart
      yas-snippet-revival nil)

;; Yasnippets

(setq yas-snippet-dirs
      (list (funcs/dot-dir "snippets")
            (funcs/emacs-dir "snippets")))
(require 'yasnippet)
(yas-global-mode 1)
(yas-reload-all)

;; I like uniquify but not vanilla
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

;;; autocomp.el ends here
