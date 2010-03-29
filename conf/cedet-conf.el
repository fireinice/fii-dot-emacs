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
  (require 'cl))
;; http://www.linuxforum.net/forum/showflat.php?Board=vim&Number=687565
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; http://github.com/alexott/emacs-configs/blob/master/rc/emacs-rc-cedet.el
(load-file "~/.emacs.d/cedet/common/cedet.el")
(require 'semantic-ia)
(require 'ede)
(global-ede-mode t)

;; (ede-minor-mode t)
;; Enable EDE for a pre-existing C++ project
(ede-cpp-root-project
 "TOM64"
 :name "TOM64"
 :file "~/work/TOM64/Offline-code/Middleware/Makefile"
 :include-path '("/"
		 "/blob"
		 "/TFC")
 
 )

;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)

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

(setq semanticdb-project-roots
      (list "/home/zigler/work/TOM64/Offline-code/Middleware/"))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; cedet-conf.el ends here
