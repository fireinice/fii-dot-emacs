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
