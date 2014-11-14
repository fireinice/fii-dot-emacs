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

;;====初始化加载路径
;;add all subdirectories into the load-path except start with dot
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

(setq load-path
      (append (zzq-subdirectories (concat my-emacs-path "/"))
              (zzq-subdirectories (concat my-emacs-path "el-get/"))
              load-path))
;; (add-to-list 'load-path (concat my-emacs-path "jdee/lisp"))
(add-to-list 'load-path (concat my-emacs-path "settings/"))
;;====end of 初始化加载路径

;;=====加载自定义函数及配置
(require 'custom-variables)
(require 'misc-funcs)
(require 'custom-settings)
(require 'keybindings)
;;=====end of 加载自定义函数及配置

;;=====私人信息,if you are not author please comment this line
;; ***FIXME*** need review https://github.com/mattkeller/mk-project
(load-file (concat my-emacs-path "conf/projects-conf.el")) ;;porjects
;; 设置 custom-file 可以让用 M-x customize 这样定义的变量和 Face 写入到
;; 这个文件中
(setq custom-file (concat my-emacs-path "myinfo.el"))
;;=====end of 私人信息

;;====elpa
(unless (try-require 'package)
  (lambda ()
    (message "use old package")
    (load
     (expand-file-name (concat my-emacs-path "/elpa/package/package.el")))))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
;;====end of elpa

;;========调用公用模块
(require 'ido)
(require 'uniquify) ;to identified same name buffer
(require 'cc-mode)
(require 'ange-ftp) ;req by tramp for ftp protocol
(require 'tramp)
(require 'xcscope)

(autoload 'fvwm-mode "fvwm-mode" nil t)
(autoload 'regex-tool "regex-tool" nil t)

(try-require 'volume)
(try-require 'unicad)
(try-require 'doxymacs)
(try-require 'moccur-edit) ;; ***FIXME*** need a fix here not install yet
(if (try-require 'autopair)
    (progn
      (autopair-global-mode)
      (setq autopair-autowrap t)))
(if (try-require 'highlight-chars)
    (progn
      (add-hook 'font-lock-mode-hook 'hc-dont-highlight-tabs)
      (add-hook 'font-lock-mode-hook 'hc-dont-highlight-trailing-whitespace)))
(require 'flymake-conf)
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
;;=====END

;;=========speedbar
(autoload 'speedbar-frame-mode "speedbar" "Popup a speedbar frame" t)
(autoload 'speedbar-get-focus "speedbar" "Jump to speedbar frame" t)
(autoload 'sr-speedbar-toggle "sr-speedbar")
;; w3 link listings
(autoload 'w3-speedbar-buttons "sb-w3" "s3 specific speedbar button generator.")
(global-set-key [(f4)] 'sr-speedbar-toggle)
;;=====speedbar

;; Texinfo fancy chapter tags
;; (add-hook 'texinfo-mode-hook (lambda () (require 'sb-texinfo)))
;; HTML fancy chapter tags
;; (add-hook 'speedbar-load-hook
;;        (lambda ()
;;          (require 'semantic-sb))) ;;semantic支持

;;=========yasnipet mode
(when (locate-library "yasnippet")
  (require 'yasnippet)
  (setq yasnippet-dir
        (file-name-directory (locate-library "yasnippet")))
  (setq yasnippet-snippets-dir (concat yasnippet-dir "snippets"))
  (add-to-list 'yas/snippet-dirs "~/.emacs.d/snippets")
  (add-to-list 'yas/snippet-dirs yasnippet-snippets-dir)
  (yas-reload-all)
  (yas-global-mode t))
;;===== END of Yasnipet

(get 'cua-inhibit-cua-keys 'permanent-local)
(when
    (and
     (>= emacs-major-version 24)
     (>= emacs-minor-version 2))
  (eval-after-load "mumamo"
    '(progn
       (put 'cua-inhibit-cua-keys 'permanent-local nil)
       (setq mumamo-per-buffer-local-vars
             (delq 'buffer-file-name mumamo-per-buffer-local-vars)))))
;;==========ac-mode
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
(add-to-list 'ac-modes 'nxml-mode)
(add-to-list 'ac-modes 'jde-mode)
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

(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)
;; full screen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

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
(global-set-key (kbd "C-9") 'smart-compile)
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

(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;;w3m default browser
;; (setq browse-url-browser-function 'w3m-browse-url-other-window)

;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)
(add-hook 'w3m-mode-hook
          (lambda()
            (require 'w3m-conf)))


;;**************** 编辑模式****************
;;=========c/c++模式
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(load-conf-file-and-setup 'c-mode-common-hook 'cpp-conf setup-c-base-mode setup-c-base-buffer)
;;==========END

;;==========Java 模式
;; jde-mode need cedet defined
;; (load-file "~/.emacs.d/el-get/cedet/common/cedet.el")
;; (autoload 'jde-mode "jde" nil t)
;; (setq auto-mode-alist (rassq-delete-all 'java-mode auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . jde-mode))
;; (load-conf-file-and-setup 'jde-mode-hook 'java-conf setup-java-mode)
;; (require 'ede-project-conf)
(autoload 'start-eclimd "eclimd" nil t)
(modify-coding-system-alist 'file "\\.java$" 'utf-8-unix)
(load-conf-file-and-setup 'java-mode-hook 'java-conf setup-java-mode setup-java-buffer)
;;==========END

;;==========Python 模式
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(setq interpreter-mode-alist
      (cons '("python" . python-mode)
            interpreter-mode-alist))
(load-conf-file-and-setup 'python-mode-hook 'python-conf setup-python-mode setup-python-buffer)
;;==========END

;;=========HTML 模式
;;
;; (require 'html-conf)
;; What files to invoke the new html-mode for?
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.[sj]?html?\\'" . html-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . html-mode))
;; ;;
;; ;; What features should be turned on in this html-mode?
;; ;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-js))
;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil embedded-css))
;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil fancy-html))
;;=========END

;;=========Ruby 模式
(try-require 'rspec-mode)
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
(load-conf-file-and-setup 'ruby-mode-hook 'ruby-conf setup-ruby-mode setup-ruby-buffer)
;;==========END


;;==========ELisp 模式
(load-conf-file-and-setup 'emacs-lisp-mode-hook 'elisp-conf setup-emacs-lisp-mode setup-emacs-lisp-buffer)
;; (macroexpand '(load-conf-file-and-setup 'emacs-lisp-mode-hook 'elisp-conf setup-emacs-list-mode))
;;==========END

(add-hook 'php-mode-hook
          (lambda ()
            (c-set-offset 'arglist-cont 0)
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'case-label 2)
            (c-set-offset 'arglist-close 0)
            (setq c-basic-offset 4)
            (setq indent-tabs-mode nil)
            (flymake-php-load)
            (php-eldoc-enable)
            (set (make-local-variable 'browse-url-browser-function) 'w3m-browse-url)))

(add-hook 'css-mode-hook
          (lambda()
            (require 'xhtml-conf)
            ;; (require 'smart-snippets-conf)
            (hexcolour-add-to-font-lock)))



;;========JavaScript 模式
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsm\\'" . js2-mode))
(defvar js2-mode-abbrev-table nil
  "Abbrev table in use in `js2-mode' buffers.")
(define-abbrev-table 'js2-mode-abbrev-table ())
(add-hook 'js2-mode-hook
          (lambda ()
            ;; (autoload 'ac-define-source "auto-complete")
            ;; (require 'ac-js2)
            (require 'smart-snippets-conf)
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


;;=========Shell Script 模式
(require 'shell-completion)
(add-hook 'sh-mode-hook 'flymake-shell-load)
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

;;===========shell Buffer 模式
;; make the shell mode highlight
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
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
;; =======org mode end here======================

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

;; ========mediawiki
(autoload 'mediawiki-site "mediawiki" nil t)

;; ==========
(when (file-readable-p custom-file)
  (load custom-file))
;;========init.el end here
