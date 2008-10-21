(require 'eassist)
(require 'doxymacs)
(add-hook 'font-lock-mode-hook
	  (lambda()
	    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
		(doxymacs-font-lock))))

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
;;预处理设置
(setq c-macro-shrink-window-flag t)
(setq c-macro-preprocessor "cpp")
(setq c-macro-cppflags " ")
(setq c-macro-prompt-flag t)

(add-hook 'c++-mode-hook
          (c-subword-mode 1)
	  (c-set-offset 'inline-open 0)
	  (c-set-offset 'friend '-))
;;;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库
;; (setq semanticdb-search-system-databases t)
;;   (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (setq semanticdb-project-system-databases
;;                   (list (semanticdb-create-database
;;                            semanticdb-new-database-class
;;                            "/usr/include")))))
;; project root path
;; (setq semanticdb-project-roots
;;           (list
;;         (expand-file-name "/")))

(make-hippie-expand-function
      '(
	yas/hippie-try-expand
	try-complete-abbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-list
	try-expand-list-all-buffers
	try-expand-whole-kill))

