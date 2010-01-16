;;加载钩子
;; (add-hook 'ruby-mode-hook
;;           (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
;;             (ruby-electric-mode t)
            (define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
            (inf-ruby-keys)
;; ))
(define-key ruby-mode-map "\r" 'ruby-reindent-then-newline-and-indent)

(defun ruby-eval-buffer ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (point-min) (point-max) "ruby"))

(defun ruby-eval-region ()
  (interactive)
  "Evaluate the buffer with ruby."
  (shell-command-on-region (region-beginning) (region-end) "ruby"))


(defun rails-find-and-goto-error ()
  "Finds error in rails html log go on error line"
  (interactive)
  (search-forward-regexp "RAILS_ROOT: \\([^<]*\\)")
  (let ((rails-root (concat (match-string 1) "/")))
    (search-forward "id=\"Application-Trace\"")
    (search-forward "RAILS_ROOT}")
    (search-forward-regexp "\\([^:]*\\):\\([0-9]+\\)")
    (let  ((file (match-string 1))
       (line (match-string 2)))
      ;(kill-buffer (current-buffer))
      (message
       (format "Error found in file \"%s\" on line %s. "  file line))
      (find-file (concat rails-root file))
      (goto-line (string-to-number line)))))

