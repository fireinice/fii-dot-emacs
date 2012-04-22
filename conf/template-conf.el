;;; template-conf.el --- 

;; Copyright 2012 Zigler Zhang
;;
;; Author: zhzhqiang@gmail.com
;; Version: $Id: template.el,v 0.0 2012/04/18 00:31:57 zigler Exp $
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
;;   (require 'template-conf)

;;; Code:

(provide 'template-conf)
(eval-when-compile
  (require 'cl))

;;=========template 设置
(require 'template)

(template-initialize)

;; compatible with ido
(dolist (cmd '(ido-select-text ido-magic-forward-char
                               ido-exit-minibuffer))
  (add-to-list 'template-find-file-commands cmd))

(add-to-list 'template-default-directories "~/.emacs.d/tpl")



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; template.el ends here
