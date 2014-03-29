(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
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
    (package-install name)))

(try-package-install 'auto-complete)
(try-package-install 'autopair)
(try-package-install 'paredit)
(try-package-install 'regex-tool)
(try-package-install 'htmlize)
(try-package-install 'w3m)
(try-package-install 'yasnippet)
(try-package-install 'ascope)
(try-package-install 'xcscope)
(try-package-install 'smart-compile)
(try-package-install 'color-moccur)

(try-package-install 'python-mode)
(try-package-install 'python-pylint)
(try-package-install 'jedi)
(try-package-install 'ipython)

(try-package-install 'google-c-style)
(try-package-install 'protobuf-mode)

(try-package-install 'flymake)
(try-package-install 'flymake-python-pyflakes)
(try-package-install 'flymake-shell)

(try-package-install 'psvn)
(try-package-install 'magit)
(try-package-install 'magit-push-remote)

(try-package-install 'bash-completion)
(try-package-install 'shell-history)

(try-package-install 'php-mode)
(try-package-install 'php-eldoc)
(try-package-install 'flymake-php)

(try-package-install 'js2-mode)
(try-package-install 'ac-js2)

(try-package-install 'apt-utils)
(try-package-install 'top-mode)

(try-package-install 'mediawiki)

(try-package-install 'emacs-droid)
(try-package-install 'android-mode)
(try-package-install 'emacs-eclim)
