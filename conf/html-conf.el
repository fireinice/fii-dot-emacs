;;; html-conf.el ---

;; Copyright 2010 Zhiqiang Zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: xhtml-conf.el,v 0.0 2010/06/04 06:33:03 zigler Exp $
;; Keywords:
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;  BUGS:
;;  * the ac-sources would return nil for prefix

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'xhtml-conf)

;;; Code:

(provide 'html-conf)
(eval-when-compile
  (require 'cl)
  (require 'auto-complete))

(require 'smart-snippets-conf)

(require 'php-mode)
(require 'mmm-mode)
(require 'js2-mode)
(require 'multi-web-mode)
;;
;; configure css-mode
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)
;;
(add-hook 'php-mode-user-hook 'turn-on-font-lock)

(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags 
      '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
	(css-mode "<style +type=\"text/css\"[^>]*>" "</style>")
	(javascript-mode  "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;;=========css-mode
;;在html和css模式下将#XXXXXX按所代表的颜色着色
(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{3,6\\}"
     (0 (let ((colour (match-string-no-properties 0)))
          (if (or (= (length colour) 4)
                  (= (length colour) 7))
              (put-text-property
               (match-beginning 0)
               (match-end 0)
               'face (list :background (match-string-no-properties 0)
                           :foreground (if (>= (apply '+ (x-color-values
                                                          (match-string-no-properties 0)))
                                               (* (apply '+ (x-color-values "white")) .6))
                                           "black" ;; light bg, dark text
                                         "white" ;; dark bg, light text
                                         )))))
        append))))

(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords t))
(add-hook 'mmm-mode-hook 'hexcolour-add-to-font-lock)


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################
;; do not turn on rng-validate-mode automatically, I don't like
;; the anoying red underlines
;; (setq rng-nxml-auto-validate-flag nil)


;;; xhtml-conf.el ends here
