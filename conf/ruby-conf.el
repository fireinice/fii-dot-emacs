;;调用inf-ruby
(require 'inf-ruby)
(require 'rcodetools)
(setenv "PATH" (concat "/var/lib/gems/1.8/bin:"
		       (getenv "PATH") )  )
(autoload 'ruby-electric "ruby electric")
(autoload 'rails "rails mode")
(defvar ri-ruby-script "/home/zigler/.emacs.d/misc/ri-emacs.rb"
  "RI ruby script")

(autoload 'ri "ri-ruby" nil t)

(when (locate-library "irbsh")
  (autoload 'irbsh "irbsh" "irbsh - IRB.extend ShellUtilities" t)
  (autoload 'irbsh-oneliner-with-completion "irbsh" "irbsh oneliner" t))
(when (locate-library "irbsh-toggle")
  (autoload 'irbsh-toggle "irbsh-toggle" 
    "Toggles between the *irbsh*1 buffer and whatever buffer you are editing."
    t)
  (autoload 'irbsh-toggle-cd "irbsh-toggle" 
    "Pops up a irbsh-buffer and insert a \"cd <file-dir>\" command." t))

(add-hook 'local-write-file-hooks
	  '(lambda()
	     (save-excursion
	       (untabify (point-min) (point-max))
	       (delete-trailing-whitespace))))
(set (make-local-variable 'indent-tabs-mode) 'nil)
(set (make-local-variable 'tab-width) 2)
(imenu-add-to-menubar "IMENU")
;;             (ruby-electric-mode t)
(define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
(inf-ruby-keys)
(define-key ruby-mode-map "\r" 'ruby-reindent-then-newline-and-indent)
;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
(if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
    (flymake-mode))


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

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
	 (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))


(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(provide 'ruby-conf)