(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	(:name template
               :type http-tar
               :url "http://ncu.dl.sourceforge.net/project/emacs-template/template/3.1/template-3.1.tar.gz")
	(:name fvwm-mode
               :type http
               :url "http://www.lair.be/files/fvwm/fvwm-mode/fvwm-mode.el")
	))
(el-get 'sync 'fvwm-mode 'moccur-edit 'nxhtml 'pylookup 'sql 'unicad)
