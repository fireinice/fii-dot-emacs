;;; my-function.el ---


;; Copyright 2010 Zhiqiang Zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: func-conf.el,v 0.0 2010/01/20 04:27:40 zigler Exp $
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
;;   (require 'func-conf)

;;; Code:

(provide 'my-function)
(eval-when-compile
  (require 'cl))

;;=======基本函数
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
(add-hook 'after-save-hook
	  (lambda ()
	    (mapcar
	     (lambda (file)
	       (setq file (expand-file-name file))
	       (when (string= file (buffer-file-name))
		 (save-excursion (byte-compile-file file))))
	     '("~/.emacs.d/init.el" "~/.emacs.d/myinfo.el"
	       "~/.emacs.d/conf/cpp-conf.el"))))

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

(defun zzq-subdirectories (directory)
  "List all not start with '.' sub-directories of DIRECTORY"
  (let (subdirectories-list)
    (dolist (file-name (directory-files directory t))
      (when (file-directory-p file-name)
	
	(unless
	    (equal "."
		   (substring
		    (file-name-nondirectory file-name) 0 1))
	  (add-to-list 'subdirectories-list file-name))))
    subdirectories-list))


;;========END



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; func-conf.el ends here