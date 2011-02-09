(eval-when-compile
  (require 'cl))
(require 'el-get)
;; (setq package-user-dir "el-get")

(setq el-get-sources
      '(
        ;; (:name slime
        ;;        :type elpa)
        ;; clojure-mode
        ;; (:name behave
        ;;        ;; require clojure-mode
        ;;        ;; require
        ;;        :type git
        ;;        :url "https://github.com/technomancy/dotfiles.git")
        ;; el-expectations
        (:name ruby-mode
               :type svn
               :url "http://svn.ruby-lang.org/repos/ruby/trunk/misc"
               :features ruby-mode
               )
        rspec-mode
        ;; depend on ruby-mode
        (:name rails-mode
               :type git
               :url "http://github.com/remvee/emacs-rails.git")
        rinari
        yari
        rvm))
(el-get 'sync)

