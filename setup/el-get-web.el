(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	nxhtml
	(:name zencoding
	       ;; require noweb
	       :type git
	       :url "http://github.com/chrisdone/zencoding.git"
	       :build ("make"))
	(:name geben
	       :type svn
	       :url "http://geben-on-emacs.googlecode.com/svn/trunk/"
	       :features "geben"
	       :build ("make")
	       )
	))
(el-get 'wait)
