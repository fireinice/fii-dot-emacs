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
	(:name pylookup
               :type git
               :url "http://github.com/tsgates/pylookup.git")
	(:name jdee
               :type http-tar
	       :options "xjf"
               :url "http://downloads.sourceforge.net/project/jdee/jdee/2.4.1/jdee-bin-2.4.1.tar.bz2")
	))
(el-get 'sync 'fvwm-mode 'moccur-edit 'nxhtml 'pylookup 'sql 'unicad 'grep-edit 'auto-complete-java)
