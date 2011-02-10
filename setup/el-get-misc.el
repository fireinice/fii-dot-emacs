(require 'el-get)

(setq el-get-sources
      '((:name fvwm-mode
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
	(:name unicad
	       :type svn
	       :url "http://unicad.googlecode.com/svn/trunk/lisp"
	       :features "unicad")
	;; auctex
	(:name grep-edit
	       :type emacswiki)
	apel ;;required by flim
	flim ;;required by w3m
	(:name w3m
	       :type cvs
	       :url ":pserver:anonymous@cvs.namazu.org:/storage/cvsroot"
	       :module "emacs-w3m"
	       :build ("autoconf" "./configure" "make"))))
(el-get 'sync)










