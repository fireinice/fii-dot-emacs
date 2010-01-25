;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: python-conf.el
;; Author: Zhiqiang.Zhang
;; Description: 
;; Created: 二  4月 28 15:23:18 2009 (CST)
;;           By: Zhiqiang.Zhang
;; Last-Updated: 二  4月 28 15:53:55 2009 (CST)
;;     Update #: 10
;; 
;; 
;;; Change log:
;;
(require 'python-mode)
(require 'python)
(require 'auto-complete)
(require 'ipython)
(require 'smart-snippets-conf)
(require 'auto-complete-config)
(require 'ac-conf)
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)

(defun setup-python-mode ()
  (setq py-python-command-args '( "-colors" "Linux"))
  (set (make-local-variable 'indent-tabs-mode) 'nil)
  (set (make-local-variable 'tab-width) 4)
  (auto-complete-mode 1)
  (hs-minor-mode 1)
  (abbrev-mode t)
  ;; (flymake-mode 1)
  ;; (which-function-mode t)
  ;; (py-shell 1)
  (set (make-variable-buffer-local 'beginning-of-defun-function)
       'py-beginning-of-def-or-class)
  (setq outline-regexp "def\\|class ")
  (ac-mode-setup)
  (set (make-local-variable 'ac-sources)
       (append ac-sources
	       '(ac-source-yasnippet)
	       '(ac-source-ropemacs)))
;; (require 'pylookup)
  ;; (setq pylookup-dir "/home/zigler/.emacs.d/pylookup")
;; set executable file and db file
  ;; (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
  ;; (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
  ;; (print 'pylookup-db-file)
  )


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


(provide 'python-conf)