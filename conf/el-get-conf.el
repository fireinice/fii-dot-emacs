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
      '((:name cedet
               :type cvs
	       :module "cedet"
	       :url ":pserver:anonymous@cedet.cvs.sourceforge.net:/cvsroot/cedet"
	       :options "login"
               :build ("make clean-all" "make"))
	(:name ecb
	       :type cvs
	       :module "ecb"
	       :url ":pserver:anonymous@ecb.cvs.sourceforge.net:/cvsroot/ecb"
	       :options "login"
	       :info "info-help"
               :build ("make"))
	(:name fvwm-mode
               :type http
               :url "http://www.lair.be/files/fvwm/fvwm-mode/fvwm-mode.el")
	(:name paredit
               :type http
               :url "http://mumble.net/~campbell/emacs/paredit.el")
	(:name auto-complete
	       :type git
               :url "http://cx4a.org/repo/auto-complete.git"
	       :build ("make"))
	(:name volume
	       :type git
	       :url "http://github.com/dbrock/volume-el.git")
	;; rails
	(:name rspec-mode
	       ;; require el-expectations
	       :type git
	       :url "http://github.com/pezra/rspec-mode.git")
	(:name rails-mode
	       ;; require behave(outside) require clojure
	       :type git
	       :url "http://github.com/remvee/emacs-rails.git")
	(:name slime
	       :type apt-get)
	(:name el-expectations
               :type http
               :url "http://www.emacswiki.org/emacs/download/el-expectations.el")
	;; html
	(:name zencoding
	       ;; require noweb
	       :type git
	       :url "http://github.com/chrisdone/zencoding.git"
	       :build ("make"))
	(:name noweb
	       :type apt-get)
	;; python
	(:name pylookup
	       :type git
	       :url "http://github.com/tsgates/pylookup.git")
	(:name el-get
	       :type git
	       :url "http://github.com/dimitri/el-get.git")
	;; java
	(:name jdee
	       ;; require elib bsh
	       :type git-svn
	       :url "http://jdee.svn.sourceforge.net/svnroot/jdee/trunk/jdee")
	(:name bsh
	       :type apt-get)
	(:name elib
	       :type apt-get)
	(:name android-mode
	       :type git
	       :url "git://github.com/remvee/android-mode.git")))

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

