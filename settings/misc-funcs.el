;;; misc-funcs.el --- 

;; Copyright 2012 Zigler Zhang
;;
;; Author: zhzhqiang@gmail.com
;; Version: $Id: misc-funs.el,v 0.0 2012/04/18 00:06:48 zigler Exp $
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
;;   (require 'misc-funcs)

;;; Code:

(provide 'misc-funcs)
(eval-when-compile
  (require 'cl))

;;-----------------------------------------------------------------
;; try-require: attempt to load a feature/library, failing silently
;;-----------------------------------------------------------------
(defvar missing-packages-list nil
  "List of packages that `try-require' can't find.")

(defun try-require (feature)
  "Attempt to load a library or module. Return true if the
library given as argument is successfully loaded. If not, instead
of an error, just add the package to a list of missing packages."
  (condition-case err
      ;; protected form
      (progn
	(message "Checking for library `%s'..." feature)
	(if (stringp feature)
	    (load-library feature)
	  (require feature))
	(message "Checking for library `%s'... Found" feature))
    ;; error handler
    (file-error  ; condition
     (progn
       (message "Checking for library `%s'... Missing" feature)
       (add-to-list 'missing-packages-list feature))
     nil)))
;;-----------------------------------------------------------------


;; 当你从不同的文件copy时保证重新indent
(defadvice yank (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode
                                ruby-mode python-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defadvice yank-pop (after indent-region activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode
                                latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
        (indent-region (region-beginning) (region-end) nil))))

(defadvice goto-line (after expand-after-goto-line
                            activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))


(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))
;;注释一行或一个block 绑定到 C-;
(defun my-comment-or-uncomment-region (&optional line)
  "This function is to comment or uncomment a line or a region"
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (save-excursion
        (comment-or-uncomment-region
         (progn
           (beginning-of-line)
           (point))
         (progn
           (end-of-line)
           (point))))
    (call-interactively 'comment-or-uncomment-region)))
;;字数统计
(defun zjs-count-word ()
  (interactive)
  (let ((beg (point-min)) (end (point-max))
        (eng 0) (non-eng 0))
    (if mark-active
        (setq beg (region-beginning)
              end (region-end)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond ((not (equal (car (syntax-after (point))) 2))
               (forward-char))
              ((< (char-after) 128)     
               (progn
                 (setq eng (1+ eng))
                 (forward-word)))
              (t
               (setq non-eng (1+ non-eng))
               (forward-char)))))
    (message "English words: %d\nNon-English characters: %d"
             eng non-eng))) 

;;jump out from a pair(like quote, parenthesis, etc.)
(defun kid-c-escape-pair ()
  (interactive)
  (let ((pair-regexp "[^])}\"'>]*[])}\"'>]"))
    (if (looking-at pair-regexp)
	(progn
	  ;; be sure we can use C-u C-@ to jump back
	  ;; if we goto the wrong place
	  (push-mark) 
	  (goto-char (match-end 0)))
      (c-indent-command))))

(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register. 
Use ska-jump-to-register to jump back to the stored 
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))

;;中英文之间自动加空格
;; (defun add-blank-in-chinese-and-english (&optional start end)
;;   “automaticall add a blank between English and Chinese words.”
;;    (interactive)
;;    (save-excursion
;;      (progn
;;        (if (not start)
;; 	   (setq start (point-min)))
;;        (if (not end)
;; 	   (setq end (point-max)))
;;        (goto-char start)
;;        (while (and (re-search-forward ”\\(\\cc\\)\\([0-9-]*[a-z]\\)”  nil t)
;; 		   (<= (match-end 0) end ))
;; 	 (replace-match "\\1 \\2" nil nil))
;;        (goto-char start)
;;        (while (and (re-search-forward "\\([a-z][0-9-]*\\)\\(\\cc\\)"  nil t)
;; 		   (<= (match-end 0) end ))
;; 	 (replace-match "\\1 \\2" nil nil)))))

					;删除匹配括号间内容 
(defun kill-match-paren (arg)
  (interactive "p")
  (cond ((looking-at "[([{]") (kill-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-kill-sexp 1))
	(t (self-insert-command (or arg 1)))))


;; substitute by paredit-mode
(defun zzq-wrap-region-with-paren ( start end)
  (interactive "r")
  (goto-char start)
  (insert "(")
  (goto-char (+ 1 end))
  (insert ")"))
(global-set-key (kbd "C-(")	'zzq-wrap-region-with-paren)


(defmacro load-conf-file-and-setup
  (mode-hook conf-file mode-setup-function &optional buffer-setup-fun)
  `(progn
     (add-hook ,mode-hook
	       (lambda()
		 (require ,conf-file)
		 (if (fboundp ',buffer-setup-fun)
		     (,buffer-setup-fun))))
     (eval-after-load (prin1-to-string ,conf-file)
       '(progn
	  (,mode-setup-function)))))

;; (defmacro load-conf-file-and-setup-c
;;   (mode-hook conf-name)
;;   (let ((conf-file (make-symbol "conf-file"))
;; 	(mode-setup-fun (make-symbol "mode-setup-fun"))
;; 	(buffer-setup-fun (make-symbol "buffer-setup-fun")))
;;     `(let ((,conf-file (intern (concat ,conf-name "-conf")))
;; 	   (,mode-setup-fun (read (concat "setup-" ,conf-name "-mode")))
;; 	   (,buffer-setup-fun (read (concat "setup-" ,conf-name "-buffer"))))
;;        (progn
;; 	 (prin1 ,conf-file)
;; 	 (princ ,mode-hook)
;; 	 (princ ,mode-setup-fun)
;; 	 (add-hook ,mode-hook
;; 	 	   (lambda()
;; 	 	     (require ,conf-file)
;; 	 	     (,buffer-setup-fun)))
;; 	 (eval-after-load (prin1-to-string ,conf-file)
;; 	   '(progn
;; 	      (,mode-setup-fun)))
;; 	 (eq 'java-mode-hook ,mode-hook)
;; 	 ))))

;; (load-conf-file-and-setup-c 'java-mode-hook "java")


;;========END




;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; misc-funs.el ends here
