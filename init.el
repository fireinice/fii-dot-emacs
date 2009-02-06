;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: init.el
;; Author: zigler
;; Description: 
;; Created: 三  8月 27 09:37:28 2008 (CST)
;;           By: Zhiqiang.Zhang
;; Last-Updated: 五  2月  6 13:17:28 2009 (CST)
;;     Update #: 374
;; 
;; 
;;; Change log:
;; 
;; ========加载路径 start
(if (string-match "22" (emacs-version))
    (add-to-list 'load-path "~/.emacs.d/nxhtml/")
  (require 'linum))
;;default for 23
(add-to-list 'load-path "~/.emacs.d/misc/")
(add-to-list 'load-path "~/.emacs.d/sql/")
(add-to-list 'load-path "~/.emacs.d/emacs-rails/")
(add-to-list 'load-path "~/.emacs.d/python-mode/")
(add-to-list 'load-path "~/.emacs.d/html-helper/")
(add-to-list 'load-path "~/.emacs.d/weblogger/")
(add-to-list 'load-path "~/.emacs.d/icicles/")

;; add git support(only in debian)
(setq load-path (cons (expand-file-name "/usr/share/doc/git-core/contrib/emacs") load-path))



;;========调用公用模块
(load-library "vc-svn")
;; (autoload 'senator-try-expand-semantic "senator")
;; (autoload 'two-mode-mode "two mode mode")
(autoload 'cl "cl")
(autoload 'magit-status "magit" nil t)
;; (require 'paredit)
(require 'grep-edit)
(require 'color-moccur)
(require 'smart-compile)
(require 'fvwm-mode)
(require 'weblogger)
(require 'unicad)
(require 'muse)
(require 'htmlize)
(require 'ido)
(require 'tramp)
(require 'ange-ftp)
(require 'speedbar)
(require 'tabbar)
(require 'cc-mode)
(require 'doxymacs)
(require 'regex-tool)
(require 'xcscope)
(require 'ruby-mode)
;; (require 'ede)
(require 'uniquify)
(require 'sr-speedbar)
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/misc/")

;; (require 'ecb)
;; (require 'setnu+)	
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
(if window-system
    (progn
      
      (require 'icicles)

      ;;      (require 'ecb-autoloads) ;;nox
      (setq x-select-enable-clipboard t) ;;使用剪切板
      (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)))
;;=======End




;;=======基本设置 start
(server-start)
(setq default-major-mode 'text-mode)
(setq-default abbrev-mode t
	      ;; paredit-mode t
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

;;==============auto-fill
;;把 fill-column 设为 80. 这样的文字更好读。
(setq default-fill-column 80)
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
	     '("~/.emacs.d/init.el" "~/.emacs.d/myinfo.el"
  "~/.emacs.d/conf/cpp-conf.el"))))

;;中英文之间自动加空格
;; (defun add-blank-in-chinese-and-english (&optional start end)
;;   “automaticall add a blank between English and Chinese words.”
;;    (interactive)
;;    (save-excursion
;;      (progn
;;        (if (not start)
;; 	   (setq start (point-min)))
;;        (if (not end)
;; 	   (setq end (point-max)))
;;        (goto-char start)
;;        (while (and (re-search-forward ”\\(\\cc\\)\\([0-9-]*[a-z]\\)”  nil t)
;; 		   (<= (match-end 0) end ))
;; 	 (replace-match "\\1 \\2" nil nil))
;;        (goto-char start)
;;        (while (and (re-search-forward "\\([a-z][0-9-]*\\)\\(\\cc\\)"  nil t)
;; 		   (<= (match-end 0) end ))
;; 	 (replace-match "\\1 \\2" nil nil)))))

;删除匹配括号间内容 
(defun kill-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
	(t (self-insert-command (or arg 1)))))


;; substitute by paredit-mode
(defun zzq-wrap-region-with-paren ( start end)
  (interactive "r")
  (goto-char start)
  (insert "(")
  (goto-char (+ 1 end))
  (insert ")"))
(global-set-key (kbd "C-(")	'zzq-wrap-region-with-paren)

;;========END




;;========基本函数绑定
(define-key minibuffer-local-must-match-map [(tab)] 'minibuffer-complete) ;;对M-x仍使用原样式
(add-hook 'magit-mode-hook
	  (lambda()
	    (define-key magit-mode-map [(tab)] 'magit-toggle-section)))
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
;; (define-key c++-mode-map (kbd "<tab>") 'c-indent-command)
;; tabbar键盘绑定
(global-set-key (kbd "\C-cbp") 'tabbar-backward-group)
(global-set-key (kbd "\C-cbn") 'tabbar-forward-group)
(global-set-key (kbd "\C-cbj") 'tabbar-backward)
(global-set-key (kbd "\C-cbk") 'tabbar-forward)
(global-set-key (kbd "\C-crm")  'ska-point-to-register)
(global-set-key (kbd "\C-crj")  'ska-jump-to-register)
(global-set-key (kbd "\C-ccu")  'revert-buffer)
(global-set-key (kbd "\C-ccr")  'smart-run) 
(global-set-key (kbd "C-x %") 'kill-match-paren)
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



;;=========speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t) 
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t) 
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
;; w3 link listings
(autoload 'w3-speedbar-buttons "sb-w3" "s3 specific speedbar button generator.") 


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
(add-hook 'TeX-mode-hook
	  (lambda()
	    (load-file "~/.emacs.d/conf/auctex-conf.el")))

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


(setq smart-run-alist
      '(("\\.c$"          . "./%n")
        ("\\.[Cc]+[Pp]*$" . "./%n")
        ("\\.java$"       . "java %n")
        ("\\.php$"        . "php %f")
        ("\\.m$"          . "%f")
        ("\\.scm"         . "%f")
        ("\\.tex$"        . "dvisvga %n.dvi")
        ("\\.py$"         . "python %f")
        ("\\.pl$"         . "perl \"%f\"")
        ("\\.pm$"         . "perl \"%f\"")
        ("\\.bat$"        . "%f")
        ("\\.mp$"         . "mpost %f")
        ("\\.ahk$"        . "start d:\\Programs\\AutoHotkey\\AutoHotkey %f")
        ("\\.sh$"         . "./%f")))

(setq smart-executable-alist
      '("%n.class"
        "%n.exe"
        "%n"
        "%n.mp"
        "%n.m"
        "%n.php"
        "%n.scm"
        "%n.dvi"
        "%n.py"
        "%n.pl"
        "%n.ahk"
        "%n.pm"
        "%n.bat"
        "%n.sh"))

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
(load "~/.emacs.d/nxhtml/autostart.el")

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

;=========python mode
(require 'pymacs)
;; (require 'pymacs-load)
;; (autoload 'py-complete-init "py-complete")
;; (add-hook 'python-mode-hook 'py-complete-init)
(require 'python-mode)
;; (require 'pycomplete)
(require 'python)
(require 'auto-complete)
;; Initialize Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

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
	    (auto-complete-mode 1)
	    (setq tab-width 4 indent-tabs-mode nil)
;; 	    (which-function-mode t)
	    (hs-minor-mode 1)
;; 	    (py-shell 1)
	    (abbrev-mode t)
	    (set (make-variable-buffer-local 'beginning-of-defun-function)
		 'py-beginning-of-def-or-class)
	    (setq outline-regexp "def\\|class ")
	    (set (make-local-variable 'ac-sources)
		 (append ac-sources '(ac-source-rope)
			 '(ac-source-yasnippet)))
			 ;; ))
	    (set (make-local-variable 'ac-find-function) 'ac-python-find)
	    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
	    (set (make-local-variable 'ac-auto-start) nil)))
 
;; http://www.enigmacurry.com/2009/01/21/autocompleteel-python-code-completion-in-emacs/
;; Initialize Rope                                                                         
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; Auto-completion                                                                                            
;;;  Integrates:                                                                                               
;;;   1) Rope                                                                                                  
;;;   2) Yasnippet                                                                                             
;;;   all with AutoComplete.el                                                                                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))
(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")
(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))
(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))
 
;;Ryan's python specific tab completion                                                                        
(defun ryan-python-tab ()
  ; Try the following:                                                                                         
  ; 1) Do a yasnippet expansion                                                                                
  ; 2) Do a Rope code completion                                                                               
  ; 3) Do an indent                                                                                            
  (interactive)
  (if (eql (ac-start) 0)
      (indent-for-tab-command)))
 
(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))
 
(define-key python-mode-map [(tab)] 'ryan-python-tab)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                                         
;;; End Auto Completion                                                                                        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	    'turn-on-eldoc-mode
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
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (setq ansi-color-for-comint-mode t)

;;=========yasnipet mode
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")
(if window-system
    (progn
      (setq yas/window-system-popup-function
	    'yas/x-popup-menu-for-template)))

(require 'smart-snippet)
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
  (python-mode-map python-mode-abbrev-table))
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

;;=======color-moccur=============================
(load "color-moccur")
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

;;========init.el end here
