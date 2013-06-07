;;; xhtml-conf.el ---

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

(provide 'xhtml-conf)
(eval-when-compile
  (require 'cl)
  (require 'auto-complete))

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

(autoload 'common-smart-snippets-setup "smart-snippets-conf" t nil)
(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil hexcolour-keywords t))
(add-hook 'nxhtml-mode-hook 'hexcolour-add-to-font-lock)


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################
;; do not turn on rng-validate-mode automatically, I don't like
;; the anoying red underlines
;; (setq rng-nxml-auto-validate-flag nil)


;;; xhtml-conf.el ends here
