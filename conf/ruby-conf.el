(require 'inf-ruby)
(require 'ruby-electric)
(require 'rcodetools)
(require 'flymake-conf)
(require 'rspec-mode)
(require 'rsense)
(setq rsense-home "/opt/rsense")
(setq rsense-rurema-home (concat rsense-home "/ruby-refm"))
(autoload 'ri "ri-ruby" nil t)
(require 'rinari)
(require 'xhtml-conf)
;; (require 'rails)

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
(define-key ruby-mode-map (kbd "\C-c\C-t") 'rspec-toggle-spec-and-target)

(defun rhtml-mode ()
  (setq nxml-degraded t)
  (zzq-html-mode)
  (eruby-nxhtml-mumamo-mode)
  (ruby-electric-mode nil))

(defun setup-ruby-mode ()
  (set (make-local-variable 'indent-tabs-mode) 'nil)
  (set (make-local-variable 'tab-width) 2)
  (imenu-add-to-menubar "IMENU")
  (ruby-electric-mode t)
  (local-unset-key (kbd "<return>"))
  (local-set-key (kbd "RET")  'newline-and-indent)
  ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
  (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
      (lambda ()
        (flymake-mode t)))
  (set (make-local-variable 'ac-sources)
       (append
        '(ac-source-rcodetools ac-source-rsense-method ac-source-rsense-constant ac-source-rsense)
        ac-sources))
  (add-hook 'compilation-filter-hook 'compilation-filter-hook-rspec)
  (add-hook 'write-file-functions
            '(lambda()
               (save-excursion
                 (untabify (point-min) (point-max))
                 (delete-trailing-whitespace)))) nil t)


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

(define-key rspec-mode-keymap (kbd "C-c ,b") 'rspec-verify-backtrace)
(defun rspec-verify-backtrace ()
  "Runs the specified example at the point of the current buffer."
  (interactive)
  (rspec-run-single-file (rspec-spec-file-for (buffer-file-name)) (rspec-core-options ()) (concat "--backtrace ")))

(defun compilation-filter-hook-rspec ()
  (interactive)
  ;;Just want to search over the last set of stuff, so exchange point and mark?
  (goto-char (point-min))
  (while (re-search-forward "useless use of == in void context$" nil t)
    (let ((beg (progn (forward-line 0)
                      (point))))
      (forward-line 1)
      (delete-region beg (point)))))
(provide 'ruby-conf)
