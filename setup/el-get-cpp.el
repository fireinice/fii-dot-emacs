(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	;; check bzr
	cedet
	(:name ecb
	       :type http-tar
	       :options ("xzf")
	       :url "http://ecb.sourceforge.net/cvs_snapshots/ecb.tar.gz"
	       :load-path ("ecb-snap")
	       ))
(el-get 'wait)
