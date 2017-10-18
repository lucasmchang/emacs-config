
;;;choose modes
(delete-selection-mode 1)
(setq inhibit-startup-message t) 
(setq ring-bell-function 'ignore)

;;;install ess
(add-to-list 'load-path "/Users/lmc265/.emacs.d/ESS/lisp")
(load "ess-site")

;; Set default R version, (i.e. the one launched by typing M-x R <RET>)
(setq inferior-R-program-name "/usr/bin/R")
(setq ess-history-file nil)

;;; autosave files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;my functions

(fset 'term-option-b
    [?\M-b])
    
(fset 'term-control-f
    [?\C-f])

(fset 'term-control-b
    [?\C-b])

(fset 'term-move-beginning-of-line
    [?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s 
    ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s ?\C-s])

(defun term-paste-and-leave-selection ()
    (interactive)
    (term-paste)
    (my-keys-term-mode 1)
    (selection-term-mode 0)
    (term-send-end))
    
(defun term-kill-region-and-leave-selection ()
    (interactive)
    (kill-region)
    (my-keys-term-mode 1)
    (selection-term-mode 0)
    (term-send-end))
      
(defun term-copy-and-leave-selection ()
    (interactive)
    (ns-copy-including-secondary)
    (my-keys-term-mode 1)
    (selection-term-mode 0)
    (term-send-end))    

(defun term-toggle-selection-mode ()
    (interactive)
    (if (bound-and-true-p my-keys-term-mode)
	(my-keys-term-mode 0)
	(my-keys-term-mode 1))
    (if (bound-and-true-p selection-term-mode)
	(selection-term-mode 0)
	(selection-term-mode 1))		
    (if (bound-and-true-p selection-term-mode)
	(set-mark-command nil))		
    (if (bound-and-true-p my-keys-term-mode)
	(term-send-end))
    )

(fset 'carbon-copy
    [?  ?\C-e ?\C-  ?\C-s ?\C-c ?\C-d ?\C-v ?\M-p]
)
(defun sudo-edit (&optional arg)
    "Edit currently visited file as root.
    With a prefix ARG prompt for a file to visit.
    Will also prompt for a file to visit if current
    buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun my-startup-layout ()
    (interactive)
    (delete-other-windows)
    (set-frame-size (selected-frame) 251 80)
    (split-window-horizontally) ;; -> |
    (split-window-horizontally) ;; -> |
    (balance-windows)
    (split-window-vertically)
    (windmove-down)
    (term "/bin/bash")
    (windmove-up)
    (switch-to-buffer "Untitled0")
    (windmove-right)
    (switch-to-buffer "Untitled1")
    (windmove-right)
    (switch-to-buffer "Untitled2")
    (windmove-left) (windmove-left)
    (setq inhibit-splash-screen t)  
)

(fset 'ipython-paste
   [?% ?p ?a ?s ?t ?e return])
   
(fset 'ipython [?i ?p ?y ?t ?h ?o ?n return ?\C-c ?\M-x ?i ?p ?y ?t ?h ?o
    ?n ?- ?m ?o ?d ?e return])

(defun kill-whole-line ()
    "Kill the whole line"
    (interactive)
    (save-excursion
	(move-beginning-of-line nil)
	(kill-line)
	(kill-line)))
	
(defun run-code-on-buffer-right ()
    "Run the current line or the current selection in the buffer to the right"
    (interactive)
    (save-excursion
    (if (use-region-p)
	(ns-copy-including-secondary)
	(progn
	    (move-beginning-of-line nil)
	    (set-mark-command nil)
	    (move-end-of-line nil)
	    (ns-copy-including-secondary)
	))
    (windmove-right)
    (if (bound-and-true-p ipython-mode)
	(execute-kbd-macro 'ipython-paste)
	(yank))
    (newline-and-indent-same-level)
    (windmove-left)))

(defun run-code-on-buffer-down ()
    "Run the current line or the current selection in the buffer below"
    (interactive)
    (save-excursion
    (if (use-region-p)
	(ns-copy-including-secondary)
	(progn
	    (move-beginning-of-line nil)
	    (set-mark-command nil)
	    (move-end-of-line nil)
	    (ns-copy-including-secondary)
	))
    (windmove-down)
    (if (bound-and-true-p ipython-mode)
	(execute-kbd-macro 'ipython-paste)
	(yank))
    (newline-and-indent-same-level)
    (windmove-up)))

(defun ipython ()
    "Start ipython in a terminal window"
    (interactive)
    ;type ipython
    (insert-char 105) (insert-char 112) (insert-char 121) (insert-char 116)
    (insert-char 104) (insert-char 111) (insert-char 110)
    (term-send-input)
    (ipython-mode 1))
    

(defun newline-and-indent-same-level ()
    "Insert a newline, then indent to the same column as the current line."
    "When in terminal mode, instead submit the prompt"
    (interactive)
    (if (equal major-mode 'term-mode) (term-send-input)
    (let ((col (save-excursion
         (back-to-indentation)
         (current-column))))
    (insert-char 10) (insert-char 10)
    (delete-indentation)
    (indent-to-column col))))
		
(defun current-line-empty-p ()
    "Return true if current line is all whitespace"
    (save-excursion
	(beginning-of-line)
	(looking-at "[[:space:]]*$")))
	
(defun newline-no-indent ()
    "Insert a newline, no indenting"
    (interactive)
    (insert-char 10) (insert-char 10)
    (delete-indentation))
	    
(defun shift-text (distance)
    "Shift the selected text or the current line if no text is selected
    by a number of spaces"
    (if (use-region-p)
	(let ((mark (mark)))
    (save-excursion
          (indent-rigidly (region-beginning)
	      (region-end)
	       distance)
          (push-mark mark t t)
          (setq deactivate-mark nil)))
    (save-excursion
	(move-end-of-line nil)
	(unless (use-region-p)(insert-char 67))
	(indent-rigidly (line-beginning-position)
	    (line-end-position)
	    distance)
        (unless (use-region-p)(delete-backward-char 1))))
    (if (current-line-empty-p) (move-end-of-line nil))
	)
		
(defun shift-right (count)
    (interactive "p")
    (shift-text count))

(defun shift-left (count)
    (interactive "p")
    (shift-text (- count)))
  
(defun indent-right ()
    (interactive)
    (shift-text 4))

(defun indent-left ()
    (interactive)
    (shift-text -4))
    
(defun literal-tab ()
    "Insert a tab character, no magic"
    (interactive)
    (insert-char 9))

(fset 'scroll-down-10
   [?\C-u ?1 ?0 ?\M-x ?s ?c ?r ?o ?l ?l ?- ?u ?p ?-
   ?c ?o ?m ?m ?a ?n ?d return])

(fset 'scroll-up-10
   [?\C-u ?1 ?0 ?\M-x ?s ?c ?r ?o ?l ?l ?- ?d ?o ?w ?n ?-
   ?c ?o ?m ?m ?a ?n ?d return])


;;;Define my key bindings
(defvar my-keys-minor-mode-map
    (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-w") 'move-beginning-of-line)
	(define-key map (kbd "C-r") 'move-end-of-line)
	(define-key map (kbd "C-s") 'backward-char)
	(define-key map (kbd "C-e") 'previous-line)
	(define-key map (kbd "C-d") 'next-line)
	(define-key map (kbd "C-f") 'forward-char)
	(define-key map (kbd "C-t") 'isearch-backward)
	(define-key map (kbd "C-a") 'mark-whole-buffer)
	(define-key map (kbd "C-z") 'undo)
	(define-key map (kbd "C-b") 'suspend-frame)
	(define-key map (kbd "C-n") 'quoted-insert)
	(define-key map (kbd "C-p") 'delete-forward-char)
	(define-key map (kbd "M-DEL") 'kill-word)
	(define-key map (kbd "M-d") 'backward-word)
	(define-key map (kbd "C-$") 'execute-extended-command)
	(define-key map (kbd "C-<right>") 'windmove-right)
	(define-key map (kbd "C-<left>") 'windmove-left)
	(define-key map (kbd "C-<up>") 'windmove-up)
	(define-key map (kbd "C-<down>") 'windmove-down)
	(define-key map (kbd "RET") 'newline-and-indent-same-level)
	(define-key map (kbd "M-RET") 'newline-no-indent)
	(define-key map (kbd "TAB") 'indent-right)
	(define-key map (kbd "M-TAB") 'indent-left)
	(define-key map (kbd "C-3") 'scroll-up-10)
	(define-key map (kbd "C-4") 'scroll-down-10)
	(define-key map (kbd "M-4") 'scroll-up-command)
	(define-key map (kbd "M-3") 'scroll-down-command)
	(define-key map (kbd "C-5") 'run-code-on-buffer-down)
	(define-key map (kbd "M-5") 'run-code-on-buffer-right)
	(define-key map (kbd "C-q") 'top-level)
	(define-key map (kbd "M-q") 'keyboard-quit)	
	(define-key map (kbd "C-2 C-q") 'top-level)
	(define-key map (kbd "C-2 M-q") 'keyboard-quit)
	(define-key map (kbd "C-y") 'isearch-forward)
	(define-key map (kbd "C-v") 'yank)
	(define-key map (kbd "C-k") 'kill-line)
	(define-key map (kbd "C-x") 'kill-region)
	(define-key map (kbd "M-y") 'query-replace)
	(define-key map (kbd "C-c") 'ns-copy-including-secondary)
	(define-key map (kbd "C-2") 'Control-X-prefix)
	(define-key map (kbd "C-M-v") 'carbon-copy)
	map)
    "my-keys-minor-mode keymap.")

(defvar ipython-mode-map
    (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-1 C-v") 'ipython-paste)
	(define-key map (kbd "s-v") 'ipython-paste)
	map)
    "ipython-mode keymap.")
    
(define-key isearch-mode-map "\C-q" 'keyboard-quit)
(define-key isearch-mode-map "\C-y" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-t" 'isearch-repeat-backward)
    
(defvar my-keys-minibuffer-mode-map
    (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-q") 'top-level)
	(define-key map (kbd "M-q") 'keyboard-quit)
	(define-key map (kbd "C-y") 'isearch-forward)
	(define-key map (kbd "C-t") 'isearch-backward)
	map)
    "my-keys-minibuffer-mode keymap.")

(defvar my-keys-term-mode-map
    (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-p") 'delete-forward-char)
	(define-key map (kbd "M-x") 'execute-extended-command)
	(define-key map (kbd "C-2") 'Control-X-prefix)
	(define-key map (kbd "C-t") 'isearch-backward)
	(define-key map (kbd "C-e") 'term-send-up)
	(define-key map (kbd "C-d") 'term-send-down)
	(define-key map (kbd "C-f") 'term-control-f)
	(define-key map (kbd "C-s") 'term-control-b)
	(define-key map (kbd "C-<right>") 'windmove-right)
	(define-key map (kbd "C-<left>") 'windmove-left)
	(define-key map (kbd "C-<up>") 'windmove-up)
	(define-key map (kbd "C-<down>") 'windmove-down)
	(define-key map (kbd "C-c") 'ns-copy-including-secondary)
	(define-key map (kbd "C-v") 'term-paste)
	(define-key map (kbd "C-r") 'term-send-end)
	(define-key map (kbd "C-w") 'term-move-beginning-of-line)
	(define-key map (kbd "M-d") 'term-option-b) ;backward-word
	(define-key map (kbd "C-SPC") 'term-toggle-selection-mode)
	map)
    "my-keys-term-mode keymap.")
    
(defvar selection-term-mode-map
    (let ((map (make-sparse-keymap)))
    	(define-key map (kbd "C-p") 'delete-forward-char)
	(define-key map (kbd "M-x") 'execute-extended-command)
	(define-key map (kbd "C-2") 'Control-X-prefix)
	(define-key map (kbd "C-t") 'isearch-backward)
	(define-key map (kbd "C-s") 'backward-char)
	(define-key map (kbd "C-e") 'previous-line)
	(define-key map (kbd "C-d") 'next-line)
	(define-key map (kbd "C-f") 'forward-char)
	(define-key map (kbd "C-<right>") 'windmove-right)
	(define-key map (kbd "C-<left>") 'windmove-left)
	(define-key map (kbd "C-<up>") 'windmove-up)
	(define-key map (kbd "C-<down>") 'windmove-down)
	(define-key map (kbd "C-v") 'term-paste-and-leave-selection)
	(define-key map (kbd "C-c") 'term-copy-and-leave-selection)
	(define-key map (kbd "C-x") 'term-kill-region-and-leave-selection)
	(define-key map (kbd "C-r") 'move-end-of-line)
	(define-key map (kbd "C-w") 'move-beginning-of-line)
	(define-key map (kbd "M-d") 'backward-word)
	(define-key map (kbd "M-f") 'forward-word)
	(define-key map (kbd "C-SPC") 'term-toggle-selection-mode)
	map)
    "selection-term-mode keymap.")    

(define-minor-mode my-keys-term-mode
    :init-value nil
    :lighter " mykeys_term")

(define-minor-mode selection-term-mode
    :init-value nil
    :lighter " selection_term")

;;;###autoload
(define-minor-mode my-keys-minor-mode
    "A minor mode so that my key settings override annoying major modes."
    :init-value t
    :lighter " mykeys" 
    
;; 区别C-i与TAB http://stackoverflow.com/questions/1792326/how-do-i-bind-a-command-to-c-i-without-changing-tab
(setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map)))

(defun my-keys-have-priority (_file)
    "Try to ensure that specific minor modes have priority over my-keys
    and that my keybindings retain priority over other minor modes.
    Called via the `after-load-functions' special hook."
    (unless (eq (caar minor-mode-map-alist) 'my-keys-minor-mode)
    (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
	(assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
	(add-to-list 'minor-mode-map-alist mykeys))))

;; Turn off the minor mode in the minibuffer
(defun minibuffer-keys-on ()
    "Turn off my--keys-minor-mode"
    (my-keys-minor-mode -1)
    (my-keys-minibuffer-mode 1))
    
(defun minibuffer-keys-off ()
    "Turn on my--keys-minor-mode"
    (my-keys-minor-mode 1)
    (my-keys-minibuffer-mode -1))
    
(add-hook 'minibuffer-setup-hook 'minibuffer-keys-on)
(add-hook 'minibuffer-exit-hook 'minibuffer-keys-off)

;; Turn on custom keys in term mode
(defun term-keys-on ()
    "Turn on custom keys in term mode"
    (my-keys-term-mode 1)
    (my-keys-minor-mode -1))
    
(add-hook 'term-mode-hook 'term-keys-on)

;;;ipython mode (useful for special paste behavior)

(define-minor-mode my-keys-minibuffer-mode
    nil
    " minimykeys")

(define-minor-mode ipython-mode
     "Toggle ipython mode.
     Interactively with no argument, this command toggles the mode.
     A positive prefix argument enables the mode, any other prefix
     argument disables it.  From Lisp, argument omitted or nil enables
     the mode, `toggle' toggles the state.
     
     When ipython  mode is enabled, command-V types %paste RET instead of yank."
     ;; The initial value.
     nil
     ;; The indicator for the mode line.
     " ipython")

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;;;theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
;;;apply functions that depend on other definitions 
(my-startup-layout)
