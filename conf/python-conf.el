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
;; load pylookup when compile time
(eval-when-compile
    ;; (load "../init.el")
  (require 'pylookup))

;; (require 'python-mode)
;; (require 'python)
(require 'auto-complete)
;; (require 'ipython)
(require 'smart-snippets-conf)
(require 'auto-complete-config)
(require 'w3m-conf)

;; pylookup setup
(autoload 'pylookup-lookup "pylookup"
  "Lookup SEARCH-TERM in the Python HTML indexes." t)

(autoload 'pylookup-update "pylookup" 
  "Run pylookup-update and create the database at `pylookup-db-file'." t)
(setq pylookup-dir (file-name-directory (locate-library "pylookup")))
;; set executable file and db file
(setq pylookup-program (concat pylookup-dir "/pylookup.py"))
(setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
(define-key python-mode-map "\C-c\C-o" 'pylookup-lookup)
(set (make-local-variable 'browse-url-browser-function) 'w3m-browse-url)
;; pylookup ends here

(common-smart-snippets-setup python-mode-map python-mode-abbrev-table)



;; (require 'comint)
;; (define-key comint-mode-map [(meta p)]
;;   'comint-previous-matching-input-from-input)
;; (define-key comint-mode-map [(meta n)]
;;   'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [(control meta n)]
;;   'comint-next-input)
;; (define-key comint-mode-map [(control meta p)]
;;   'comint-previous-input)
;; (ac-ropemacs-initialize)

(make-variable-buffer-local 'beginning-of-defun-function)
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
  

  ;; (set beginning-of-defun-function
  ;;      'py-beginning-of-def-or-class)
  (setq outline-regexp "def\\|class ")
  (set (make-local-variable 'ac-sources)
       (append '(ac-source-ropemacs)
	       ac-sources)))

(setq pylint-options "--output-format=parseable --include-ids=yes")

(provide 'python-conf)