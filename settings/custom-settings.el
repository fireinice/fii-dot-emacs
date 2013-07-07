;;; custom-settings.el --- 

;; Copyright 2012 Zigler Zhang
;;
;; Author: zhzhqiang@gmail.com
;; Version: $Id: custom-settings.el,v 0.0 2012/04/18 00:19:34 zigler Exp $
;; Keywords: 
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'custom-settings)

;;; Code:

(provide 'custom-settings)
(eval-when-compile
  (require 'cl)
  (require 'cc-mode))





;;=======基本设置 start
(server-start)
(setq major-mode 'text-mode)
(setq-default abbrev-mode t
              kill-whole-line t                         ; 在行首 C-k 时，同时删除该行。
              truncate-partial-width-windows nil)       ;;多窗时自动多行显示
(setq ps-multibyte-buffer 'bdf-font-except-latin)       ; 打印
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

;;将备份文件放至~/tmp下
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
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq use-file-dialog nil)

;;(tabbar-mode t) ; 显示tab标签
(setq inhibit-startup-message t)        ;禁用启动信息
;; WoMan 不打开新的 frame
(setq woman-use-own-frame nil)

;;(hs-minor-mode t)
;;设置标题栏
;; (setq frame-title-format "emacs@%b")

;; 修改默认的tramp方法为空，否则会出现ssh:sudo: unkown service错误，即把sudo作为参数传给ssh
;; (add-to-list 'tramp-default-method-alist
;;              '("\\`localhost\\'" "" "su"))
(setq tramp-default-method "")

;; 保证文件名相同的时候buffer名称是目录名+文件名
(setq uniquify-buffer-name-style 'forward)


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
;;            (lambda ()
;;              ;; (add-blank-in-chinese-and-english (point-at-bol) (point-at-eol))
;;              (do-auto-fill)))

;;=======End

;;========仅作用于X下

(when window-system
  (require 'icicles)
  ;; 设置前景，,背景色 list-colors-display看颜色
  (add-to-list 'default-frame-alist '(background-color . "grey25"))
  (add-to-list 'default-frame-alist '(foreground-color . "grey85"))
  (add-to-list 'default-frame-alist '(cursor-color . "red"))
  (autoload 'ecb-activate "ecb" nil t) ;;nox
  (setq x-select-enable-clipboard t) ;;使用剪切板
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
  (scroll-bar-mode -1))

(when (not window-system)
  (set-face-attribute 'font-lock-string-face nil :foreground "LightSalmon")
  (set-face-attribute 'font-lock-keyword-face nil :foreground "Cyan1")
  (set-face-attribute 'font-lock-constant-face nil :foreground "Aquamarine")
  (set-face-attribute 'font-lock-type-face nil :foreground "PaleGreen")
  (set-face-attribute 'font-lock-function-name-face nil :foreground "LightSkyBlue"))  
