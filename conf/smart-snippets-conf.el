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
;; those non-word snippet can't be triggered by abbrev expand, we
;; need to bind them explicitly to some key
(smart-snippet-with-abbrev-tables
 (c++-mode-abbrev-table
  c-mode-abbrev-table
  java-mode-abbrev-table
  ruby-mode-abbrev-table
  ;;   js2-mode-abbrev-table
  python-mode-abbrev-table)
 ("{" "{$.}" '(not (c-in-literal)))
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
 ("," ", " '(not (c-in-literal)))
 )


(smart-snippet-with-keymaps
 ((c++-mode-map c++-mode-abbrev-table)
  (c-mode-map c-mode-abbrev-table)
  (java-mode-map java-mode-abbrev-table)
  (ruby-mode-map ruby-mode-abbrev-table)
  (python-mode-map python-mode-abbrev-table))
 ("{" "{")
 ("\"" "\"")
 ("(" "(")
 ("<" "<")
 ("[" "[")
 ("'" "'"))

(smart-snippet-with-abbrev-tables
 (ruby-mode-abbrev-table)
 ("/" "/$./" '(not (c-in-literal)))
 ("|" "|$.|" '(not (c-in-literal)))
 )

(smart-snippet-with-keymaps
 ((ruby-mode-map ruby-mode-abbrev-table))
 ("/" "/")
 ("|" "|"))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; smart-snippets-conf.el ends here
