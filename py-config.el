;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: py-config.el
;; Copyright (c) 2006 Ask Jeeves Technologies. ALL RIGHTS RESERVED.;; 
;; Author: Zhiqiang.Zhang
;; Description: 
;; Created: 二  4月 28 15:23:18 2009 (CST)
;;           By: Zhiqiang.Zhang
;; Last-Updated: 二  4月 28 15:23:43 2009 (CST)
;;     Update #: 1
;; 
;; 
;;; Change log:
;; 

;=========python mode
(require 'pymacs)
;; (require 'pymacs-load)
;; (autoload 'py-complete-init "py-complete")
;; (add-hook 'python-mode-hook 'py-complete-init)
(require 'python-mode)
;; (require 'pycomplete)
(require 'python)
(require 'auto-complete)
(require 'ipython)
(setq py-python-command-args '( "-colors" "Linux"))
;; Initialize Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
;; (require 'python)
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)

(add-hook 'python-mode-hook
	  (lambda ()
	    (auto-complete-mode 1)
	    (setq tab-width 4 indent-tabs-mode nil)
;; 	    (which-function-mode t)
	    (hs-minor-mode 1)
;; 	    (py-shell 1)
	    (abbrev-mode t)
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")
	    (set (make-local-variable 'ac-sources)
		 (append ac-sources '(ac-source-rope)
			 '(ac-source-yasnippet)))
			 ;; ))
	    (set (make-local-variable 'ac-find-function) 'ac-python-find)
	    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
	    (set (make-local-variable 'ac-auto-start) nil)))
 
;; http://www.enigmacurry.com/2009/01/21/autocompleteel-python-code-completion-in-emacs/
;; Initialize Rope                                                                         
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; Auto-completion                                                                                            
;;;  Integrates:                                                                                               
;;;   1) Rope                                                                                                  
;;;   2) Yasnippet                                                                                             
;;;   all with AutoComplete.el                                                                                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))
(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")
(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))
(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))
 
;;Ryan's python specific tab completion                                                                        
(defun ryan-python-tab ()
  ; Try the following:                                                                                         
  ; 1) Do a yasnippet expansion                                                                                
  ; 2) Do a Rope code completion                                                                               
  ; 3) Do an indent                                                                                            
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))
 
(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))
 
(define-key python-mode-map [(tab)] 'ryan-python-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; End Auto Completion                                                                                        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pychecker
;; (defun py-pychecker-run (command)
;;   "*Run pychecker (default on the file currently visited)."
;;   (interactive
;;    (let ((default
;;            (format "%s %s %s" py-pychecker-command
;; 		   (mapconcat 'identity py-pychecker-command-args " ")
;; 		   (buffer-file-name)))
;; 	 (last (when py-pychecker-history
;; 		 (let* ((lastcmd (car py-pychecker-history))
;; 			(cmd (cdr (reverse (split-string lastcmd))))
;; 			(newcmd (reverse (cons (buffer-file-name) cmd))))
;; 		   (mapconcat 'identity newcmd " ")))))

;;      (list
;;       (read-shell-command "Run pychecker like this: "
;;                           (if last
;; 			      last
;; 			    default)
;;                           'py-pychecker-history))))
;;   (save-some-buffers (not py-ask-about-save) nil)
;;   (compile-internal command "No more errors"))

;; (defun my-python-documentation (w)
;;     "Launch PyDOC on the Word at Point"
;;     (interactive
;;      (list (let* ((word (thing-at-point 'word))
;;                                 (input (read-string 
;;                                                 (format "pydoc entry%s: " 
;;                                                                 (if (not word) "" (format " (default %s)" word))))))
;;                    (if (string= input "") 
;;                            (if (not word) (error "No pydoc args given")
;;                                  word) ;sinon word
;;                          input)))) ;sinon input
;;     (shell-command (concat py-python-command " -c \"from pydoc import help;help(\'" w "\')\"") "*PYDOCS*")
;;     (view-buffer-other-window "*PYDOCS*" t 'kill-buffer-and-window))

;; (define-key py-mode-map  [(tab)] 'py-complete)
(provide 'py-config.el)