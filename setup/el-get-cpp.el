(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	;; check bzr
	cedet
	ecb
	))
(el-get 'wait)
