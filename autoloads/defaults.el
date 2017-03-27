(eval-when-compile (require'cl))
(require 'namespaces)

(namespace defaults
  :use [cl]
  :import [funcs]
  :packages [])


;; activate a bunch of modes and things
(setq global-company-mode 1
      projectile-global-mode 1
      yas-global-mode 1
      ido-mode 1
      window-numbering-mode 1
      winner-mode 1
      global-auto-revert-mode 1)

(display-time)
(if (display-graphic-p)
    (set-fringe-mode '(5 . 0)))


;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
			       (interactive)
			       (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
			       (interactive)
			       (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

;; change default indent level
(setq c-default-style "bsd" c-basic-offset 4)

;;default shell mode
(setq shell-file-name (getenv "SHELL"))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(put 'upcase-region 'disabled nil)
