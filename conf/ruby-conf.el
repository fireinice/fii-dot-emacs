;;调用inf-ruby
(require 'inf-ruby)
(require 'rcodetools)
(require 'smart-snippets-conf)
(require 'flymake-conf)
(autoload 'ruby-electric-mode "ruby-electric")
;; could be replaced by smart-snippet and yasnippet
(autoload 'rails "rails mode")
(autoload 'ri "ri-ruby" nil t)

;; irbsh and info-ruby is duplicated, we should choose one in future
(when (locate-library "irbsh")
  (autoload 'irbsh "irbsh" "irbsh - IRB.extend ShellUtilities" t)
  (autoload 'irbsh-oneliner-with-completion "irbsh" "irbsh oneliner" t))
(when (locate-library "irbsh-toggle")
  (autoload 'irbsh-toggle "irbsh-toggle" 
    "Toggles between the *irbsh*1 buffer and whatever buffer you are editing."
    t)
  (autoload 'irbsh-toggle-cd "irbsh-toggle" 
    "Pops up a irbsh-buffer and insert a \"cd <file-dir>\" command." t))

(defvar ri-ruby-script "/home/zigler/.emacs.d/misc/ri-emacs.rb"
  "RI ruby script")
;; add gem/bin into PATH to make rcodetools could be called
(setenv "PATH" (concat "/var/lib/gems/1.8/bin:"
		       (getenv "PATH") )  )

(define-key ruby-mode-map "\C-c\C-a" 'ruby-eval-buffer)
(define-key ruby-mode-map "\r" 'ruby-reindent-then-newline-and-indent)

(set (make-local-variable 'indent-tabs-mode) 'nil)
(set (make-local-variable 'tab-width) 2)
(imenu-add-to-menubar "IMENU")
(inf-ruby-keys)
;; (ruby-electric-mode t)
;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
(if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
    (flymake-mode))

(add-hook 'local-write-file-hooks
	  '(lambda()
	     (save-excursion
	       (untabify (point-min) (point-max))
	       (delete-trailing-whitespace))))


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

(provide 'ruby-conf)