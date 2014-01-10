
;; (add-hook 'java-mode-hook
;;           (lambda ()
;; 	    ;; (require 'semantic-edit)
;; 	    (require 'java-conf)))

;; (eval-after-load "java-conf"
;;   '(progn
;;      (setup-java-mode)))

;;========Hippie-Expand
;; (setq hippie-expand-try-functions-list
;; ;; (make-hippie-expand-function
;;  '(
;;      yas/hippie-try-expand
;;      try-complete-abbrev
;;      try-expand-dabbrev-visible
;;      try-expand-dabbrev
;;      try-expand-dabbrev-all-buffers
;;      try-expand-dabbrev-from-kill
;;      try-expand-list
;;      try-expand-list-all-buffers
;;      try-expand-line
;;         try-expand-line-all-buffers
;;         try-complete-file-name-partially
;;         try-complete-file-name
;;         try-complete-lisp-symbol-partially
;;         try-complete-lisp-symbol
;;         try-expand-whole-kill))
(nconc load-path
       (zzq-subdirectories "~/.emacs.d/"))

(dolist (file-name (directory-files "~/.emacs.d" t))
  (when (file-directory-p file-name)
    (unless
        (equal "."
               (substring
                (file-name-nondirectory file-name) 0 1))
      (add-to-list 'load-path file-name))))

;; ;;========php mode
;; (autoload 'php-mode "php-mode" "Major mode for editing php code." t)
;; (add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; (add-hook 'php-mode-hook 'setup-php-mode)

;; (autoload 'geben "geben" "PHP Debugger on Emacs" t)
;; (defun setup-php-mode ()
;;   (require 'w3m-conf)
;;   (local-set-key (kbd "<f1>") 'my-php-symbol-lookup)
;;   (gtags-mode t)
;;   ;; (setup-gtags-mode)
;;   ;; (set (make-local-variable 'c-basic-offset) 4)
;;   (setq tab-width 4
;;         indent-tabs-mode t)
;;   ;; (require 'auto-complete-etags)
;;   (require 'autocompletion-php-functions)
;;   (set (make-local-variable 'ac-sources)
;;        '(ac-source-yasnippet ac-source-php ac-source-gtags ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers)))

;; (defun my-php-symbol-lookup ()
;;   (interactive)
;;   (let (symbol (thing-at-point))
;;     (if (not symbol)
;;         (message "No symbol at point.")
;;       (browse-url
;;        (concat "http://php.net/manual-lookup.php?pattern="
;;                (symbol-name symbol))))))

;; (add-hook 'after-save-hook
;; 	  (lambda ()
;; 	    (mapcar
;; 	     (lambda (file)
;; 	       (setq file (expand-file-name file))
;; 	       (when (string= file (buffer-file-name))
;; 		 (save-excursion (byte-compile-file file))))
;; 	     '("~/.emacs.d/init.el" "~/.emacs.d/myinfo.el"
;; 	       "~/.emacs.d/conf/cpp-conf.el"))))

;;=========nxhtml
(autoload 'zzq-html-mode "xhtml-conf" nil t)
(autoload 'zzq-phtml-mode "xhtml-conf" nil t)
(autoload 'common-smart-snippets-setup "smart-snippets-conf" nil t)
(add-to-list 'auto-mode-alist
             '("\\.html$" . zzq-html-mode))
(add-to-list 'auto-mode-alist
             '("\\.php$" . zzq-phtml-mode))
;; (add-hook 'php-mode-hook ')
(add-to-list 'ac-modes 'nxhtml-mode)

;;;
;;; ac-source-rng-nxml
;;;
;;; usage:
;;;  (require 'nxml-mode)
;;;  (require 'ac-source-rng-nxml)
;;;  (add-hook 'nxml-mode-hook
;;;            (lambda ()
;;;              (make-local-variable ac-sources-prefix-function)
;;;              (setq
;;;               ac-sources-prefix-function 'ac-source-rng-nxml-prefix
;;;               ac-sources '(ac-source-rng-nxml))))

(load "~/.emacs.d/el-get/nxhtml/autostart.el")
(require 'smart-snippets-conf)
(require 'flymake-conf)
(defvar ac-source-rng-nxml-candidates nil)

(defadvice rng-complete-before-point (around
                                      ac-source-rng-nxml-complete-advice
                                      disable)
  (setq ad-return-value
        (or ac-source-rng-nxml-candidates
            (progn
              (setq ac-source-rng-nxml-candidates
                    (mapcar
                     (lambda (x) (cdr x))
                     rng-complete-target-names))
              nil))))

(defun ac-source-rng-nxml-do-complete ()
  (ad-enable-advice 'rng-complete-before-point
                    'around 'ac-source-rng-nxml-complete-advice)
  (ad-activate 'rng-complete-before-point)

  (rng-complete)

  (ad-disable-advice 'rng-complete-before-point
                     'around 'ac-source-rng-nxml-complete-advice)
  (ad-activate 'rng-complete-before-point))

(defun ac-source-rng-nxml-get-prefix (str)
  (and (string-match "^\\([^[:alpha:]]+\\)" str)
       (match-string-no-properties 1 str)))

(defvar ac-source-rng-nxml
  `((init
     . (lambda ()
         (setq ac-source-rng-nxml-candidates nil)
         (ac-source-rng-nxml-do-complete)))
    (candidates
     . (lambda ()
         (let* ((prefix (ac-source-rng-nxml-get-prefix ac-prefix))
                (kw (substring ac-prefix (length prefix)))
                (kwlen (length kw)))
           (loop for c in ac-source-rng-nxml-candidates
                 if (eq (compare-strings kw 0 nil
                                         c  0 kwlen)
                        t)
                 collect (concat prefix c)))))
    (action
     . (lambda ()
         (let* ((prefix (ac-source-rng-nxml-get-prefix ac-prefix))
                (kw (substring ac-prefix (length prefix))))
           (setq ac-source-rng-nxml-candidates kw)
           (ac-source-rng-nxml-do-complete))))))
(require 'mumamo)
(require 'zencoding-mode)
(require 'javascript-mode)
;;=========HTML 模式
;; only special background in submode
(add-hook 'nxhtml-mode-hook 'common-nxhtml-mode-setup)
(add-hook 'mumamo-turn-on-hook
          (lambda ()
            (setq nxhtml-validation-header-mumamo-modes '(nxhtml-mode eruby-nxhtml-mumamo-mode))
            (nxhtml-add-validation-header-if-mumamo)))

(defun common-nxhtml-mode-setup ()
  ;; I don't use cua-mode, but nxhtml always complains. So, OK, let's
  ;; define this dummy variable
  (setq nxhtml-skip-welcome t)
  (set-face-attribute 'mumamo-background-chunk-major nil
                      :background "Grey25")
  (set-face-attribute 'mumamo-background-chunk-submode1 nil
                      :background "Grey35")
  (set-face-attribute 'mumamo-background-chunk-submode2 nil
                      :background "Grey35")
  (set-face-attribute 'mumamo-background-chunk-submode3 nil
                      :background "Grey35")
  (set-face-attribute 'mumamo-background-chunk-submode4 nil
                      :background "Grey35")
  (setq zencoding-mode t)
  (setq mumamo-chunk-coloring 'submode-colored)
  (setq indent-region-mode t)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq nxml-slash-auto-complete-flag t)
  ;; (setq nxhtml-validation-header-mode t)
  (define-key zencoding-preview-keymap "\r" 'zencoding-expand-yas)
  (make-local-variable 'cua-inhibit-cua-keys)
  (set (make-local-variable 'ac-sources)
       '(ac-source-yasnippet
         ac-source-semantic
	 ac-source-rng-nxml
         ac-source-abbrev
         ac-source-dictionary))
  (setq ac-auto-start 1))

(defun zzq-html-mode ()
  (common-nxhtml-mode-setup)
  (nxhtml-mode)
  (nxhtml-mumamo-mode)
  (setq mumamo-current-chunk-family
        '("common nXhtml Family" nxhtml-mode
          (mumamo-chunk-inlined-style
           mumamo-chunk-inlined-script
           mumamo-chunk-style=
           mumamo-chunk-onjs=)))
  (auto-fill-mode -1))

(defun zzq-phtml-mode ()
  (zzq-html-mode)
  (nxhtml-mumamo-mode)
  (common-smart-snippets-setup php-mode-map php-mode-abbrev-table))


