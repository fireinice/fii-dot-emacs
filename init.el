;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init.el
;; Copyright (c) 2006 Ask Jeeves Technologies. ALL RIGHTS RESERVED.;; 
;; Author: zigler
;; Description: 
;; Created: 三  8月 27 09:37:28 2008 (CST)
;;           By: zigler
;; Last-Updated: 五  9月  5 16:47:23 2008 (CST)
;;     Update #: 39
;; 
;; 
;;; Change log:
;; 
;; ========加载路径 start
(setq load-path (cons "~/.emacs.d/misc/" load-path))
(setq load-path (cons "~/.emacs.d/sql/" load-path))
(setq load-path (cons "~/.emacs.d/emacs-rails/" load-path))
;; (setq load-path (cons "~/.emacs.d/tramp/" load-path))
(setq load-path (cons "~/.emacs.d/python-mode/" load-path))
(setq load-path (cons "~/.emacs.d/html-helper/" load-path))
(setq load-path (cons "~/.emacs.d/weblogger" load-path))
;; add git support(only in debian)
(setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))



;;========调用公用模块
(load-file "~/.emacs.d/myinfo.el") ;;私人信息,if you are not author please comment this line
(load-library "vc-svn")
(autoload 'senator-try-expand-semantic "senator")
(autoload 'two-mode-mode "two mode mode")
(autoload 'cl "cl")
(require 'smart-compile)
(require 'fvwm-mode)
(require 'html-helper-mode)
(require 'weblogger)
(require 'unicad)
(require 'muse)
(require 'htmlize)
(require 'ido)
(require 'tramp)
(require 'ange-ftp)
(require 'speedbar)
(require 'tabbar)
;; 加载显示行号的功能
(require 'setnu)
(require 'cc-mode)
(require 'doxymacs)
(require 'regex-tool)
(require 'xcscope)
(require 'ruby-mode)
;; (require 'ecb)
;; (require 'setnu+)			;
;; (require 'two-mode-mode)
;;========END




;;========仅作用于X下
(if window-system
    (progn
      (require 'ecb-autoloads) ;;nox
      (setq x-select-enable-clipboard t) ;;使用剪切板
      (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
      (defvar my-speedbar-buffer-name ;;{{{  speedbar within frame
	(if (buffer-live-p speedbar-buffer)
	    (buffer-name speedbar-buffer)
	  "*SpeedBar*"))
      (defun my-speedbar-no-separate-frame ()
	(interactive)
	(when (not (buffer-live-p speedbar-buffer))
	  (setq speedbar-buffer (get-buffer-create my-speedbar-buffer-name)
		speedbar-frame (selected-frame)
		dframe-attached-frame (selected-frame)
		speedbar-select-frame-method 'attached
		speedbar-verbosity-level 0
		speedbar-last-selected-file nil)
	  (set-buffer speedbar-buffer)
	  (speedbar-mode)
	  (speedbar-reconfigure-keymaps)
	  (speedbar-update-contents)
	  (speedbar-set-timer 1)
	  (make-local-hook 'kill-buffer-hook)
	  (add-hook 'kill-buffer-hook
		    (lambda () (when (eq (current-buffer) speedbar-buffer)
				 (setq speedbar-frame nil
				       dframe-attached-frame nil
				       speedbar-buffer nil)
				 (speedbar-set-timer nil)))))
	(set-window-buffer (selected-window)
			   (get-buffer my-speedbar-buffer-name))))
)

;;=======End




;;=======基本设置 start
(setq default-major-mode 'text-mode)
(setq-default abbrev-mode t)
(setq-default kill-whole-line t)        ; 在行首 C-k 时，同时删除该行。
(setq-default truncate-partial-width-windows nil) ;;多窗时自动多行显示
(setq default-fill-column 72)
(setq ps-multibyte-buffer 'bdf-font-except-latin) ; 打印
(setq transient-mark-mode t)  ; 高亮当前选中区
(setq suggest-key-bindings 1) ; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。
;;下面的这个设置可以让光标指到某个括号的时候显示与它匹配的括号
(delete-selection-mode 1) ;像windows选区一样对待emacs选区
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;; 当有两个文件名相同的缓冲时，使用前缀的目录名做 buffer 名字，不用原来的
;; foobar<?> 形式。
(setq uniquify-buffer-name-style 'forward)
(setq auto-image-file-mode t) ;;图片支持
(modify-coding-system-alist 'file "\\.nfo\\'" 'cp437) ;;打开nfo文件
;; 若要将注释改为斜体，可采用以下代码：
;;(font-lock-comment-face ((t (:italic t))))

(setq backup-directory-alist '(("." . "~/.auto-save"))) ;将备份文件放至~/tmp下
;; Emacs 中，改变文件时，默认都会产生备份文件(以 ~ 结尾的文件)。可以完全去掉
;; (并不可取)，也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一
;; 个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的两个版本和最新的
;; 五个版本。并且备份的时候，备份文件是复本，而不是原件。
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-by-copying t)

(global-font-lock-mode t)               ;语法高亮
(setq font-lock-maximum-decoration t)
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;; 不要 tool-bar / scroll-bar / menu-bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tabbar-mode t) ; 显示tab标签
(setq inhibit-startup-message t)        ;禁用启动信息
;;(hs-minor-mode t)
;;设置标题栏
;; (setq frame-title-format "emacs@%b")

;; 设置前景，,背景色 list-colors-display看颜色
(set-background-color "grey25")
(set-foreground-color "grey85")
(set-cursor-color "steelblue")
(set-cursor-color "red")
(set-mouse-color "slateblue")

;; 修改默认的tramp方法为空，否则会出现ssh:sudo: unkown service错误，即把sudo作为参数传给ssh
;; (add-to-list 'tramp-default-method-alist
;;              '("\\`localhost\\'" "" "su"))
(setq tramp-default-method "")

;;emacs23
;; (set-default-font "Consolas-16")
;; (set-fontset-font (frame-parameter nil 'font)
;; 		  'han '("SimSun" . "unicode-bmp"))
;;=======End





;;=======基本函数
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))
(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))
;;注释一行或一个block 绑定到 C-;
(defun my-comment-or-uncomment-region (&optional line)
  "This function is to comment or uncomment a line or a region"
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (save-excursion
        (comment-or-uncomment-region
         (progn
           (beginning-of-line)
           (point))
         (progn
           (end-of-line)
           (point))))
    (call-interactively 'comment-or-uncomment-region)))
;;字数统计
(defun zjs-count-word ()
  (interactive)
  (let ((beg (point-min)) (end (point-max))
        (eng 0) (non-eng 0))
    (if mark-active
        (setq beg (region-beginning)
              end (region-end)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond ((not (equal (car (syntax-after (point))) 2))
               (forward-char))
              ((< (char-after) 128)     
               (progn
                 (setq eng (1+ eng))
                 (forward-word)))
              (t
               (setq non-eng (1+ non-eng))
               (forward-char)))))
    (message "English words: %d\nNon-English characters: %d"
             eng non-eng))) 
;;jump out from a pair(like quote, parenthesis, etc.)
(defun kid-c-escape-pair ()
  (interactive)
  (let ((pair-regexp "[^])}\"'>]*[])}\"'>]"))
    (if (looking-at pair-regexp)
	(progn
	  ;; be sure we can use C-u C-@ to jump back
	  ;; if we goto the wrong place
	  (push-mark) 
	  (goto-char (match-end 0)))
      (c-indent-command))))

(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

(add-hook 'after-save-hook
	  (lambda ()
	    (mapcar
	     (lambda (file)
	       (setq file (expand-file-name file))
	       (when (string= file (buffer-file-name))
		 (save-excursion (byte-compile-file file))))
	     '("~/.emacs.d/*.el" "~/.emacs.d/conf/*.el"))))
;;========END




;;========基本函数绑定
(define-key minibuffer-local-must-match-map [(tab)] 'minibuffer-complete) ;;对M-x仍使用原样式
(define-key Info-mode-map [(tab)] 'Info-next-reference)
(global-set-key [(tab)] 'my-indent-or-complete)

(setq outline-minor-mode-prefix [(control o)]) ;outline前缀设为Co 
(global-set-key [(control \;)] 'my-comment-or-uncomment-region)
(global-set-key "\r" 'newline-and-indent)
;; note TAB can be different to <tab> in X mode(not -nw mode).
;; the formal is C-i while the latter is the real "Tab" key in
;; your keyboard.
(global-set-key [(control \')] 'kid-c-escape-pair)
;; (define-key c++-mode-map (kbd "<tab>") 'c-indent-command)
;; tabbar键盘绑定
(global-set-key (kbd "\C-cbp") 'tabbar-backward-group)
(global-set-key (kbd "\C-cbn") 'tabbar-forward-group)
(global-set-key (kbd "\C-cbj") 'tabbar-backward)
(global-set-key (kbd "\C-cbk") 'tabbar-forward)
(global-set-key (kbd "\C-cm")  'ska-point-to-register)
(global-set-key (kbd "\C-cp")  'ska-jump-to-register)
;;========END




;;========Hippie-Expand
;; (setq hippie-expand-try-functions-list
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
	try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-expand-whole-kill))



;;=========speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t) 
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t) 
(global-set-key [(f4)] 'speedbar-get-focus) 
(define-key-after (lookup-key global-map [menu-bar tools]) 
  [speedbar]
  '("Speedbar" . speedbar-frame-mode)
  [calendar]) 
;; Texinfo fancy chapter tags 
;; (add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo))) 
;; HTML fancy chapter tags 
(add-hook 'speedbar-load-hook
	  (lambda ()
	    (require 'semantic-sb))) ;;semantic支持
;; w3 link listings
(autoload 'w3-speedbar-buttons "sb-w3" "s3 specific speedbar button generator.") 


;;========semantic
(setq semanticdb-project-roots
        (list
        (expand-file-name "/")))
(setq semantic-load-turn-everything-on t) 
(add-hook 'semantic-init-hooks
	  (lambda ()
	    'semantic-idle-completions-mode
	    'semantic-mru-bookmark-mode))
;; 指定semantic临时文件的路径，避免到处都是临时文件
(setq semanticdb-default-save-directory "~/.auto-save/semantic")
;; Enabling various SEMANTIC minor modes. See semantic/INSTALL for more ideas.
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-guady-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
(semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development. It does not enable any other features such as code
;; helpers above.
;; (semantic-load-enable-semantic-debugging-helpers)

;;===========ecb配置
(setq ecb-tree-indent 4
      ecb-windows-height 0.5
      ecb-windows-width 0.20
;;       ecb-auto-compatibility-check nil
;;       ecb-version-check nil
      inhibit-startup-message t
      ecb-tip-of-the-day nil
      ecb-tree-navigation-by-arrow t);;使用箭头键展开或折叠
(global-set-key [\C-f4] 'ecb-activate)         ;启用ECB
(global-set-key [\C-S-f4] 'ecb-deactivate)     ;退出ECB

;;使用ecb: http://blog.csdn.net/xiaoliangbuaa/archive/2007/01/10/1479577.aspx

;;=========c/c++模式
(add-hook 'c-mode-common-hook
          (lambda()
            (load-file "~/.emacs.d/conf/cpp-conf.el")))

;;========Emacs Muse 模式
(autoload 'muse-mode "muse-mode")
(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))
(add-hook 'muse-mode-hook
          (lambda()
            (load-file "~/.emacs.d/conf/muse-conf.el")))

;;========Gnus 模式
(setq gnus-inhibit-startup-message t
      gnus-init-file "~/.emacs.d/conf/gnus-conf.el")

;=========Auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil) 
(add-hook 'tex-mode-hook
	  (lambda()
	    (load-file "~/.emacs.d/conf/auctex-conf.el")))

;;=========ediff
(add-hook 'ediff-mode-hook
          (lambda()
	    ;;将ediff的默认buffer排列改为左右而非上下
	    (setq ediff-split-window-function 'split-window-horizontally)
	    ;;ediff不单独打开一个窗口输入命令
	    (setq ediff-window-setup-function 'ediff-setup-windows-plain)))

;;=========smart-compile
;; 智能编译:支持c/c++/elisp/html/muse 绑定到 F9
(global-set-key (kbd "<f9>") 'smart-compile)

(setq smart-compile-alist
      '(("/network/asio/.*cpp$" .       "g++ -Wall %f -lm -lboost_thread -o %n")
;;         ("\\.c\\'"      .   "gcc -Wall %f -lm -o %n")
;;         ("\\.[Cc]+[Pp]*\\'" .   "g++ -Wall %f -lm -o %n")
	(emacs-lisp-mode    . (emacs-lisp-byte-compile))
	(html-mode          . (browse-url-of-buffer))
	(nxhtml-mode        . (browse-url-of-buffer))
	(html-helper-mode   . (browse-url-of-buffer))
	(octave-mode        . (run-octave))
	("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
	;;  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n && ./%n")
	("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
	("\\.m\\'"          . "gcc -O2 %f -lobjc -lpthread -o %n")
	("\\.java\\'"       . "javac %f")
;; 	("\\.php\\'"        . "php -l %f")
;; 	("\\.f90\\'"        . "f90 %f -o %n")
;; 	("\\.[Ff]\\'"       . "f77 %f -o %n")
;; 	("\\.cron\\(tab\\)?\\'" . "crontab %f")
;; 	("\\.tex\\'"        . (tex-file))
	("\\.tex$"          . (TeX-command-master))
	("\\.texi\\'"       . "makeinfo %f")
;; 	("\\.mp\\'"         . "mptopdf %f")
	("\\.pl\\'"         . "perl -cw %f")
	("\\.rb\\'"         . "ruby -cw %f")
;; ;    ("\\.skb$"              .       "skribe %f -o %n.html")
;; ;    (haskell-mode           .       "ghc -o %n %f")
;; ;    (asy-mode               .       (call-interactively 'asy-compile-view))
        (muse-mode      .   (call-interactively 'muse-project-publish))))



;;========ido 模式
(ido-mode t)
(add-hook 'ido-setup-hook
	  (lambda()
	    (define-key ido-completion-map [(tab)] 'ido-complete)))

;;=========w3m
(require 'w3m)
(add-hook 'w3m-mode-hook
          (lambda()
            (load-file "~/.emacs.d/conf/w3m-conf.el")))

;=========HTML 模式
;; (require 'tempo)
(defvar html-mode-abbrev-table nil
  "Abbrev table in use in `html-mode' buffers.")
(define-abbrev-table 'html-mode-abbrev-table ())
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(add-hook 'html-helper-load-hook
	  (lambda ()
	    (require 'sb-html) ;;speedbar 支持
	    (setq tempo-interactive t)
	    (setq html-helper-build-new-buffer t)
	    (define-key html-helper-mode-map [(tab)] 'tempo-complete-tag)))

;;========JavaScript 模式
;; (autoload 'javascript-mode "javascritp mode")
;; (add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
;; (setq javascript-indent-level 2)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(defvar js2-mode-abbrev-table nil
  "Abbrev table in use in `js2-mode' buffers.")
(define-abbrev-table 'js2-mode-abbrev-table ())
(setq js2-use-font-lock-faces t)

;=========python mode
;; (require 'pymacs)
;; (require 'pymacs-load)
;; (autoload 'py-complete-init "py-complete")
;; (add-hook 'python-mode-hook 'py-complete-init)
(require 'python-mode)
;; (require 'pycomplete)
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
	    (setq tab-width 4 indent-tabs-mode nil)
;; 	    (which-function-mode t)
	    (hs-minor-mode 1)
;; 	    (py-shell 1)
	    (abbrev-mode t)
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")
;; 	    (flymake-mode 1) ;;!!flymake-allowed-file-name should be hacked
))

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

;=========Ruby 模式
;;如果文件后缀名不为.rb，但是脚本第一行有#!ruby之类的说明
;;也相应调用此ruby模式
(autoload 'ruby-electric "ruby electric")
(autoload 'rails "rails mode")
;;调用inf-ruby
(autoload 'run-ruby "inf-ruby"
      "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
      "Set local key defs for inf-ruby in ruby-mode")
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode))
              auto-mode-alist))
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))
(setq auto-mode-alist
      (cons '("\\.rhtml$" . two-mode-mode) auto-mode-alist))
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)
(add-hook 'ruby-mode-hook
          (lambda()
            (load-file "~/.emacs.d/conf/ruby-conf.el")))

;=========SQL模式
(autoload 'mysql "mysql")
(autoload 'sql-completion "sql completion")
(setq sql-interactive-mode-hook
      (lambda ()
  (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
  (sql-mysql-completion-init)))

;==========YAML 模式
(autoload 'yaml-mode "yaml mode")
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;==========ELisp 模式
(add-hook 'emacs-lisp-mode-hook
	  (lambda()
	    (make-hippie-expand-function
	     '(try-complete-abbrev
	       try-complete-lisp-symbol-partially
	       try-complete-lisp-symbol
	       try-expand-dabbrev-visible
	     try-expand-dabbrev
	     try-expand-dabbrev-all-buffers
	     try-expand-dabbrev-from-kill
	     try-expand-list
	     try-expand-list-all-buffers
	     try-complete-file-name-partially
	     try-complete-file-name
	     try-expand-whole-kill))))

;=========Shell 模式
;; Put this file into your load-path and the following into your ~/.emacs:
(require 'shell-completion)
(require 'shell-history)

;;=========yasnipet mode
(require 'yasnippet) ;; not yasnippet-bundle
(require 'smart-snippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")
(if window-system
    (progn
      (setq yas/window-system-popup-function
	    'yas/x-popup-menu-for-template)))

;; those non-word snippet can't be triggered by abbrev expand, we
;; need to bind them explicitly to some key
(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table
  c-mode-abbrev-table
  java-mode-abbrev-table
  ruby-mode-abbrev-table
;;   js2-mode-abbrev-table
  python-mode-abbrev-table)
 ("{" "{$.}" '(not (c-in-literal)))
 ("{" "{$>\n$>$.\n}$>" 'bol?)
 ;; if not in comment or other stuff(see `c-in-literal'), then
 ;; inser a pair of quote. if already in string, insert `\"'
 ("\"" "\"$.\"" '(not (c-in-literal)))	
 ("\"" "\\\"$." '(eq (c-in-literal) 'string))
 ;; insert a pair of parenthesis, useful everywhere
 ("(" "($.)" t)
 ;; insert a pair of angular bracket if we are writing templates
 ("<" "<$.>" '(and (not (c-in-literal))
		   (looking-back "template[[:blank:]]*")))
 ;; a pair of square bracket, also useful everywhere
 ("[" "[$.]" t)
 ;; a pair of single quote, if not in literal
 ("'" "'$.'" '(not (c-in-literal)))
 ("," ", " '(not (c-in-literal)))
 )

(smart-snippet-with-abbrev-tables
 (ruby-mode-abbrev-table)
 ("/" "/$./" '(not (c-in-literal)))
 )


(smart-snippet-with-keymaps
 ((c++-mode-map c++-mode-abbrev-table)
  (c-mode-map c-mode-abbrev-table)
  (java-mode-map java-mode-abbrev-table)
  (ruby-mode-map ruby-mode-abbrev-table)
  (py-mode-map python-mode-abbrev-table))
  ("{" "{")
  ("\"" "\"")
  ("(" "(")
  ("<" "<")
  ("[" "[")
  ("'" "'"))
;; (local-set-key "("
;;                '(lambda ()
;;                   (interactive)
;;                   (yas/expand-snippet (point) (point) "($0)"))) 
;; (local-set-key "\""
;;                '(lambda ()
;;                   (interactive)
;;                   (yas/expand-snippet (point) (point) "\"$0\""))) 

;;========lftp
;; If you want use with lftp, put this to .emacs
(defvar my-lftp-sites (shell-completion-get-file-column "~/.lftp/bookmarks" 0 "[ \t]+"))
(add-to-list 'shell-completion-options-alist
             '("lftp" my-lftp-sites))
(add-to-list 'shell-completion-prog-cmdopt-alist
             '("lftp" ("help" "open" "get" "mirror") ("open" my-lftp-sites)))

;;==========weblogger
;; (setq weblogger-entry-mode-hook 'html-mode)
(global-set-key "\C-cbs" 'weblogger-start-entry)

;;==========header2
;;文件头header设置
(require 'header2)
;; // -*- mode:C++; tab-width:4; c-basic-offset:4; indent-tabs-mode:t -*-
;; /*************************************************************************
;;  *  Copyright (c) 2006 Ask Jeeves Technologies. ALL RIGHTS RESERVED.     *
;;  *************************************************************************/
;; /**
;;  * \file    CheckURL.cc
;;  * \brief	Implementation of CheckURL class
;;  *
;;  * \author  Xinran Zhou (xzhou@ask.com)
;;  * \author  Wuyun Kang (wkang@ask.com)
;;  * \bug     No known bugs
;;  *
;;  * $Date: 2007/06/18 06:39:19 $
;;  * $Revision: 1.1 $
;;  */

(setq header-copyright-notice "Copyright (c) 2006 Ask Jeeves Technologies. ALL RIGHTS RESERVED.")
(defun zigler-python-mode-config-header ()
  (interactive)
  (setq make-header-hook '(header-mode-line
			   header-copyright
			   header-blank
			   header-file-name
			   header-author
			   header-creation-date
			   header-modification-author
			   header-modification-date
			   header-update-count
			   header-blank
			   header-history
			   header-blank
			   )))
(setq make-header-hook '(header-mode-line
			 header-file-name
			 header-copyright
			 header-blank
			 header-author
			 header-description
			 header-creation-date
			 header-modification-author
			 header-modification-date
			 header-update-count
			 header-blank
			 header-history
			 header-blank
			 ))

(defvar wcy-header-project-name "XParser-Cross-Test-Tools")
(defun wcy-c-mode-config-header ()
  (interactive)
  (setq header-copyright-notice "
Copyright (c) 2006 Ask Jeeves Technologies. ALL RIGHTS RESERVED.
")
  (make-local-variable 'user-full-name)
  (make-local-variable 'user-mail-address)
  (setq user-full-name "ZhiQiang Zhang")
  (setq user-mail-address "zhiqiang.zhang@ask.com")

  (setq  make-header-hook '(header-mode-line
                             header-blank
                             wcy-header-file-name
                             wcy-header-project-name
                             wcy-header-file-description
                             header-creation-date
                             header-author
                             wcy-header-author-email
                             ;;header-modification-author
                             ;;header-modification-date
                             ;;header-update-count
                             header-blank
                             header-copyright
                             header-blank
                             ;;header-status
                             ;; Re-enable the following lines if you wish
                             header-blank
                             ;;header-history
                             ;;header-purpose
                             ;;header-toc
                             header-blank
                             wcy-header-end-comment
                             ))
  (setq file-header-update-alist nil)
  (progn
    (register-file-header-action "[ \t]Update Count[ \t]*: "
                                 'update-write-count)
    (register-file-header-action "[ \t]Last Modified By[ \t]*: "
                                 'update-last-modifier)
    (register-file-header-action "[ \t]Last Modified On[ \t]*: "
                                 'update-last-modified-date)
    (register-file-header-action " File            : *\\(.*\\) *$" 'wcy-update-file-name)
    ))


(defun wcy-header-file-name ()
  "Places the buffer's file name and leaves room for a description."
  (insert header-prefix-string "File            : " (buffer-name) "\n")
  (setq return-to (1- (point))))
(defun wcy-header-project-name ()
  (insert header-prefix-string "Program/Library : " wcy-header-project-name "\n"))
(defun wcy-header-file-description()
  (insert header-prefix-string "Description     : \n"))
(defun wcy-header-author-email ()
  (insert header-prefix-string "Mail            : " user-mail-address "\n"))

(defun wcy-header-end-comment ()
  (if comment-end
      (insert  comment-end "\n")))
(defun wcy-update-file-name ()
  (beginning-of-line)
  ;; verify that we are looking at a file name for this mode
  (if (looking-at
       (concat (regexp-quote (header-prefix-string)) "File            : *\\(.*\\) *$"))
      (progn
        (goto-char (match-beginning 1))
        (delete-region (match-beginning 1) (match-end 1))
        (insert (file-name-nondirectory (buffer-file-name)) )
        )))
(add-hook 'write-file-hooks 'update-file-header)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
;=========Top mode
;; (defun top-mode-solaris-generate-top-command (user)
;;   (if (not user)
;;       "top -b"
;;     (format "top -b -U%s" user)))
;; (setq top-mode-generate-top-command-function
;;       'top-mode-solaris-generate-top-command)
;; (setq top-mode-strace-command "truss")


;;;; anything.el

;; my setup and configuration for anything.el
;; the quicksilver of emacs

;; (require 'anything) ; not required when loading anything-config.el
(require 'anything-config)  ; loads anything.el too

;; (setq anything-sources (list anything-source-buffers
;; 			     anything-source-emacs-commands
;; 			     anything-source-locate
;; 			     anything-source-recentf
;; 			     anything-source-complex-command-history
;; 			     anything-source-emacs-functions
;; 			     anything-source-bookmarks))

;; (setq anything-type-actions (list anything-actions-buffer
;; 				  anything-actions-file
;; 				  anything-actions-command
;; 				  anything-actions-function
;; 				  anything-actions-sexp))

;; (setq anything-action-transformers
;;       '((buffer   . anything-transform-buffer-actions)
;; 	(file     . anything-transform-file-actions)
;; 	(command  . anything-transform-command-actions)
;; 	(function . anything-transform-function-actions)
;; 	(sexp     . anything-transform-sexp-actions)))

;; (setq anything-candidate-transformers
;;       '((buffer   . anything-transform-buffers)
;; 	(file     . anything-transform-files)
;; 	(command  . anything-transform-commands)
;; 	(function . anything-transform-functions)
;; 	(sexp     . anything-transform-sexps)))


;;========Flymake=====================================
;;echo error in minibuffer instead moving mouse on it
(load-library "flymake-cursor") 
(global-set-key "\C-c\C-e" 'flymake-goto-next-error)

(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()
	     ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
	     (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
		 (flymake-mode))
	     ))

;;========git=====================================
 (require 'vc-git)
 (when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
 (require 'git)
 (autoload 'git-blame-mode "git-blame"
           "Minor mode for incremental blame for Git." t)


;;========Custom Configure End HERE====================
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(canlock-password "69d4b0236bee5175fe24279b2799c0126960ae5f")
 '(ecb-options-version "2.32")
 '(flymake-allowed-file-name-masks (quote (("\\.c\\'" flymake-simple-make-init) ("\\.cpp\\'" flymake-simple-make-init) ("\\.xml\\'" flymake-xml-init) ("\\.html?\\'" flymake-xml-init) ("\\.cs\\'" flymake-simple-make-init) ("\\.pl\\'" flymake-perl-init) ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup) ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup) ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup) ("\\.tex\\'" flymake-simple-tex-init) ("\\.py\\'" flymake-pylint-init) ("\\.idl\\'" flymake-simple-make-init))))
 '(js2-highlight-level 3)
 '(pylint-options "--output-format=parseable --include-ids=yes")
 '(regex-tool-backend (quote perl))
 '(regex-tool-new-frame t)
 '(semantic-idle-scheduler-idle-time 432000)
 '(weblogger-save-password t))
 
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color)) (:background "LightPink" :foreground "black"))))
 '(flymake-warnline ((((class color)) (:background "LightBlue2" :foreground "black"))))
 '(regex-tool-matched-face ((t (:background "black" :foreground "Orange" :weight bold)))))

;;========init.el end here
