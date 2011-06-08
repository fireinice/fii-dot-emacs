(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
        ;; check bzr
        yasnippet
        (:name smart-compile
               :type http
               :url "http://sourceforge.jp/projects/macwiki/svn/view/zenitani/elisp/smart-compile.el?view=co&root=macwiki"
               :localname "smart-compile.el"
               )
	(:name flymake-cursor
               :type http
               :url "http://paste.lisp.org/display/60617,1/raw"
               :localname "flymake-cursor.el")
	(:name template
               :type http-tar
               :url "http://ncu.dl.sourceforge.net/project/emacs-template/template/3.1/template-3.1.tar.gz")
        (:name flymake-shell
               :type git
               :url "https://github.com/nyuhuhuu/flymake-shell.git")))
(el-get 'wait)
