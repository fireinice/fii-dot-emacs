;;; el-get-conf.el ---

;; Copyright 2010 zhiqiang.zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: el-get-conf.el,v 0.0 2010/08/10 09:09:01 zigler Exp $
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
;;   (require 'el-get-conf)

;;; Code:

(provide 'el-get-conf)
(eval-when-compile
  (require 'cl))
(require 'el-get)

(setq el-get-sources
      '((:name el-get
               :type http
               :url "http://www.emacswiki.org/emacs/download/el-get.el"
               :build emacs)
	(:name fvwm-mode
               :type http
               :url "http://www.lair.be/files/fvwm/fvwm-mode/fvwm-mode.el"
               :build emacs)
	(:name auto-complete
	       :type git
               :url "http://cx4a.org/repo/auto-complete.git"
               :build ("make"))
	)
      )
(el-get)
;; (setq el-get-sources
;;       '((:name bbdb
;;             :type git
;;             :url "git://github.com/barak/BBDB.git"
;;             :load-path ("./lisp" "./bits")
;;             :info "texinfo"
;;             :build ("./configure" "make"))

;;      (:name magit
;;             :type git
;;             :url "http://github.com/philjackson/magit.git"
;;             :info "."
;;             :build ("./autogen.sh" "./configure" "make"))

;;      (:name vkill
;;             :type http
;;             :url "http://www.splode.com/~friedman/software/emacs-lisp/src/vkill.el"
;;             :features vkill)

;;      (:name yasnippet
;;             :type git-svn
;;             :url "http://yasnippet.googlecode.com/svn/trunk/")

;;      (:name asciidoc         :type elpa)
;;      (:name dictionary-el    :type apt-get)))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; el-get-conf.el ends here

