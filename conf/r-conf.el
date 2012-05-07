;;; r-conf.el --- 

;; Copyright 2011 zigler zhang
;;
;; Author: zigler@zigler.internal.baidu.com
;; Version: $Id: r-conf.el,v 0.0 2011/07/06 06:40:13 zigler Exp $
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

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
  ;; (require 'r-conf)

;; Code:

(provide 'r-conf)
(eval-when-compile
  (require 'cl)
  (require 'cc-mode))

(require 'ess-eldoc) ;to show function arguments while you are typing them

(setq ess-eval-visibly-p nil) ;otherwise C-c C-r (eval region) takes forever
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
;; (setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
;; (R)

;; (defun my-ess-start-R ()
;;   (interactive)
;;   (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
;;       (progn
;; 	(delete-other-windows)
;; 	(setq w1 (selected-window))
;; 	(setq w1name (buffer-name))
;; 	(setq w2 (split-window w1))
;; 	(R)
;; 	(set-window-buffer w2 "*R*")
;; 	(set-window-buffer w1 w1name))))

;; (defun my-ess-eval ()
;;   (interactive)
;;   (my-ess-start-R)
;;   (if (and transient-mark-mode mark-active)
;;       (call-interactively 'ess-eval-region)
;;     (call-interactively 'ess-eval-line-and-step)))

(defun setup-r-mode ()
  (require 'ac-R)
  (add-to-list 'ac-sources 'ac-source-R)
  (make-local-variable ac-ignore-case)
  (setq ac-ignore-case 'nil)
  (local-set-key [(shift return)] 'my-ess-eval))

(add-hook 'inferior-ess-mode-hook
	  '(lambda()
	     (local-set-key [C-up] 'comint-previous-input)
	     (local-set-key [C-down] 'comint-next-input)))
(require 'ess-site)

;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; r-conf.el ends here
