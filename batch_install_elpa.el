(require 'package)
(package-initialize)
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-refresh-contents)

(unless (package-installed-p 'ansi)
  (message (format "%s%s" "try to install " (symbol-name 'ansi)))
  (package-install 'ansi))
(require 'ansi)

(defun try-package-install (name)
  "check if the package is not installed, then install it!"
  (unless (package-installed-p name)
    (message (ansi-green (format "%s%s%s" "try to install " (symbol-name name) "...")))
    ;; (let ((pkg-desc (assq name package-archive-contents)))
    ;;   (unless pkg-desc
    ;; 	(error "Package `%s' is not available for installation"
    ;; 	       (symbol-name name))))
    (if (package-install name)
	(message (ansi-green "done"))
      (message (ansi-red "failed")))))

(try-package-install 'auto-complete)
(try-package-install 'magit)
(try-package-install 'w3m)
(try-package-install 'autopair)
(try-package-install 'paredit)
(try-package-install 'bash-completion)
(try-package-install 'regex-tool)

(try-package-install 'python-mode)
(try-package-install 'python-pylint)
(try-package-install 'jedi)
(try-package-install 'ipython)

(try-package-install 'google-c-style)

(try-package-install 'flymake)
(try-package-install 'flymake-python-pyflakes)
(try-package-install 'flymake-shell)

(try-package-install 'emacs-droid)
(try-package-install 'android-mode)

(try-package-install 'yasnippet)
