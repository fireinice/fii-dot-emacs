(eval-when-compile
  (require 'cl))
(require 'el-get)
;; (setq package-user-dir "el-get")

(setq el-get-sources
      '(
	php-mode
	weblogger-el
	))
(el-get 'wait)

