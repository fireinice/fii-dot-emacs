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

	))
(el-get 'wait)
