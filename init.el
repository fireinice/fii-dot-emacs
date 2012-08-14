
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
(eval-when-compile
  (require 'cl)
  (require 'cc-mode))

(defconst my-emacs-path "~/.emacs.d/" "emacs conf base path")

(defun zzq-subdirectories (directory)
  "List all not start with '.' sub-directories of DIRECTORY"
  (let (subdirectories-list)
    (dolist (file-name (directory-files directory t))
      (when (file-directory-p file-name)
	
	(unless
	    (equal "."
		   (substring
		    (file-name-nondirectory file-name) 0 1))
	  (add-to-list 'subdirectories-list file-name))))
    subdirectories-list))

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name (concat my-emacs-path "/elpa/package.el")))
  (package-initialize))

;; ========加载路径 start
;;add all subdirectories into the load-path except start with dot
(setq load-path
      (append (zzq-subdirectories (concat my-emacs-path "/"))
	      (zzq-subdirectories (concat my-emacs-path "el-get/"))
	      load-path))
(add-to-list 'load-path (concat my-emacs-path "el-get/jdee/lisp"))
(add-to-list 'load-path (concat my-emacs-path "settings/"))

;;=====私人信息,if you are not author please comment this line
(load-file (concat my-emacs-path "conf/projects-conf.el")) ;;porjects
;; 设置 custom-file 可以让用 M-x customize 这样定义的变量和 Face 写入到
;; 这个文件中
(setq custom-file (concat my-emacs-path "myinfo.el"))
;;=====end of 私人信息

(require 'custom-variables)
(require 'misc-funcs)
(require 'custom-settings)
(require 'keybindings)

;;========调用公用模块
(autoload 'fvwm-mode "fvwm-mode" nil t)
(autoload 'regex-tool "regex-tool" nil t)
(require 'cc-mode)
(require 'ido)
(require 'ange-ftp) ;req by tramp for ftp protocol
(require 'tramp)
(require 'ange-ftp) ;req by tramp for ftp protocol
(fmakunbound 'git-status)   ; Possibly remove Debian's autoloaded version
(require 'git-emacs-autoloads)
(autoload 'git-status "git-status"
  "Launch git-emacs's status mode on the specified directory." t)
(require 'uniquify) ;to identified same name buffer
(require 'volume)
(require 'unicad)
(require 'doxymacs)

;;(require 'tabbar)
;; (require 'color-moccur)
;; (require 'xcscope)
;; (autoload 'senator-try-expand-semantic "senator")
;; (autoload 'two-mode-mode "two mode mode")
;; (require 'ede)
;; (require 'ecb)
;;========END

;; ======== el-get 
;; el-get to manage the packages
(autoload 'el-get-install "el-get-conf" nil t)
(autoload 'el-get-update "el-get-conf" nil t)
(autoload 'el-get-remove "el-get-conf" nil t)
;; ======= END

;;=========ibuffer
(setq ibuffer-default-sorting-mode 'major-mode)
(global-set-key (kbd "\C-x \C-b") 'ibuffer-other-window)

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
;; (add-hook 'speedbar-load-hook
;;        (lambda ()
;;          (require 'semantic-sb))) ;;semantic支持

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

(require 'template-conf)

;;===========grep配置
(add-hook 'grep-mode-hook
          (lambda()
            (require 'grep-edit)))


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
(when (and (locate-library "auctex")
	   (locate-library "tex-site")
	   (locate-library "preview-latex"))
  (load "auctex.el" nil t t)
  (load "preview-latex.el" nil t t)
  (autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
  (autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
  (add-hook 'TeX-mode-hook
            (lambda()
              (require 'auctex-conf))))

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


;;========ido 模式
(require 'ido)
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
(autoload 'w3m "w3m" nil t)

(add-hook 'w3m-mode-hook
          (lambda()
            (require 'w3m-conf)))


;;**************** 编辑模式****************
;;=========c/c++模式
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'magic-fallback-mode-alist
	     '(buffer-standard-include-p . c++-mode))
;; (add-hook 'c-mode-common-hook
;;           (lambda()
;; 	    (require 'cpp-conf)
;; 	    (setup-c-base-mode)))
(load-conf-file-and-setup 'c-mode-common-hook 'cpp-conf setup-c-base-mode)
;;==========END

;;==========Java 模式
(autoload 'jde-mode "jde" nil t)
(setq auto-mode-alist (rassq-delete-all 'java-mode auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.java\\'" . jde-mode))
(load-conf-file-and-setup 'jde-mode-hook 'java-conf setup-java-mode)
;;==========END

;;==========Python 模式
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(load-conf-file-and-setup 'python-mode-hook 'python-conf setup-python-mode)
;;==========END

;;=========Ruby 模式
(autoload 'rhtml-mode "ruby-conf")
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)
                ("Rakefile$" . ruby-mode)
                ("\\.rhtml$" . rhtml-mode)
                ("\\.html\\.erb$" . rhtml-mode))
              auto-mode-alist))
(setq interpreter-mode-alist
      (append '(("ruby" . ruby-mode))
              interpreter-mode-alist))
(modify-coding-system-alist 'file "\\.rb$" 'utf-8)
(modify-coding-system-alist 'file "\\.rhtml$" 'utf-8)
(load-conf-file-and-setup 'ruby-mode-hook 'ruby-conf setup-ruby-mode)
;;==========END

;;==========ELisp 模式
(load-conf-file-and-setup 'emacs-lisp-mode-hook 'elisp-conf setup-emacs-lisp-mode setup-emacs-lisp-buffer)
;; (macroexpand '(load-conf-file-and-setup 'emacs-lisp-mode-hook 'elisp-conf setup-emacs-list-mode))
;;==========END

;;=========nxhtml
(load "~/.emacs.d/el-get/nxhtml/autostart.el")
(autoload 'zzq-html-mode "xhtml-conf" nil t)
(autoload 'zzq-phtml-mode "xhtml-conf" nil t)
(autoload 'common-smart-snippets-setup "smart-snippets-conf" nil t)
(add-to-list 'auto-mode-alist
             '("\\.html$" . zzq-html-mode))
(add-to-list 'auto-mode-alist
             '("\\.php$" . zzq-phtml-mode))

(add-hook 'css-mode-hook
          (lambda()
            (require 'xhtml-conf)
            ;; (require 'smart-snippets-conf)
            (hexcolour-add-to-font-lock)
	    (common-smart-snippets-setup css-mode-map css-mode-abbrev-table)))



;;========JavaScript 模式
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(defvar js2-mode-abbrev-table nil
  "Abbrev table in use in `js2-mode' buffers.")
(define-abbrev-table 'js2-mode-abbrev-table ())
(add-hook 'js2-mode-hook
          (lambda ()
            (setq js2-highlight-level 3)
            (define-key js2-mode-map (kbd "C-c C-e") 'js2-next-error)
            (define-key js2-mode-map "\r" 'newline-and-indent)

            (define-key js2-mode-map (kbd "C-c C-d") 'js2-mode-hide-element)))


;;=========SQL模式
(autoload 'sql-mode "sql-mode" "SQL Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.sql$" . sql-mode)
                ("\\.tbl$" . sql-mode)
                ("\\.sp$"  . sql-mode))
              auto-mode-alist))
(defun setup-sql-modes ()
  (require 'sql-completion)
  (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
  (sql-mysql-completion-init))
(add-hook 'sql-interactive-mode-hook
          'setup-sql-modes)
(add-hook 'sql-mode-hook
          'setup-sql-modes)

;;==========YAML 模式
(autoload 'yaml-mode "yaml-mode.el" nil t)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;;=========Shell 模式
(require 'shell-completion)
(require 'shell-history)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(modify-coding-system-alist 'file "\\.sh$" 'gb18030)
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

(define-auto-insert 'sh-mode '(nil "#!/usr/bin/env bash\n\n"))
(add-hook 'find-file-hooks 'auto-insert)


;; make the shell mode highlight
(setq comint-prompt-read-only t) ;; to make the the shell prompt readonly


;;========lftp
;; If you want use with lftp, put this to .emacs
(when (file-readable-p "~/.lftp/bookmarks")
  (defvar my-lftp-sites (shell-completion-get-file-column "~/.lftp/bookmarks" 0 "[ \t]+"))
  (add-to-list 'shell-completion-options-alist
	       '("lftp" my-lftp-sites))
  (add-to-list 'shell-completion-prog-cmdopt-alist
	       '("lftp" ("help" "open" "get" "mirror") ("open" my-lftp-sites))))

;;==========weblogger
;; (setq weblogger-entry-mode-hook 'html-mode)
(autoload 'weblogger-start-entry "weblogger" nil t)
(global-set-key "\C-cbs" 'weblogger-start-entry)


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
(when (locate-library "yasnippet")
  (require 'yasnippet)
  (yas/initialize)
  (setq yas/global-mode t)
  (setq yasnippet-dir
	(file-name-directory (locate-library "yasnippet")))
  (setq yasnippet-snippets-dir (concat yasnippet-dir "snippets"))
  (add-to-list 'yas/snippet-dirs "~/.emacs.d/snippets")
  (add-to-list 'yas/snippet-dirs yasnippet-snippets-dir)
  (yas/reload-all))
		
(autoload 'top "top-mode" nil t)

;;==========ac-mode
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(add-to-list 'ac-modes 'nxhtml-mode)
(add-to-list 'ac-modes 'nxml-mode)
;; (add-to-list 'ac-user-dictionary "foobar@example.com")
(defun ac-mode-setup ()
  (add-to-list 'ac-sources 'ac-source-yasnippet)
  (set-face-background 'ac-candidate-face "lightgray")
  (set-face-attribute 'ac-candidate-face nil
                      :underline "red")
  (set-face-background 'ac-selection-face "steelblue")
  (define-key ac-completing-map "\M-n" 'ac-next)
  (define-key ac-completing-map "\M-p" 'ac-previous)
  (define-key ac-mode-map (kbd "C-`") 'auto-complete)
  (ac-set-trigger-key "TAB")
  (setq ac-dwim t)
  (setq ac-auto-start 3)
  (ac-flyspell-workaround))
(ac-config-default)
(add-hook 'auto-complete-mode-hook 'ac-mode-setup)

;;========regex-tool
(setq regex-tool-backend (quote perl))
(setq regex-tool-new-frame t)
;; (set-face-attribute 'regex-tool-matched-face t
;; :background "black"
;; :foreground "Orange"
;; :weight bold)

;;========sh-mode
;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (autoload 'ansi-color-apply "ansi-color" nil t)
;; (require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(defun setup-sh-mode ()
  (define-key sh-mode-map "\r" 'newline-and-indent))
(add-hook 'sh-mode-hook 'setup-sh-mode)

;;========compilation mode support ansi-color
;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


;; ========ess
(load-conf-file-and-setup 'ess-mode-hook 'r-conf setup-r-mode)

;; ==========

(when (file-readable-p custom-file)
  (load custom-file))
;;========init.el end here
