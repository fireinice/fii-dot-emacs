;;; java-conf.el ---

;; Copyright 2010 zhiqiang.zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: java-conf.el,v 0.0 2010/09/27 07:16:21 zigler Exp $
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
;;   (require 'java-conf)

;;; Code:
(provide 'java-conf)
(eval-when-compile
  (require 'cl))

(defun setup-java-mode ()
  (message "set java mode")
  (setq java-workspace "~/.eclipse/workspace")
  (require 'eclimd)
  (start-eclimd java-workspace)
  (require 'eclim)
  (require 'ac-emacs-eclim-source)
  (global-eclim-mode)
  (setq help-at-pt-display-when-idle t)
  (setq help-at-pt-timer-delay 0.1)
  (help-at-pt-set-timer)
  (setq emdroid-activity-creator "ActivityCreator.py")
  (setq emdroid-tools-dir "~/tools/lib/android-sdk-linux/tools/")
  (setq android-avd "test"
	android-mode-sdk-dir "~/tools/lib/android-sdk-linux/")
  ;; we need ecj compiler here more detail in jde-eclipse-compiler-server
  (message "set java mode done")
  
)

(defun setup-java-buffer ()
  (message "set java buffer")
  (setq c-basic-offset 2)
  (set (make-local-variable 'ac-sources)
       (delete-dups
	(append '(ac-source-emacs-eclim ac-source-yasnippet ac-source-semantic ac-source-words-in-same-mode-buffers)
		ac-sources)))
  (message "set java buffer done"))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################
;;; java-conf.el ends here
