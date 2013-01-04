;;; cpp-conf.el 
(eval-when-compile
  (require 'cl)
  (require 'cc-defs)
  (require 'cc-mode))

(require 'xcscope)
(require 'doxymacs)
(require 'cedet-conf)
(require 'cpp-projects)
(require 'semantic-gcc)
(require 'semantic-ia)

;; this package would find the load-path of the system automatically through gcc
(require 'smart-snippets-conf)
(require 'flymake-conf)
(setq eassist-header-switches '(("h" . ("cpp" "cc" "c"))
				("hpp" . ("cpp" "cc"))
				("cpp" . ("h" "hpp" "hh"))
				("c" . ("h"))
				("C" . ("H"))
				("H" . ("C" "CPP" "CC"))
				("cc" . ("h" "hpp" "hh"))
				("hh" . ("cc" "cpp"))))
;; (define-key c-mode-base-map [(f7)] 'compile)
(defconst baidu-c-style
  `("k&r"
    (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
    (c-basic-offset . 4)
    (tab-width . 4)
    (fill-column . 100)
    (indent-tabs-mode . nil)
    (buffer-file-coding-system . gb18030)
    ;; (c-offsets-alist . ((arglist-cont-nonempty . +)))
    (c-hanging-colons-alist . ((member-init-intro before)))
    (c-hanging-braces-alist . ((substatement-open after)
			       (namespace-open after)
			       (class-open after)
			       (class-close before)))
    )
  "Baidu C/C++ Programming Style")
(defun setup-c-base-mode ()
  (semantic-key-bindings)
  (c-toggle-auto-newline t)
  (c-toggle-auto-hungry-state t)
  (c-add-style "baidu" baidu-c-style t)
  (setq gdb-many-windows t)
  (which-function-mode t)
  (hs-minor-mode t)
  (abbrev-mode t)
  (doxymacs-mode)
  (doxymacs-font-lock)
  ;; ac-omni-completion-sources is made buffer local so
  ;; you need to add it to a mode hook to activate on 
  ;; whatever buffer you want to use it with.  This
  ;; example uses C mode (as you probably surmised).

  ;; auto-complete.el expects ac-omni-completion-sources to be
  ;; a list of cons cells where each cell's car is a regex
  ;; that describes the syntactical bits you want AutoComplete
  ;; to be aware of. The cdr of each cell is the source that will
  ;; supply the completion data.  The following tells autocomplete
  ;; to begin completion when you type in a . or a ->
  (add-to-list 'ac-omni-completion-sources
	       (cons "\\." '(ac-source-semantic)))
  (add-to-list 'ac-omni-completion-sources
	       (cons "->" '(ac-source-semantic)))
  (set (make-local-variable 'ac-sources)
       (append '(ac-source-semantic)
	       ac-sources))
  (make-local-variable 'ac-ignores)
  ;; do not ac by comment
  (add-to-list 'ac-ignores "//")
  (common-smart-snippets-setup c++-mode-map c++-mode-abbrev-table))

;; (eval-after-load "semantic-c" 
;;   '(dolist (d (list "/usr/include/c++/4.3"
;; 		    "/usr/include/c++/4.3/i486-linux-gnu"
;; 		    "/usr/include/c++/4.3/backward"
;; 		    "/usr/local/include"
;; 		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include"
;; 		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed"
;; 		    "/usr/include"))
;;      (semantic-add-system-include d)))

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

(provide 'cpp-conf)
