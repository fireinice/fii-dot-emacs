(require 'cedet-conf)
;;http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html#sec6 for detail
(ede-cpp-root-project "resta"
		      :name "Resta of Dan"
		      :file "~/work/bd/dnsearch/resta/Makefile"
		      :include-path '("/src/include")
		      ;; :system-include-path '("~/exp/include")
		      ;; :spp-table '(("isUnix" . "")
				   ;; ("BOOST_TEST_DYN_LINK" . ""))
		      )
(provide 'cpp-projects)