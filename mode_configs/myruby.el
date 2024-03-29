(namespace ruby
  :packages [
           yard-mode ;; fontification in ruby comments
           ;;goto-gem ;; Open dired in a gem directory
           ruby-mode
           inf-ruby
           ruby-tools
           ;;ruby-block
           ruby-hash-syntax
           web-mode
           rvm
           feature-mode
           bundler
           rspec-mode
           projectile
           rbenv
           groovy-mode])

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Files with the following extensions should open in ruby-mode

(add-to-list 'auto-mode-alist
             '("\\.rb\\'\\|.rake\\'\\|\\.gemspec\\'\\|\\.ru" . ruby-mode))

;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Jenkinsfile$" . groovy-mode))
;; When folding, take these delimiters into consideration
(add-to-list 'hs-special-modes-alist
             '(ruby-mode
               "\\(class\\|def\\|do\\|if\\)" "\\(end\\)" "#"
               (lambda (arg) (ruby-end-of-block)) nil))

;; RVM support
(rvm-use-default)

;;(add-to-list 'load-path (expand-file-name "/")
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

(defun my-hook ()
  (ruby-indent-tabs-mode nil))

(add-hook 'ruby-mode-hook 'my-hook)

;; ;; Start projectile-rails
;; (add-hook 'projectile-mode-hook 'projectile-rails-on)
