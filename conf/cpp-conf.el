(require 'eassist)
(require 'doxymacs)
(autoload 'senator-try-expand-semantic "senator")
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
(c-set-style "stroustrup")
(setq tab-width 2 indent-tabs-mode t)
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
          (c-subword-mode 1))
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
	senator-try-expand-semantic
	try-complete-abbrev
	try-expand-dabbrev-visible
	try-expand-dabbrev
	try-expand-dabbrev-all-buffers
	try-expand-dabbrev-from-kill
	try-expand-list
	try-expand-list-all-buffers
	try-expand-whole-kill))

;; 自动为 C/C++ 的头文件添加 #define 保护。
(define-auto-insert
  '("\\.\\([Hh]\\|hh\\|hxx\\|hpp\\)\\'" . "C / C++ header")
  '((upcase (concat "_"
                    (replace-regexp-in-string
                     "[^a-zA-Z0-9]" "_"
                     (format "%s_" (file-name-nondirectory buffer-file-name)))))
    "#ifndef " str \n
    "#define " str "\n\n"
    _ "\n\n#endif"))



