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
      '(
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
	(:name volume
	       :type git
	       :url "http://github.com/dbrock/volume-el.git")
	;; rails
	slime
	clojure-mode
	(:name behave
	       ;; require el-expectations
	       :type git
	       :url "https://github.com/technomancy/dotfiles.git")
	(:name rspec-mode
	       ;; require el-expectations
	       :type git
	       :url "http://github.com/pezra/rspec-mode.git")
	(:name rails-mode
	       ;; require behave(outside) require clojure
	       :type git
	       :url "http://github.com/remvee/emacs-rails.git")
	el-expectations
	;; html
	(:name nxhtml)
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
	(:name auto-complete-java
	       :type git
               :url "git://github.com/jixiuf/ajc-java-complete.git")
	(:name jdee
	       ;; require elib bsh
	       :type git-svn
	       :url "https://jdee.svn.sourceforge.net/svnroot/jdee")
	(:name bsh
	       :type apt-get)
	(:name elib
	       :type apt-get)
	(:name smart-compile
	       ;; should replace by modecompile?
	       :type http
	       :url "http://sourceforge.jp/projects/macwiki/svn/view/zenitani/elisp/smart-compile.el?view=co&revision=735&root=macwiki")
	(:name flymake-shell
	       :type git
	       :url "https://github.com/purcell/flymake-shell.git")))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; el-get-conf.el ends here

