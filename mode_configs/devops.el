;;; devops.el --- Packages like Saltstack and Terraform are configured here  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Jack Scott

;; Author: Jack Scott <jack@nine78.com>
;; Keywords: files, convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(provide 'devops)
(require 'namespaces)
(namespace devops
  :import [funcs my-py]
  :packages [
             yaml-mode
             ;salt-mode
             terraform-mode])


(require 'yaml-mode)
(setq yaml-indent-offset 2)

;; (require 'salt-mode)
;; (setq salt-mode-indent-level 2)

(require 'terraform-mode)

(add-to-list 'auto-mode-alist
             '("\\.sls\\'\\|pillar\\.example\\'\\|\\.jinja\\'" . yaml-mode))


(add-to-list 'auto-mode-alist
             '("\\.tfvars\\'\\|\\.tf\\'\\|\\.tfstate" . terraform-mode))


;;; devops.el ends here
