;;; cedet-conf.el --- 

;; Copyright 2010 Zhiqiang Zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: cedet-conf.el,v 0.0 2010/02/04 02:58:17 zigler Exp $
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
;;   (require 'cedet-conf)

;;; Code:

(provide 'cedet-conf)
(eval-when-compile
  (require 'cl)
  (require 'cc-mode))

(require 'semantic/analyze/refs)

;; http://www.cnblogs.com/zfreay/archive/2012/01/08/2316441.html

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
;; Enable Semantic
(semantic-mode 1)
;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; * This enables the use of Exuberent ctags if you have it installed.
;; (semantic-load-enable-all-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

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

;; (setq semanticdb-project-roots
;; (list "/home/zigler/work/TOM64/Offline-code/Middleware/"))
(dolist (d load-path)
  (semantic-add-system-include d 'emacs-lisp-mode))

(defun semantic-key-bindings ()
  (local-set-key "\C-cxu" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cxr" 'semantic-symref)
  (local-set-key "\C-cxs" 'semantic-symref-symbol)
  (local-set-key "\C-cxj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cxc" 'semantic-ia-describe-class)
  (local-set-key "\C-cxm" 'semantic-ia-show-summary)
  (local-set-key "\C-cxd" 'semantic-ia-show-doc)
  (local-set-key "\C-cxi" 'semantic-decoration-include-visit)
  (local-set-key "\C-cxp" 'senator-previous-tag)
  (local-set-key "\C-cxn" 'senator-next-tag)
  (local-set-key "\C-cxa" 'senator-go-to-up-reference)
  (eval-after-load
      'cc-mode (
		lambda ()
		       (define-key c-mode-base-map (kbd "M-o") 'eassist-switch-h-cpp)
		       (define-key c-mode-base-map (kbd "M-m") 'eassist-list-methods)
		       (define-key c-mode-base-map (kbd "\C-cxo") 'semantic-analyze-proto-impl-toggle))))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; cedet-conf.el ends here
