(eval-when-compile
  (require 'cl))
(require 'el-get)

(setq el-get-sources
      '(
	;; rails
	;; (:name rspec-mode
	;;        ;; require el-expectations
	;;        :type git
	;;        :url "http://github.com/pezra/rspec-mode.git")
	;; (:name rails-mode
	;;        ;; require behave(outside) require clojure
	;;        :type git
	;;        :url "http://github.com/remvee/emacs-rails.git")
	;; (:name el-expectations
        ;;        :type http
        ;;        :url "http://www.emacswiki.org/emacs/download/el-expectations.el")
	slime
	clojure-mode
	(:name behave
	       ;; require el-expectations
	       :type git
	       :url "https://github.com/technomancy/dotfiles.git")))
(el-get 'sync)

