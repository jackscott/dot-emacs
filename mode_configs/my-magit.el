;;; MY-MAGIT --- magit related configurations
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

(require 'namespaces)
(namespace magit
  :import []
  :packages [magit
             fullframe])

;; Magit stuff
(setq magit-auto-revert-mode nil
      magit-last-seen-setup-instructions "1.4.0"
      magit-push-current-set-remote-if-missing t)

(setq magit-push-always-verify nil)
;; disable the popup window when committing.
;; https://github.com/magit/magit/issues/1979
(remove-hook 'server-switch-hook 'magit-commit-diff)

(require 'fullframe)
(fullframe magit-status magit-mode-quit-window nil)

;;; my-magit.el ends here
