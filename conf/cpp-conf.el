(provide 'cpp-conf)
(require 'eassist)
(require 'doxymacs)
(require 'xcscope)
(require 'cedet-conf)
;; this package would find the load-path of the system automatically through gcc
(require 'semantic-gcc)
(require 'smart-snippets-conf)

(common-smart-snippets-setup c++-mode-map c++-mode-abbrev-table)
(common-smart-snippets-setup c-mode-map c-mode-abbrev-table)

(add-hook 'font-lock-mode-hook
	  (lambda()
	    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
		(doxymacs-font-lock))))
(local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)
(doxymacs-mode 1)

;; (autoload 'senator-try-expand-semantic "senator")
(c-set-style "stroustrup")
(c-set-offset 'substatement-open 0)
(setq tab-width 4 indent-tabs-mode t)
(setq gdb-many-windows t)
;; hungry-delete and auto-newline
(c-toggle-auto-hungry-state 1)
(which-function-mode t)
(hs-minor-mode 1)
(abbrev-mode t)
(define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
(define-key c-mode-base-map [(f7)] 'compile)
(define-key c-mode-base-map [(meta \`)] 'c-indent-command)
(define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
(define-key c-mode-base-map (kbd "M-o") 'eassist-switch-h-cpp)
(define-key c-mode-base-map (kbd "M-m") 'eassist-list-methods)
(define-key c-mode-base-map (kbd "\C-cp") 'semantic-analyze-proto-impl-toggle)
(define-key c-mode-base-map (kbd ".") 'semantic-complete-self-insert)
(define-key c-mode-base-map (kbd ">") 'semantic-complete-self-insert) 

;;预处理设置
(setq c-macro-shrink-window-flag t)
(setq c-macro-preprocessor "cpp")
(setq c-macro-cppflags " ")
(setq c-macro-prompt-flag t)

;; (add-hook 'c++-mode-hook
          ;; (c-subword-mode 1)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
;; )
;; C/C++语言启动时自动加载semantic对/usr/include的索引数据库
;; (setq semanticdb-search-system-databases t)
;;   (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (setq semanticdb-project-system-databases
;;                   (list (semanticdb-create-database
;;                            semanticdb-new-database-class
;;                            "/usr/include")))))
;; ;; project root path
;; (setq semanticdb-project-roots
;;           (list
;;         (expand-file-name "/")))

(make-hippie-expand-function
      '(
	yas/hippie-try-expand
;; 	senator-try-expand-semantic
	try-complete-abbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-list
	try-expand-list-all-buffers
	try-expand-whole-kill))

;;    (font-lock-add-keywords 'c-mode
;;     '(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
;;       ("\\<\\(and\\|or\\|not\\)\\>" . font-lock-keyword-face)))

;; (eval-after-load "semantic-c" 
;;   '(dolist (d (list "/usr/include/c++/4.3"
;; 		    "/usr/include/c++/4.3/i486-linux-gnu"
;; 		    "/usr/include/c++/4.3/backward"
;; 		    "/usr/local/include"
;; 		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include"
;; 		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed"
;; 		    "/usr/include"))
;;      (semantic-add-system-include d)))
