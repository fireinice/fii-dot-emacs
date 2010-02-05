;;; smart-snippets-conf.el --- 

;; Copyright 2010 Zhiqiang Zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: smart-snippets-conf.el,v 0.0 2010/01/18 05:07:50 zigler Exp $
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
;;   (require 'smart-snippets-conf)

;;; Code:

(provide 'smart-snippets-conf)
(eval-when-compile
  (require 'cl))
(require 'smart-snippet)
(require 'cc-mode)

;; (defmacro smart-snippet-with-abbrev-tables-list
;;   (abbrev-tables snippets)
;;   (let ((tables (smart-snippet-quote-element abbrev-tables)))
;;     `(progn
;;        ,@(smart-snippet-flatten-1
;;           (loop for table in tables
;;                 collect (loop for snippet in snippets
;;                               collect (append
;;                                        (list
;;                                         'smart-snippet-abbrev
;;                                         table)
;;                                        snippet)))))))

;; (defmacro smart-snippet-with-keymaps-list
;;    (keymap-and-abbrev-tables map-list)
;;    (let ((kaymap-and-abbrev-tables
;; 	  (smart-snippet-quote-element keymap-and-abbrev-tables)))
;;      `(progn
;; 	,@(smart-snippet-flatten-1
;; 	   (loop for map-and-table in keymap-and-abbrev-tables
;; 		 collect (loop for key-mapping in map-list
;; 			       collect (list
;; 					'smart-snippet-set-snippet-key
;; 					(car map-and-table)
;; 					(list 'quote
;; 					      (cadr map-and-table))
;; 					(car key-mapping)
;; 					(car key-mapping))))))))


;; (defun smart-snippet-flatten-1 (list)
;;   (cond ((atom list) list)
;;         ((listp (car list))
;;          (append (car list)
;;                  (smart-snippet-flatten-1 (cdr list))))
;;         (t (append (list (car list))
;;                    (smart-snippet-flatten-1 (cdr list))))))
;; (defmacro double-loop (list1 list2)
;;   `(progn
;;      ,@(smart-snippet-flatten-2
;; 	(loop for i in list1
;; 	      collect (loop for j in list2
;; 			    collect`((func ,i ,j) (func1 ,i ,j)))))))
;; (macroexpand '(double-loop (1 2 3) (4 5)) )
;; (defmacro smart-snippets-with-keymaps-abbrev-tables-list
;;   (keymap-and-abbrev-tables snippets)
;;   (let ((keymap-and-abbrev-tables
;; 	 (smart-snippet-quote-element keymap-and-abbrev-tables)))
;;     `(progn
;;        ,@(smart-snippet-flatten-2
;; 	  (loop for map-and-table in keymap-and-abbrev-tables
;; 		collect (loop for snippet in snippets
;; 			      collect `((append
;; 					 (smart-snippet-abbrev
;; 					  (nth 1 ,map-and-table))
;; 					 ,snippet)
;; 					(smart-snippet-set-snippet-key
;; 					 ,(car map-and-table)
;; 					 (quote
;; 					  ,(cadr map-and-table))
;; 					 ,(car snippet)
;; 					 ,(car snippet)))))))))

;; (defun smart-snippet-flatten-2 (list)
;;   (progn
;;     (smart-snippet-flatten-1
;;      (smart-snippet-flatten-1 list))))

;; (defmacro smart-snippets-with-keymaps-abbrev-tables-list
;;   (arg-list)
;;   (let ((keymap-and-abbrev-tables
;; 	 (smart-snippet-quote-element (nth 0 arg-list)))
;; 	(snippets (nth 1 arg-list)))
;;     `(progn
;;        ,@(smart-snippet-flatten-2
;; 	  (loop for map-and-table in keymap-and-abbrev-tables
;; 		collect (loop for snippet in snippets
;; 			      collect `((append
;; 					 (smart-snippet-abbrev
;; 					  (nth 1 ,map-and-table))
;; 					 ,snippet)
;; 					(smart-snippet-set-snippet-key
;; 					 ,(car map-and-table)
;; 					 (quote
;; 					  ,(cadr map-and-table))
;; 					 ,(car snippet)
;; 					 ,(car snippet)))))))))

;; (macroexpand '(smart-snippets-with-keymaps-abbrev-tables-list
;; ((c++-mode-map c++-mode-abbrev-table)
;; common-snippets-list)))

(defvar test-common-snippets-list
  '(("{" "{$.}" '(not (c-in-literal)))))

(defvar common-snippets-list
  '(("{" "{$.}" '(not (c-in-literal)))
    ("{" "{$>\n$>$.\n}$>" 'bol?)
    ;; if not in comment or other stuff(see `c-in-literal'), then
    ;; inser a pair of quote. if already in string, insert `\"'
    ("\"" "\"$.\"" '(not (c-in-literal)))	
    ("\"" "\\\"$." '(eq (c-in-literal) 'string))
    ;; insert a pair of parenthesis, useful everywhere
    ("(" "($.)" t)
    ;; insert a pair of angular bracket if we are writing templates
    ("<" "<$.>" '(and (not (c-in-literal))
		      (looking-back "template[[:blank:]]*")))
    ;; a pair of square bracket, also useful everywhere
    ("[" "[$.]" t)
    ;; a pair of single quote, if not in literal
    ("'" "'$.'" '(not (c-in-literal)))
    ("," ", " '(not (c-in-literal)))))


(defun smart-snippets-list-with-keymap-abbrev-table
  (keymap-and-abbrev-table snippets)
  (progn
    (dolist (snippet snippets)
      (let ((mode-table (car keymap-and-abbrev-table))
	    (abbrev-table (cadr keymap-and-abbrev-table))
	    (short-key (car snippet)))
	(print mode-table)
	(print snippet)
	(smart-snippet-with-abbrev-tables
	 (list abbrev-table)
	 snippet)
	(smart-snippet-set-snippet-key
	 (eval mode-table)
	 abbrev-table
	 short-key
	 short-key))
      )))

(smart-snippets-list-with-keymap-abbrev-table
 '(c++-mode-map c++-mode-abbrev-table)
 test-common-snippets-list)


c++-mode-map

("{" "{$.}" (quote (not (c-in-literal))))

c++-mode-map

("{" "{$.}" (quote (not (c-in-literal))))
nil

;; (smart-snippet-with-abbrev-tables c++-mode-map "{")
;; (smart-snippet-set-snippet-key c++-mode-map 'c++-mode-abbrev-table "{" "{")
(smart-snippet-with-keymaps
 ((c++-mode-map c++-mode-abbrev-table))
 ("{" "{")
 ("\"" "\"")
 ("(" "(")
 ("<" "<")
 ("[" "[")
 ("'" "'"))

(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table)
 ("{" "{$.}" '(not (c-in-literal)))
 )
