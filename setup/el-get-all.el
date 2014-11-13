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
               :url "http://www.lair.be/files/fvwm/fvwm-mode/fvwm-mode.el")
        (:name pylookup
               :type git
               :url "http://github.com/tsgates/pylookup.git")
        (:name jdee
               :type http-tar
               :options "xjf"
               :url "http://downloads.sourceforge.net/project/jdee/jdee/2.4.1/jdee-bin-2.4.1.tar.bz2")
        (:name shell-completion
               :type emacswiki
               :description "provides tab completion for shell commands"
               :website "https://raw.github.com/emacsmirror/emacswiki.org/master/shell-completion.el")))
(el-get 'sync 'moccur-edit 'nxhtml 'pylookup 'unicad 'grep-edit 'auto-complete-java 'shell-completion)
