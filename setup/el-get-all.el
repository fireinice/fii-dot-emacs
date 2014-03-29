(eval-when-compile
  (require 'cl))
(require 'el-get)
(require 'el-get-recipes)
;; (el-get-emacswiki-refresh "~/.emacs.d/el-get/el-get/recipes/emacswiki" t)
(el-get-read-all-recipes)
(setq el-get-sources
      '(
	(:name template
               :type http-tar
               :url "http://ncu.dl.sourceforge.net/project/emacs-template/template/3.1/template-3.1.tar.gz")
	(:name fvwm-mode
               :type http
               :url "http://www.lair.be/files/fvwm/fvwm-mode/fvwm-mode.el")))
(el-get 'sync 'fvwm-mode 'moccur-edit 'pylookup 'unicad 'grep-edit 'top-mode 'shell-completion 'unicad)
;; (el-get 'sync 'nxhtml)
