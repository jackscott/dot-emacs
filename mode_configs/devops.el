(require 'namespaces)
(namespace devops
  :import [funcs my-py]
  :packages [mmm-mode
             yaml-mode
             salt-mode])


(defn my-hook ()
  (python-mode-hook))
  
(defn add-to-mode (mode lst)
  (dolist (file lst)
    (add-to-list 'auto-mode-alist
                 (cons file mode))))

(define-derived-mode saltstack-mode salt-mode "Saltstack"
  "Minimal Saltstack mode, based on `salt-mode'."
  (setq tab-width 2
        indent-tabs-mode nil))

(add-to-list 'auto-mode-alist
             '("\\.sls\\'\\|\\.jinja\\'\\|pillar\\.example\\'" . saltstack-mode))


(add-hook 'salt-mode-hook (~ my-hook))
