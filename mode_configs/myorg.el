(require 'namespaces)
(namespace org
  :packages [org s org-dropbox org-mac-iCal org-time-budgets])


(add-to-list 'org-modules 'org-timer)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(setq org-list-allow-alphabetical 1)

(defun call-org-statusbar (action &optional task)
  (call-process "/usr/bin/osascript" nil 0 nil "-e"
                (concat "tell application \"org-clock-statusbar\" to clock " action
                        (if (bound-and-true-p task)
                            (concat " \"" task "\"")))))

(if (eq system-type 'darwin)
    (progn
      (add-hook 'org-clock-in-hook
                (lambda () (call-org-statusbar "in" org-clock-current-task)))

      (add-hook 'org-clock-out-hook
                (lambda () (call-org-statusbar "out")))))
    
; (add-hook 'org-clock-in-hook
;;           (lambda () 
;; (add-hook 'org-clock-out-hook
;;           (lambda ()
;;             (call-process "/usr/bin/osascript" nil 0 nil "-e" "tell application \"org-clock-statusbar\" to clock out")))


(global-set-key (kbd "<f12>") 'org-agenda)
;;(global-set-key (kbd "<f5>") 'bh/org-todo)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

(setq org-use-fast-todo-selection t)
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)

;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)
;; 
(setq org-time-clocksum-use-fractional t)

;; format string used when creating CLOCKSUM lines and when generating a
;; time duration (avoid showing days)
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

(setq org-time-stamp-rounding-minutes '(0 15))

(defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
     
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(defun my-org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str "^"))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "---")
              ))
      (concat str "--> "))))

(advice-add 'org-clocktable-indent-string
            :override
            #'my-org-clocktable-indent-string)
