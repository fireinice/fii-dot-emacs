(require 'w3m-load)
(require 'mime-w3m)
;; download with wget
;; (require 'w3m-wget)
;;w3m default browser
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
;; (global-set-key "\C-xm" 'browse-url-at-point)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

;; env settings for w3m

(setq w3m-terminal-coding-system 'chinese-iso-8bit
      w3m-coding-system 'utf-8
      w3m-language 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8
      w3m-bookmark-file-coding-system 'utf-8
      w3m-default-coding-system 'utf-8

      w3m-use-cookies t
      w3m-cookie-accept-bad-cookies t
      w3m-use-mule-ucs t
      w3m-use-toolbar t
      w3m-use-cookies t
      w3m-display-inline-image t
      w3m-tab-width 8
      browse-url-netscape-program '"firefox"
      browse-url-browser-function 'w3m-browse-url)


;;(global-set-key "\C-xp" 'browse-url-at-point)
(global-set-key "\C-cww" 'w3m) 
(global-set-key "\C-cwt" 'w3m-dtree) 
(global-set-key "\C-cwj" 'webjump) 
;; (global-set-key "\C-cwz" 'w3m-namazu)

;;w3m-namazu
;; (setq w3m-namazu-default-index "~/namazu-index")

;;w3m homepage
(setq w3m-home-page "http://www.google.com")

;;webjump sites
(setq webjump-sites
      '(("pylib" .  "http://docs.python.org/lib/genindex.html")
        ("pydoc" . "http://docs.python.org/index.html")
        ("delicious" . "http://del.icio.us/thiedlecques")
        ("emacswiki" . "http://www.emacswiki.org/cgi-bin/wiki/SiteMap")
        ("wikipedia" . "http://zh.wikipedia.org/")
        ("elispcode" . "http://www.emacswiki.org/cgi-bin/wiki/Cat%c3%a9gorieCode")
        ("elisp-reference-manual" . "http://www.gnu.org/software/emacs/elisp/html_node/index.html")
        ("developpez-faq" . "http://python.developpez.com/faq/")
        ))

;;recherche directe dans google

(defun search-word (word)
  (interactive "sGoogleSearch: ")
  (browse-url (concat "http://www.google.com/search?hl=fr&ie=ISO-8859-1&q=" word)))
(global-set-key "\C-cws" 'search-word)

;; search gmane
(defun tv-search-gmane (query &optional group author)
  (interactive (list
                (read-from-minibuffer "Query: ")
                (completing-read "Group: "
                                 '("gmane.emacs.gnus.general"
                                   "gmane.emacs.gnus.cvs"
                                   "gmane.emacs.gnus.user"
                                   "gmane.emacs.help"
                                   "gmane.lisp.clisp.devel"
                                   "gmane.lisp.clisp.general"
                                   "gmane.lisp.emacs-cl"
                                   "gmane.linux.gentoo.devel"
                                   "gmane.linux.gentoo.user"
                                   "gmane.linux.gentoo.cvs"
                                   "gmane.emacs.planner.general"
                                   "gmane.emacs.muse.general"
                                   "gmane.emacs.dvc.devel")
                                 nil nil nil 'minibuffer-history)
                (read-from-minibuffer "Author: ")))
  (w3m-browse-url (concat "http://search.gmane.org/?query="
                          query
                          "&author="
                          author
                          "&group="
                          group
                          "&sort=relevance&DEFAULTOP=and&TOPDOC=80&xP=Zemac&xFILTERS=A"
                          author
                          "---A")))

;; (global-set-key (kbd "\C-c ws u") 'tv-search-gmane)

;; ;;bookmark in delicious
;; (defun /thierry-delicious-url ()
;;   "Post either the url under point or the url of the current w3m page to delicious."
;;   (interactive)
;;   (let ((w3m-async-exec nil))
;;     (if (thing-at-point-url-at-point)
;;         (unless (eq (current-buffer) (w3m-alive-p)) ;bookmark url at point if we are not in w3m
;;           (w3m-goto-url (thing-at-point-url-at-point))))
;;     (w3m-goto-url
;;      (concat "http://del.icio.us/my_nickname?"
;;              "url="    (w3m-url-encode-string w3m-current-url)
;;              "&title=" (w3m-url-encode-string w3m-current-title)))))
;; (define-key w3m-mode-map "\C-x\C-a" '/thierry-delicious-url) ;except offline url at point

;;fonction search dans emacswiki

;; (define-key w3m-mode-map "\C-c\C-c" 
;;   '(lambda ()
;;      (interactive)
;;      (if (member 'w3m-href-anchor (text-properties-at (point)))
;;          (w3m-view-this-url)
;;        (w3m-submit-form))))

;;w3m antenna
;; (autoload 'w3m-antenna "w3m-antenna" "Report changes of WEB sites." t)

(provide 'w3m-conf)
;;; .emacs-config-w3m.el ends here