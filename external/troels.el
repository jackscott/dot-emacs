
;;; Copyright (C) 2003-2005 Troels Henriksen <athas@sigkill.dk>

;;; These macros campe from 
;;; Troels Henriksen's sample .emacs file
(eval-when-compile (require'cl))

(defun noerr-require (feature)
  "`require' FEATURE, but don't invoke any Lisp errors.
If FEATURE cannot be loaded, this function will print an error
message through `message' and return nil. It otherwise behaves
exactly as `require'."
  (ignore-errors
    (require feature (symbol-name feature) t)))

(defmacro with-feature (feature &rest body)
  "Require FEATURE and execute BODY.
If FEATURE can't be loaded, don't execute BODY."
  (when (noerr-require (car feature))
    (push 'progn body)))

(defmacro with-features (features &rest body)
  "Require FEATURES and execute BODY.
If any of FEATURES cannot be loaded, don't execute BODY."
  (if features
      `(with-feature (,(first features))
         (with-features ,(cdr features)
           ,@body))
    `(progn ,@body)))

(defmacro global-set-keys (&rest keycommands)
  "Register keys to commands.
Analyze KEYCOMMANDS in pairs, and maps the corresponding keys
to the corresponding functions."
  (let ((setkey-list nil))
    (while keycommands
      (let ((key (car keycommands))
            (command (cadr keycommands)))
        (push `(global-set-key (kbd ,key)
                               ,command)
              setkey-list))
      (setq keycommands (cddr keycommands)))
    (push 'progn setkey-list)
    setkey-list))

(defmacro set-keybinding-for-maps (key command &rest keymaps)
  "Register keys to commands in a nuber of keymaps.
Maps KEY to COMMAND in the keymaps listed in KEYMAPS."
  (let ((defkey-list nil))
    (while keymaps
      (let ((current-map (first keymaps)))
        (push `(define-key 
                 ,current-map 
                 (kbd ,key)
                 ,command)
              defkey-list))
      (setq keymaps (rest keymaps)))
    (push 'progn defkey-list)
    defkey-list))

(defmacro define-keys (keymap &rest args)
  `(progn
     ,@(let (defs)
         (while args
           (let ((key (first args))
                 (def (second args)))
             (push `(define-key ,keymap ,key ,def) defs))
           (setf args (cddr args)))
         defs)))
