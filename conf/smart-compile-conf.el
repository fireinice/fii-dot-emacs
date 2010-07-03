;;; smart-compile-conf.el ---

;; Copyright 2010 Zhiqiang Zhang
;;
;; Author: zhiqiang.zhang@ask.com
;; Version: $Id: smart-compile-conf.el,v 0.0 2010/01/18 05:26:28 zigler Exp $
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
;;   (require 'smart-compile-conf)

;;; Code:

(provide 'smart-compile-conf)
(eval-when-compile
  (require 'cl))

(setq smart-compile-alist
      '(("/network/asio/.*cpp$" .       "g++ -Wall %f -lm -lboost_thread -o %n")
	;;         ("\\.c\\'"      .   "gcc -Wall %f -lm -o %n")
	;;         ("\\.[Cc]+[Pp]*\\'" .   "g++ -Wall %f -lm -o %n")
	(emacs-lisp-mode    . (emacs-lisp-byte-compile))
	(html-mode          . (browse-url-of-buffer))
	(nxhtml-mode        . (browse-url-of-buffer))
	(html-helper-mode   . (browse-url-of-buffer))
	(octave-mode        . (run-octave))
	("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
	;;  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n && ./%n")
	("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
	("\\.m\\'"          . "gcc -O2 %f -lobjc -lpthread -o %n")
	("\\.java\\'"       . "javac %f")
	("\\.php\\'"        . "php %f")
	;; 	("\\.f90\\'"        . "f90 %f -o %n")
	;; 	("\\.[Ff]\\'"       . "f77 %f -o %n")
	;; 	("\\.cron\\(tab\\)?\\'" . "crontab %f")
	;; 	("\\.tex\\'"        . (tex-file))
	("\\.tex$"          . (TeX-command-master))
	("\\.texi\\'"       . "makeinfo %f")
	;; 	("\\.mp\\'"         . "mptopdf %f")
	("\\.pl\\'"         . "perl -cw %f")
	("\\.rb\\'"         . "ruby -w %f")
	;; ;    ("\\.skb$"              .       "skribe %f -o %n.html")
	;; ;    (haskell-mode           .       "ghc -o %n %f")
	;; ;    (asy-mode               .       (call-interactively 'asy-compile-view))
        (muse-mode      .   (call-interactively 'muse-project-publish))))


(setq smart-run-alist
      '(("\\.c$"          . "./%n")
        ("\\.[Cc]+[Pp]*$" . "./%n")
        ("\\.java$"       . "java %n")
        ("\\.php$"        . "php %f")
        ("\\.m$"          . "%f")
        ("\\.scm"         . "%f")
        ("\\.tex$"        . "dvisvga %n.dvi")
        ("\\.py$"         . "python %f")
        ("\\.pl$"         . "perl \"%f\"")
        ("\\.pm$"         . "perl \"%f\"")
        ("\\.bat$"        . "%f")
        ("\\.mp$"         . "mpost %f")
        ("\\.ahk$"        . "start d:\\Programs\\AutoHotkey\\AutoHotkey %f")
        ("\\.sh$"         . "./%f")))

(setq smart-executable-alist
      '("%n.class"
        "%n.exe"
        "%n"
        "%n.mp"
        "%n.m"
        "%n.php"
        "%n.scm"
        "%n.dvi"
        "%n.py"
        "%n.pl"
        "%n.ahk"
        "%n.pm"
        "%n.bat"
        "%n.sh"))


;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; smart-compile-conf.el ends here
