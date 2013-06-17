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
  (require 'python)
  (require 'pylookup))

;; (require 'python-mode)
(require 'auto-complete)
;; (require 'ipython)
(require 'smart-snippets-conf)
(require 'auto-complete-config)
(require 'w3m-conf)
(require 'python-pylint)
(require 'flymake-conf)
(require 'python-mode)
;; (require 'pymacs)

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

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(setq flymake-python-pyflakes-executable "flake8")
;; (setq flymake-python-pyflakes-extra-arguments '("--ignore=W806"))

(ac-ropemacs-initialize)

(defun setup-python-mode ()
  (message "setup python mode")
  (setq autopair-dont-activate t)
  (setq py-load-pymacs-p 'nil)
  (setq py-python-command-args '( "-colors" "Linux"))
  (set (make-local-variable 'indent-tabs-mode) 'nil)
  (set (make-local-variable 'tab-width) 4)
  (setq python-indent 4)
  (auto-complete-mode 1)
  (hs-minor-mode 1)
  (abbrev-mode t)
  (flymake-mode 1)
  (flymake-python-pyflakes-load)
  ;; (which-function-mode t)
  ;; (py-shell 1)
  (set beginning-of-defun-function
       'py-beginning-of-def-or-class)
  (setq outline-regexp "def\\|class ")
  (electric-pair-mode t)
  (set (make-local-variable 'ac-sources)
       (append '(ac-source-yasnippet ac-source-ropemacs)
	       ac-sources)))

(setq python-pylint-options "--output-format=parseable --include-ids=yes")
(provide 'python-conf)
