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
  (require 'python))

(require 'flymake-conf)
(require 'python-mode)
(require 'auto-complete)
;; (require 'ipython)
(require 'smart-snippets-conf)
(require 'auto-complete-config)
(require 'w3m-conf)
(require 'flymake-python-pyflakes)
;; (require 'pymacs)

(message "pabc")
(defun setup-python-buffer ()
  (setq py-load-pymacs-p 'nil)
  (set (make-local-variable 'browse-url-browser-function) 'w3m-browse-url)
  (set (make-local-variable 'indent-tabs-mode) 'nil)
  (set (make-local-variable 'tab-width) 4)
  (jedi:setup)
  (flymake-python-pyflakes-load)
  (flymake-mode 1)
  (hs-minor-mode 1)
  (abbrev-mode t)
  (auto-complete-mode 1)
  (set (make-local-variable 'ac-sources)
       (append '(ac-source-yasnippet)
	       ac-sources)))

(defun setup-python-mode ()
  (message "setup python mode")
  (try-require 'python-pylint)
  ;; pylookup setup
  (when (try-require 'pylookup)
    (setq pylookup-dir (file-name-directory (locate-library "pylookup")))
    ;; set executable file and db file
    (setq pylookup-program (concat pylookup-dir "/pylookup.py"))
    (setq pylookup-db-file (concat pylookup-dir "/pylookup.db"))
    ;; (setq flymake-python-pyflakes-extra-arguments '("--ignore=W806"))
    (define-key python-mode-map "\C-c\C-o" 'pylookup-lookup)
    ;; pylookup ends here
    )

  (setq flymake-python-pyflakes-executable "flake8")
  ;; (setq autopair-dont-activate t)
  (setq py-python-command-args '( "-colors" "Linux"))
  (setq python-indent-offset 4)
  
  ;; (py-shell 1)
  (setq jedi:complete-on-dot t)
  (set beginning-of-defun-function
       'py-beginning-of-def-or-class)
  (setq python-pylint-options "--output-format=parseable --include-ids=yes")
  ;; (setq outline-regexp "def\\|class ")
  )

(provide 'python-conf)
