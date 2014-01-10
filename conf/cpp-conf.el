;;; cpp-conf.el 
(eval-when-compile
  (require 'cl)
  (require 'cc-defs)
  (require 'cc-mode))

(try-require 'google-c-style)
(try-require 'doxymacs)
(require 'cedet-conf)
(require 'flymake)
(try-require 'cpp-projects)
;; (require 'auto-complete-clang-async)
;; this package would find the load-path of the system automatically through gcc
;; (require 'smart-snippets-conf)
;; (require 'flymake-conf)
(load-file "~/.emacs.d/ede-projects.el")

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
  (message "set up c base mode")
  (require 'xcscope)
  (require 'cedet-conf)
  (cscope-setup)
  (setq gdb-many-windows t)
  (which-function-mode t)
  (abbrev-mode t)
  )

(defun setup-c-base-buffer ()
  (message "set up c base buffer")
  (google-set-c-style)
  ;; fixme
  ;; (semantic-key-bindings)
  (c-toggle-auto-newline t)
  (c-toggle-auto-hungry-state t)
  ;; (google-set-c-style)
  (google-make-newline-indent)
  (hs-minor-mode t)
  (when (try-require 'doxymacs)
    (doxymacs-mode)
    (doxymacs-font-lock))
  (setq flymake-start-syntax-check-on-find-file t)
  (flymake-mode t)
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

  ;; (local-set-key "." 'semantic-complete-self-insert)
  ;; (local-set-key ">" 'semantic-complete-self-insert)
  (add-to-list 'ac-omni-completion-sources
	       (cons "\\." '(ac-source-semantic)))
  (add-to-list 'ac-omni-completion-sources
	       (cons "->" '(ac-source-semantic)))
  (set (make-local-variable 'ac-sources)
       (append '(ac-source-semantic ac-source-semantic-raw)
	       ac-sources))
  (make-local-variable 'ac-ignores)
  ;; do not ac by comment
  (add-to-list 'ac-ignores "//")
  ;; (common-smart-snippets-setup c++-mode-map c++-mode-abbrev-table)
  (google-set-c-style)
  (define-key c-mode-base-map (kbd "M-o" ) 'ff-find-other-file)
  (setq cc-search-directories '("." "../include" "../src" "/usr/include" "/usr/local/include/*"))
  )

(defun cpplint ()
  "check source code format according to Google Style Guide"
  (interactive)
  (setq cpplint-cmd (concat "python " my-emacs-path "misc/cpplint.py "))
  (compilation-start (concat cpplint-cmd (buffer-file-name))))

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
(global-ede-mode 1)
(ede-enable-generic-projects)
(ede-cpp-root-project
 "Gatling"
 :name "Gatling Project"
 :file "~/gat/cscope.files"
 :include-path '("include"
		 "../include"
		 "/third_party/poco-1.4.6p1/Net/include"
		 "/third_party/poco-1.4.6p1/Foundation/include"
		 "/third_party/poco-1.4.6p1/Util/include"
		 "/third_party/poco-1.4.6p1/XML/include"
		 "/third_party/third_party/sparsehash-2.0.2/src/")
 ;;                 "/Common"
 ;;                 "/Interfaces"
 ;;                 "/Libs"
 ;;                )
 ;; :system-include-path '("~/exp/include")
 :spp-table '(("POCO_HAVE_FD_EPOLL" . "1")
	      ;;              ("BOOST_TEST_DYN_LINK" . "")
	      ))

(provide 'cpp-conf)
