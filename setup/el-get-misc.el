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
	auctex
	;; **FIXME** require autoconf, we need a check here
	))
(el-get 'wait)
