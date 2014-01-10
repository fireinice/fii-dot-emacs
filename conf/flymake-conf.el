;;; flymake-conf.el --- configuration file for flymake

;; Copyright (C) 2010  Zigler Zhang

;; Author: Zigler Zhang <zhzhqiang@gmail.com>
;; Keywords: local

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

;;========Flymake=====================================
(require 'flymake)
(when (locate-library "flymake-cursor")
  (load-library "flymake-cursor"))
(add-hook 'flymake-mode-hook
          (lambda ()
	    (local-set-key (kbd "C-c C-e") 'flymake-goto-next-error)
	    (local-set-key (kbd "C-c C-d") 'flymake-display-err-menu-for-current-line)
            (setq flymake-gui-warnings-enabled nil)
            (setq flymake-compilation-prevents-syntax-check t)
            (setq flymake-log-level -1)
	    (setq flymake-run-in-place nil)
	    (setq flymake-master-file-dirs '("../src" "." "./src" "./UnitTest"))
            (set-face-attribute 'flymake-warnline nil
                                :background "LightBlue2"
                                :foreground "black")
            (set-face-attribute 'flymake-errline nil
                                :background "LightPink"
                                :foreground "black")
	    ))


(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))

(autoload 'flymake-shell-load "flymake-shell" nil t)
;; (require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(push '("\\\.java\\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup) flymake-allowed-file-name-masks)

(if (try-require 'jde-ecj-flymake)
    (lambda ()
      (require 'jde-ecj-flymake)
      ;; (setq jde-compiler '(("eclipse java compiler server" "/usr/share/java/ecj.jar")))
      (push '("\\\.java\\\'" jde-ecj-server-flymake-init jde-ecj-flymake-cleanup) flymake-allowed-file-name-masks)
      (setq jde-compiler '(("eclipse java compiler server" "/usr/share/java/ecj.jar")))))

;; (defun flymake-pylint-init ()
;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-intemp))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "epylint" (list local-file))))


;; ;; (add-to-list 'flymake-allowed-file-name-masks
;; ;;           '("\\.py\\'" flymake-pylint-init))

;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-intemp))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))

;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(provide 'flymake-conf)
;;; flymake-conf.el ends here
