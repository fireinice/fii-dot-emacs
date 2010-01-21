;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init.el
;; Author: zigler
;; Description: 
;; Created: 三  8月 27 09:37:28 2008 (CST)
;;           By: Zhiqiang.Zhang
;; Last-Updated: 二  8月  4 11:09:44 2009 (CST)
;;     Update #: 383
;; 
;; 
;;; Change log:
;; 
;; ========加载路径 start
;;default for 23
;;add all subdirectories into the load-path except start with dot
(dolist (file-name (directory-files "~/.emacs.d" t))
  (when (file-directory-p file-name)
    (unless
	(equal "."
	       (substring
		(file-name-nondirectory file-name) 0 1))
      (add-to-list 'load-path file-name))))

(if (string-match "22" (emacs-version))
    (require 'linum))

;;========调用公用模块
(autoload 'svn-status "vc-svn" nil t)
(autoload 'fvwm-mode "fvwm-mode" nil t)
(autoload 'cl "cl" nil)
(autoload 'smart-compile "smart-compile" nil t)
(autoload 'regex-tool "regex-tool" nil t)
(require 'ido)
(require 'unicad)
(require 'ange-ftp) ;req by tramp for ftp protocol
(require 'tramp)
(fmakunbound 'git-status)   ; Possibly remove Debian's autoloaded version
(require 'git-emacs-autoloads)
(autoload 'git-status "git-status"
  "Launch git-emacs's status mode on the specified directory." t)
(require 'my-function) ;load function customized
(require 'uniquify) ;to identified same name buffer


(require 'tabbar)
(require 'install-elisp)
(require 'template)
(require 'color-moccur)
(require 'cc-mode)

(template-initialize)
(setq install-elisp-repository-directory "~/.emacs.d/misc/")
(dolist (cmd '(ido-select-text ido-magic-forward-char
                               ido-exit-minibuffer))
  (add-to-list 'template-find-file-commands cmd))


;; (require 'xcscope)
;; (require 'doxymacs)
;; (autoload 'senator-try-expand-semantic "senator")
;; (autoload 'two-mode-mode "two mode mode")
;; (require 'ede)
;; (require 'ecb)
;; (require 'two-mode-mode)


;;私人信息,if you are not author please comment this line
(load-file "~/.emacs.d/conf/projects-conf.el") ;;porjects
;; 设置 custom-file 可以让用 M-x customize 这样定义的变量和 Face 写入到
;; 这个文件中
(setq custom-file "~/.emacs.d/myinfo.el")
(load custom-file)
;; end of 私人信息

;;========END

;;========CEDET
;; http://www.linuxforum.net/forum/showflat.php?Board=vim&Number=687565
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
(load-file "~/.emacs.d/cedet/common/cedet.el")

;; Enable EDE (Project Management) features
(global-ede-mode 1)
;; (ede-minor-mode t)
;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;; (semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

(eval-after-load "semantic-c" 
  '(dolist (d (list "/usr/include/c++/4.3"
		    "/usr/include/c++/4.3/i486-linux-gnu"
		    "/usr/include/c++/4.3/backward"
		    "/usr/local/include"
		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include"
		    "/usr/lib/gcc/i486-linux-gnu/4.3.2/include-fixed"
		    "/usr/include"))
     (semantic-add-system-include d)))
(eval-after-load "semantic-complete"
  '(setq semantic-complete-inline-analyzer-displayor-class
	 semantic-displayor-ghost)) 
;; (setq semanticdb-project-roots
;;         (list
;;         (expand-file-name "/")))
;; ;; (setq semantic-load-turn-everything-on t) 
;; (add-hook 'semantic-init-hooks
;; 	  (lambda ()
;; 	    'semantic-idle-completions-mode
;; 	    'semantic-mru-bookmark-mode))
;; ;; 指定semantic临时文件的路径，避免到处都是临时文件
(setq semanticdb-default-save-directory "~/.auto-save/semantic")
(setq semantic-idle-summary-function 'semantic-format-tag-uml-prototype) ;;让idle-summary的提醒包括参数名



;;========仅作用于X下
(when window-system
  (require 'icicles)
  ;; (require 'ecb-autoloads) ;;nox
  (setq x-select-enable-clipboard t) ;;使用剪切板
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))
;;=======End




;;=======基本设置 start
(server-start)
(setq major-mode 'text-mode)
(setq-default abbrev-mode t
	      kill-whole-line t        			; 在行首 C-k 时，同时删除该行。
	      truncate-partial-width-windows nil) 	;;多窗时自动多行显示
(setq ps-multibyte-buffer 'bdf-font-except-latin) 	; 打印
(setq transient-mark-mode t)  ; 高亮当前选中区
(setq suggest-key-bindings t) ; 当使用 M-x COMMAND 后，过 1 秒钟显示该 COMMAND 绑定的键。
;;下面的这个设置可以让光标指到某个括号的时候显示与它匹配的括号
(show-paren-mode t)
(setq show-paren-style 'parenthesis)
;; 当有两个文件名相同的缓冲时，使用前缀的目录名做 buffer 名字，不用原来的
;; foobar<?> 形式。
(setq uniquify-buffer-name-style 'forward)
(setq auto-image-file-mode t) ;;图片支持
(modify-coding-system-alist 'file "\\.nfo\\'" 'cp437) ;;打开nfo文件
;; 若要将注释改为斜体，可采用以下代码：
;;(font-lock-comment-face ((t (:italic t))))
;; (icy-mode)

;将备份文件放至~/tmp下
;; Emacs 中，改变文件时，默认都会产生备份文件(以 ~ 结尾的文件)。可以完全去掉
;; (并不可取)，也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一
;; 个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的两个版本和最新的
;; 五个版本。并且备份的时候，备份文件是复本，而不是原件。
(setq backup-directory-alist '(("." . "~/.auto-save")) 
      version-control t
      kept-old-versions 2
      kept-new-versions 5
      delete-old-versions t
      backup-by-copying t)

;语法高亮
(setq global-font-lock-mode t               
      font-lock-maximum-decoration t
      font-lock-verbose t
      font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;; 不要 tool-bar / scroll-bar / menu-bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq use-file-dialog nil)

(tabbar-mode t) ; 显示tab标签
(setq inhibit-startup-message t)        ;禁用启动信息
;; WoMan 不打开新的 frame
(setq woman-use-own-frame nil)

;;(hs-minor-mode t)
;;设置标题栏
;; (setq frame-title-format "emacs@%b")

;; 设置前景，,背景色 list-colors-display看颜色
(add-to-list 'default-frame-alist '(background-color . "grey25"))
(add-to-list 'default-frame-alist '(foreground-color . "grey85"))
(add-to-list 'default-frame-alist '(cursor-color . "red"))
(add-to-list 'default-frame-alist '(mouse-color . "slateblue"))
;; 修改默认的tramp方法为空，否则会出现ssh:sudo: unkown service错误，即把sudo作为参数传给ssh
;; (add-to-list 'tramp-default-method-alist
;;              '("\\`localhost\\'" "" "su"))
(setq tramp-default-method "")

;; 保证文件名相同的时候buffer名称是目录名+文件名
(setq uniquify-buffer-name-style 'forward)

;; 当你从不同的文件copy时保证重新indent
(defadvice yank (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))
 
(defadvice yank-pop (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

;;==============auto-fill
;;把 fill-column 设为 72. 这样的文字更好读。
(setq fill-column 72)
;;;; 解决中英文混排不能正确fill的问题
;;(put-charset-property ’chinese-cns11643-5 ’nospace-between-words t)
;;(put-charset-property ’chinese-cns11643-6 ’nospace-between-words t)
;;(put-charset-property ’chinese-cns11643-7 ‘nospace-between-words t)
;; ;;解决段首空格缩进的问题
;; (setq adaptive-fill-mode nil)
;; ;;解决fill时候不能识别汉字符号的问题
;; (setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]* \\($\\|[ \t]\\)\\)[ \t\n]*")
;; (setq sentence-end-double-space nil)
;; ;设置输入自动补全
;; ;;(setq-default auto-fill-function 'do-auto-fill)
;; (setq-default auto-fill-function
;; 	      (lambda ()
;; 		;; (add-blank-in-chinese-and-english (point-at-bol) (point-at-eol))
;; 		(do-auto-fill))) 

;;emacs23
;; (set-default-font "Consolas-16")
;; (set-fontset-font (frame-parameter nil 'font)
;; 		  'han '("SimSun". "unicode-bmp"))
;;=======End




;;========基本函数绑定
(define-key minibuffer-local-must-match-map [(tab)] 'minibuffer-complete) ;;对M-x仍使用原样式
;; (add-hook 'magit-mode-hook
;; 	  (lambda()
;; 	    (define-key magit-mode-map [(tab)] 'magit-toggle-section)))
 ;;对M-x仍使用原样式
(define-key Info-mode-map [(tab)] 'Info-next-reference)
(global-set-key [(tab)] 'my-indent-or-complete)
(setq outline-minor-mode-prefix [(control o)]) ;outline前缀设为Co 
(global-set-key [(control \;)] 'my-comment-or-uncomment-region)
(global-set-key "\r" 'newline-and-indent)
;; note TAB can be different to <tab> in X mode(not -nw mode).
;; the formal is C-i while the latter is the real "Tab" key in
;; your keyboard.
(global-set-key [(control \')] 'kid-c-escape-pair)
;; (global-set-key  (kbd "\C-t") 'kid-c-escape-pair)
(global-set-key  (kbd "\C-x \C-b") 'ibuffer-other-window)
;; (define-key c++-mode-map (kbd "<tab>") 'c-indent-command)
;; tabbar键盘绑定
(global-set-key (kbd "\C-c\C-r") 'eval-print-last-sexp)
(global-set-key (kbd "\C-cbp") 'tabbar-backward-group)
(global-set-key (kbd "\C-cbn") 'tabbar-forward-group)
(global-set-key (kbd "\C-cbj") 'tabbar-backward)
(global-set-key (kbd "\C-cbk") 'tabbar-forward)
(global-set-key (kbd "\C-crm")  'ska-point-to-register)
(global-set-key (kbd "\C-crj")  'ska-jump-to-register)
(global-set-key (kbd "\C-ccu")  'revert-buffer)
(global-set-key (kbd "\C-ccr")  'smart-run) 
(global-set-key (kbd "\C-x %") 'kill-match-paren)
(global-set-key (kbd "\C-cvg")	'magit-status)
(global-set-key (kbd "\C-cvc")	'cvs-status)
(global-set-key (kbd "\C-cpl")  'project-load)
(global-set-key (kbd "\C-cpc")  'project-compile)
(global-set-key (kbd "\C-ccf")	'ffap)
;;========END




;;========Hippie-Expand
(setq hippie-expand-try-functions-list
;; (make-hippie-expand-function
 '(
	yas/hippie-try-expand
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

;;=========ibuffer
(setq ibuffer-default-sorting-mode 'major-mode)


;;=========speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t) 
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(autoload 'sr-speedbar-toggle "sr-speedbar")
;; w3 link listings
(autoload 'w3-speedbar-buttons "sb-w3" "s3 specific speedbar button generator.")
(global-set-key [(f4)] 'sr-speedbar-toggle) 
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
;;===========grep配置
(add-hook 'grep-mode-hook
	  (lambda()
	    (require 'grep-edit)))

;;=========c/c++模式
(add-hook 'c-mode-common-hook
          (lambda()
            (require 'cpp-conf)))

;;========Emacs Muse 模式
(autoload 'muse-mode "muse-mode")
(add-to-list 'auto-mode-alist '("\\.muse$" . muse-mode))
(add-hook 'muse-mode-hook
          (lambda()
            (require 'muse-conf)))

;;========Gnus 模式
(setq gnus-inhibit-startup-message t
      gnus-init-file "~/.emacs.d/conf/gnus-conf.el")

;=========Auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil) 
(add-hook 'TeX-mode-hook
	  (lambda()
	    (require 'auctex-conf)))

;;=========ediff
(add-hook 'ediff-mode-hook
          (lambda()
	    ;;将ediff的默认buffer排列改为左右而非上下
	    (setq ediff-split-window-function 'split-window-horizontally
	    ;;ediff不单独打开一个窗口输入命令
		  ediff-window-setup-function 'ediff-setup-windows-plain)))

;;=========smart-compile
;; 智能编译:支持c/c++/elisp/html/muse 绑定到 F9
(global-set-key (kbd "<f9>") 'smart-compile)
(require 'smart-compile-conf)

;; 自动设置script buffer 为可执行
(add-hook 'after-save-hook
        #'(lambda ()
        (and (save-excursion
               (save-restriction
                 (widen)
                 (goto-char (point-min))
                 (save-match-data
                   (looking-at "^#!"))))
             (not (file-executable-p buffer-file-name))
             (shell-command (concat "chmod u+x " buffer-file-name))
             (message
              (concat "Saved as script: " buffer-file-name)))))

(define-auto-insert 'cperl-mode  "perl.tpl" )
(define-auto-insert 'sh-mode '(nil "#!/usr/bin/env bash\n\n"))
					; 也可以是,不过我没有试过
					; (define-auto-insert "\\.pl"  "perl.tpl" )
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

(add-hook 'find-file-hooks 'auto-insert)

;;========ido 模式
(ido-mode t)
(setq ido-enable-flex-matching t)
(ido-everywhere t)
(add-hook 'ido-setup-hook
	  (lambda()
	    (define-key ido-completion-map [(tab)] 'ido-complete)
	    (add-to-list 'ido-ignore-files "\\`\\.svn/")
	    (add-to-list 'ido-ignore-files "\\`TAGS")
	    (add-to-list 'ido-ignore-buffers "\\`\\.bbdb")
	    (add-to-list 'ido-ignore-buffers "\\`\\.newsrc.dribble")
	    (add-to-list 'ido-ignore-buffers "\\`*Completions*")
	    (add-to-list 'ido-ignore-buffers "\\`*svn-process*")))

;;=========w3m
;; (require 'w3m)
;; (add-hook 'w3m-mode-hook
;;           (lambda()
;;             (load-file "~/.emacs.d/conf/w3m-conf.el")))

;=========HTML 模式

(add-to-list 'auto-mode-alist
             '("\\.html$" . zzq-html-mode))
;; only special background in submode
(setq mumamo-chunk-coloring 'submode-colored)
(setq nxhtml-skip-welcome t)
 
;; do not turn on rng-validate-mode automatically, I don't like
;; the anoying red underlines
;; (setq rng-nxml-auto-validate-flag nil)
 
;; force to load another css-mode, the css-mode in nxml package
;; seems failed to load under my Emacs 23
;; (let ((load-path (cons "~/emacs/extension/"
;;                        load-path)))
;; (require 'css-mode)

;;在html和css模式下将#XXXXXX按所代表的颜色着色

(defvar hexcolour-keywords
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property (match-beginning 0)
                            (match-end 0)
                            'face (list :background
                                        (match-string-no-properties 0)))))))
(defun hexcolour-add-to-font-lock ()
   (font-lock-add-keywords nil hexcolour-keywords))
(add-hook 'nxhtml-mumamo-mode 'hexcolour-add-to-font-lock)

(defun zzq-html-mode ()
;;   (define-key nxml-mode-map [(alt \/)] 'nxml-complete)
  (nxhtml-mumamo-mode)
  ;; I don't use cua-mode, but nxhtml always complains. So, OK, let's
  ;; define this dummy variable
;;   (define-key nxhtml-mode-map  "\eh" 'nxml-complete)
  (make-local-variable 'cua-inhibit-cua-keys)
  (setq mumamo-current-chunk-family '("eRuby nXhtml Family" nxhtml-mode
                                      (mumamo-chunk-eruby
                                       mumamo-chunk-inlined-style
                                       mumamo-chunk-inlined-script
                                       mumamo-chunk-style=
                                       mumamo-chunk-onjs=)))
;;   (rails-minor-mode t)
  (auto-fill-mode -1)
  (setq tab-width 2)
  (setq indent-tabs-mode nil))

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


;;=========Python 模式
(setq auto-mode-alist
      (cons '("\\.py$" . python-mode)
	    auto-mode-alist))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
	    interpreter-mode-alist))
(add-hook 'python-mode-hook
	  (lambda ()
	    (require 'python-conf)
	    (setup-python-mode)))
	    
;;=========Ruby 模式
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode))
              auto-mode-alist))
;;如果文件后缀名不为.rb，但是脚本第一行有#!ruby之类的说明
;;也相应调用此ruby模式
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))
(setq auto-mode-alist
      (cons '("\\.rhtml$" . two-mode-mode) auto-mode-alist))
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)
(add-hook 'ruby-mode-hook
          (lambda()
	    (require 'ruby-conf)
	    (setup-ruby-mode)))

;=========SQL模式
(autoload 'mysql "mysql")
(autoload 'sql-completion "sql completion")
(setq sql-interactive-mode-hook
      (lambda ()
  (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
  (sql-mysql-completion-init)))

;==========YAML 模式
(autoload 'yaml-mode "yaml-mode.el" nil t)  
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;==========ELisp 模式
(add-hook 'emacs-lisp-mode-hook
	  (lambda()
	    (require 'paredit)
	    (turn-on-eldoc-mode)
	    (paredit-mode t)
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
(require 'shell-completion)
(require 'shell-history)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on) ;; make the shell mode highlight
(setq comint-prompt-read-only t) ;; to make the the shell prompt readonly


;;========lftp
;; If you want use with lftp, put this to .emacs
(defvar my-lftp-sites (shell-completion-get-file-column "~/.lftp/bookmarks" 0 "[ \t]+"))
(add-to-list 'shell-completion-options-alist
             '("lftp" my-lftp-sites))
(add-to-list 'shell-completion-prog-cmdopt-alist
             '("lftp" ("help" "open" "get" "mirror") ("open" my-lftp-sites)))

;;==========weblogger
;; (setq weblogger-entry-mode-hook 'html-mode)
(autoload 'weblogger-start-entry "weblogger" nil t)
(global-set-key "\C-cbs" 'weblogger-start-entry)

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



;;=======color-moccur=============================
(setq *moccur-buffer-name-exclusion-list*
      '(".+TAGS.+" "*Completions*" "*Messages*"
	"newsrc.eld" ".bbdb"))
(setq moccur-split-word t)

;; (setq dmoccur-use-list t)
;; (setq dmoccur-use-project t)
;; (setq dmoccur-list
;;       '(
;;         ("dir" default-directory (".*") dir)
;;         ("soft" "~/www/soft/" ("\\.texi$") nil)
;;         ("config" "~/mylisp/"  ("\\.js" "\\.el$") nil)
;;         ("1.99" "d:/unix/Meadow2/1.99a6/" (".*") sub)
;;         ))
;; (global-set-key "\C-x\C-o" 'occur-by-moccur)
;; (define-key Buffer-menu-mode-map "O" 'Buffer-menu-moccur)
;; (define-key dired-mode-map "O" 'dired-do-moccur)
;; (global-set-key "\C-c\C-x\C-o" 'moccur)
;; (global-set-key "\M-f" 'grep-buffers)
;; (global-set-key "\C-c\C-o" 'search-buffers)


;;========org mode==============================
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-hide-leading-stars t)
(setq org-log-done t)
;; (require 'jira)
;;=======org mode end here======================

;;=========yasnipet mode
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")
(if window-system
    (progn
      (setq yas/window-system-popup-function
	    'yas/x-popup-menu-for-template)))

;; (local-set-key "("
;;                '(lambda ()
;;                   (interactive)
;;                   (yas/expand-snippet (point) (point) "($0)"))) 
;; (local-set-key "\""
;;                '(lambda ()
;;                   (interactive)
;;                   (yas/expand-snippet (point) (point) "\"$0\""))) 
;;========init.el end here

