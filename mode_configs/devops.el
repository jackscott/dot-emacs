(require 'namespaces)
(namespace devops
  :import [funcs my-py]
  :packages [mmm-mode
             yaml-mode
             terraform-mode])
             
(require 'yaml-mode)
(require 'terraform-mode)

(setq yaml-indent-offset 2)
(add-to-list 'auto-mode-alist
            '("\\.yml\\'\\|.sls\\'\\|pillar\\.example\\'\\|\\.jinja\\'" . yaml-mode))

