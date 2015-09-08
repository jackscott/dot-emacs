(namespace ruby
  :packages [
           yard-mode ;; fontification in ruby comments
           goto-gem ;; Open dired in a gem directory
           ruby-mode
           inf-ruby
           ruby-tools
           ruby-block
           ruby-additional
           ruby-hash-syntax
           ruby-refactor
           web-mode
           rvm
           feature-mode
           rspec-mode
           projectile
           ruby-refactor])

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Files with the following extensions should open in ruby-mode
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))


;; When folding, take these delimiters into consideration
(add-to-list 'hs-special-modes-alist
             '(ruby-mode
               "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
               (lambda (arg) (ruby-end-of-block)) nil))

;; RVM support
(rvm-use-default)

;; Cucumber
;; (require 'feature-mode)
(setq feature-use-rvm t) ;; Tell cucumber to use RVM
(setq feature-cucumber-command "cucumber {options} {feature}")

;; .feature files should open in feature-mode
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; I want rspec instead of rake spec
(setq rspec-use-rake-when-possible nil)
;; Scroll to the first test failure
(setq compilation-scroll-output 'first-error)

;; Projectile mode
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)

;; Prevent emacs from adding the encoding line at the top of the file
(setq ruby-insert-encoding-magic-comment nil)

;; Switch the compilation buffer mode with C-x C-q (useful
;; when interacting with a debugger)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(add-hook 'ruby-mode-hook
          (lambda ()
            (hs-minor-mode 1) ;; Enables folding
            (projectile-rails-on)
            (ruby-refactor-mode-launch)
            (yard-mode)
            (eldoc-mode)
            (modify-syntax-entry ?: "."))) ;; Adds ":" to the word definition

;; ;; Start projectile-rails
;; (add-hook 'projectile-mode-hook 'projectile-rails-on)
