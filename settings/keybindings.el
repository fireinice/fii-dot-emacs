;;; keybindings.el --- 

;; Copyright 2012 Zigler Zhang
;;
;; Author: zhzhqiang@gmail.com
;; Version: $Id: keybindings.el,v 0.0 2012/04/18 00:27:09 zigler Exp $
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
;;   (require 'keybindings)

;;; Code:

(provide 'keybindings)
(eval-when-compile
  (require 'cl))

;;========基本函数绑定
(define-key minibuffer-local-must-match-map [(tab)] 'minibuffer-complete) ;;对M-x仍使用原样式
;; (add-hook 'magit-mode-hook
;;        (lambda()
;;          (define-key magit-mode-map [(tab)] 'magit-toggle-section)))
;;对info仍使用原样式
(define-key Info-mode-map [(tab)] 'Info-next-reference)
;; (global-set-key [(tab)] 'my-indent-or-complete)
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
;; (global-set-key (kbd "\C-cbp") 'tabbar-backward-group)
;; (global-set-key (kbd "\C-cbn") 'tabbar-forward-group)
;; (global-set-key (kbd "\C-cbj") 'tabbar-backward)
;; (global-set-key (kbd "\C-cbk") 'tabbar-forward)
(global-set-key (kbd "\C-crm")  'ska-point-to-register)
(global-set-key (kbd "\C-crj")  'ska-jump-to-register)
(global-set-key (kbd "\C-ccu")  'revert-buffer)
(global-set-key (kbd "\C-ccr")  'smart-run)
(global-set-key (kbd "\C-x %") 'kill-match-paren)
(global-set-key (kbd "\C-cvg")  'magit-status)
(global-set-key (kbd "\C-cvc")  'cvs-status)
(global-set-key (kbd "\C-cpl")  'project-load)
(global-set-key (kbd "\C-cpc")  'project-compile)
(global-set-key (kbd "\C-ccf")  'ffap)


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; keybindings.el ends here
