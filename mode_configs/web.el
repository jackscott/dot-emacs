;; (require 'ham-mode)
;; (add-to-list 'auto-mode-alist '(".*email.*\\.html?\\'" . ham-mode))


;; javascript
(when (require 'javascript-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode)))

;; CSS-Mode
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)
