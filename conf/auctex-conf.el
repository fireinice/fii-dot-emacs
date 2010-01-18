(provide 'auctex-conf)
(require 'tex-site)
;; (require 'preview-latex)
(autoload 'LaTeX-preview-setup "preview")
(autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
(autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
(autoload 'reftex-citation "reftex-cite" "Make citation" nil)
(autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)

;; TeX mode
(setq TeX-newline-function 'newline-and-indent) ;;回车时自动缩进
(setq TeX-electric-escape t)
;; (setq TeX-auto-untabify t) ;; 不使用 TAB字符缩进
(setq TeX-auto-save nil)
;; for multi-file-documents, refer to
;; http://lists.gnu.org/archive/html/auctex/2005-05/msg00014.html
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
;; (add-hook 'TeX-mode-hook
;;           (lambda ()
	    (turn-on-auto-fill)
	    (setq reftex-plug-into-AUCTeX t)
            (turn-on-reftex)
;; ))

;;LaTeX-mode
(setq LaTeX-math-mode t)
(setq LaTeX-document-regexp "document\\|CJK\\*?")  ;; CJK 环境中不缩进
;; (add-hook 'LaTeX-mode-hook #'LaTeX-preview-setup)
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (turn-on-cdlatex) ; with AUCTeX LaTeX mode
	    (turn-on-auto-fill)
	    (turn-on-reftex)
	    (LaTeX-preview-setup)
	    (define-key LaTeX-mode-map
	      (kbd "C-c -") 'cdlatex-item);; CDLaTeX conflicts key bindings [C-c -] with RefTeX.
	                                  ;; Beacause [C-c =] equals to [C-c -] in RefTeX,
	                                  ;;so I rebind it to CDLaTeX.
;; 	    (define-key LaTeX-mode-map [(tab)]  'cdlatex-tab)
	    (outline-minor-mode)))

(setq (make-local-variable 'fill-column) 72) ;;与A4纸一行字数相同
;;reftex-mode
;;把beamer的frametitle也放入reftex目录缓冲中，但需要把\frametitle写在行首
(setq reftex-section-levels
      '(("part" . 0) ("chapter" . 1) ("section" . 2) ("subsection" . 3)
        ("frametitle" . 4) ("subsubsection" . 4) ("paragraph" . 5)
        ("subparagraph" . 6) ("addchap" . -1) ("addsec" . -2)))
(setq reftex-revisit-to-follow t
      reftex-auto-recenter-toc t
      reftex-plug-into-AUCTeX t)

;;bibtex
(setq bibtex-autokey-names 1
      bibtex-autokey-names-stretch 1
      bibtex-autokey-name-separator "-"
      bibtex-autokey-additional-names "-et.al."
      bibtex-autokey-name-case-convert 'identity
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-titlewords-stretch 0
      bibtex-autokey-titlewords 0
      bibtex-maintain-sorted-entries 'plain
      bibtex-entry-format '(opts-or-alts numerical-fields))

(add-hook 'TeXinfo-mode-hook 'outline-minor-mode)  

;;beamer
(eval-after-load "tex"
  '(progn
     (TeX-global-PDF-mode t)))

(eval-after-load "tex"
  '(TeX-add-style-hook "beamer" 'my-beamer-mode))

(setq TeX-region "regionsje")
(defun my-beamer-mode ()
  "My adds on for when in beamer."

  ;; when in a Beamer file I want to use pdflatex.
  ;; Thanks to Ralf Angeli for this.
  (TeX-PDF-mode 1)                      ;turn on PDF mode.

  ;; Tell reftex to treat \lecture and \frametitle as section commands
  ;; so that C-c = gives you a list of frametitles and you can easily
  ;; navigate around the list of frames.
  ;; If you change reftex-section-level, reftex needs to be reset so that
  ;; reftex-section-regexp is correctly remade.
  (require 'reftex)
  (set (make-local-variable 'reftex-section-levels)
       '(("lecture" . 1) ("frametitle" . 2)))
  (reftex-reset-mode)

  ;; add some extra functions.
  (define-key LaTeX-mode-map "\C-cf" 'beamer-template-frame)
  (define-key LaTeX-mode-map "\C-\M-x" 'tex-frame)
)

(defun tex-frame ()
  "Run pdflatex on current frame.  
Frame must be declared as an environment."
  (interactive)
  (let (beg)
    (save-excursion
      (search-backward "\\begin{frame}")
      (setq beg (point))
      (forward-char 1)
      (LaTeX-find-matching-end)
      (TeX-pin-region beg (point))
      (letf (( (symbol-function 'TeX-command-query) (lambda (x) "LaTeX")))
        (TeX-command-region))
        )
      ))


(defun beamer-template-frame ()
  "Create a simple template and move point to after \\frametitle."
  (interactive)
  (LaTeX-environment-menu "frame")
  (insert "\\frametitle{}")
  (backward-char 1))