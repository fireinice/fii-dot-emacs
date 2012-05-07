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
(setenv "JAVA_HOME" "/usr/lib/jvm/java-6-sun/")
(setenv "CLASSPATH" ".")

(require 'cedet-conf)
;; (require 'smart-snippets-conf)
(defun setup-java-mode ()
  (autoload 'android-mode "android-mode" nil t)
  (setq c-basic-offset 2)
  (jde-mode)
  (setq jde-web-browser "firefox")
  (setq jde-doc-dir "/usr/lib/jvm/java-6-sun/docs")
  (setq jde-compiler (quote ("javac" "")))
  (setq jde-enable-abbrev-mode t)
  (local-set-key [(control return)] 'jde-complete)
  (local-set-key [(shift return)] 'jde-complete-minibuf)
  (local-set-key [(meta return)] 'jde-complete-in-line))

;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; java-conf.el ends here
