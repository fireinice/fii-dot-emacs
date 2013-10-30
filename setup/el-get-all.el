(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	(:name template
               :type http-tar
               :url "http://ncu.dl.sourceforge.net/project/emacs-template/template/3.1/template-3.1.tar.gz")
	(:name fvwm-mode)
	(:name moccur-edit)
	(:name nxhtml)
	(:name pylookup)
	(:name sql)
	(:name unicad)
	))
(el-get 'wait)
