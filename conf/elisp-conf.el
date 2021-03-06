;;; elisp-conf.el --- 

;; Copyright 2010 zhiqiang.zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: elisp-conf.el,v 0.0 2010/07/08 08:53:30 zigler Exp $
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
;;   (require 'elisp-conf)

;;; Code:
(provide 'elisp-conf)
(message "elisp-mode file load")

(eval-when-compile
  (require 'cl))
(require 'cedet-conf)
(require 'paredit)
(require 'custom-variables)
(defvar auto-compile-conf-list nil)

(defun el-after-save-hook ()
  (mapcar
   (lambda (file)
     (setq file (expand-file-name file))
     (when (string= file (buffer-file-name))
       (save-excursion (byte-compile-file file))))
   auto-compile-conf-list))


(defun setup-emacs-lisp-buffer ()
  (message "elisp-mode buffer setup")
  (turn-on-eldoc-mode)
  (paredit-mode t)
  (set (make-local-variable 'autopair-dont-activate) t)
  (autopair-mode -1)
  ;; fixme
  ;; (semantic-key-bindings)
  )


(defun setup-emacs-lisp-mode ()
  (message "elisp-mode mode setup")
  (dolist (dirname '("~/.emacs.d/" "~/.emacs.d/conf/" "~/.emacs.d/settings" ))
    (dolist (file-name (directory-files dirname t))
      (unless (file-directory-p file-name)
	(when (string=
	       (file-name-extension file-name)
	       "el")
	  (add-to-list 'auto-compile-conf-list file-name)))))
  (add-hook 'after-save-hook
	    'el-after-save-hook))


;; C-h f emacs-list-mode would tell the file load

;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################

;;; elisp-conf.el ends here

