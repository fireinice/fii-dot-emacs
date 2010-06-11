<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: php-doc.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=php-doc.el" /><link type="text/css" rel="stylesheet" href="/emacs/wiki.css" /><meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: php-doc.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=php-doc.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/emacs/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/emacs/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/emacs/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for php-doc.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=php-doc.el" /><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/></head><body class="http://www.emacswiki.org/emacs"><div class="header"><a class="logo" href="http://www.emacswiki.org/emacs/SiteMap"><img class="logo" src="/emacs_logo.png" alt="[Home]" /></a><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span>
<!-- Google CSE Search Box Begins  -->
<form class="tiny" action="http://www.google.com/cse" id="searchbox_004774160799092323420:6-ff2s0o6yi"><p>
<input type="hidden" name="cx" value="004774160799092323420:6-ff2s0o6yi" />
<input type="text" name="q" size="25" />
<input type="submit" name="sa" value="Search" />
</p></form>
<script type="text/javascript" src="http://www.google.com/coop/cse/brand?form=searchbox_004774160799092323420%3A6-ff2s0o6yi"></script>
<!-- Google CSE Search Box Ends -->
<h1><a title="Click to search for references to this page" rel="nofollow" href="http://www.google.com/cse?cx=004774160799092323420:6-ff2s0o6yi&amp;q=%22php-doc.el%22">php-doc.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="download/php-doc.el">Download</a></p><pre class="code"><span class="linecomment">;;; php-doc.el --- Php document helper</span>

<span class="linecomment">;; Copyright (C) 2009 Free Software Foundation, Inc.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; Author: Ye Wenbin &lt;wenbinye@gmail.com&gt;</span>
<span class="linecomment">;; Maintainer: Ye Wenbin &lt;wenbinye@gmail.com&gt;</span>
<span class="linecomment">;; Created: 01 Jan 2009</span>
<span class="linecomment">;; Version: 0.01</span>
<span class="linecomment">;; Keywords: languages, convenience</span>

<span class="linecomment">;; This program is free software; you can redistribute it and/or modify</span>
<span class="linecomment">;; it under the terms of the GNU General Public License as published by</span>
<span class="linecomment">;; the Free Software Foundation; either version 2, or (at your option)</span>
<span class="linecomment">;; any later version.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; This program is distributed in the hope that it will be useful,</span>
<span class="linecomment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="linecomment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="linecomment">;; GNU General Public License for more details.</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; You should have received a copy of the GNU General Public License</span>
<span class="linecomment">;; along with this program; if not, write to the Free Software</span>
<span class="linecomment">;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.</span>

<span class="linecomment">;;; Dependency:</span>
<span class="linecomment">;; 1. tree-mode.el - http://www.emacswiki.org/cgi-bin/emacs/tree-mode.el</span>
<span class="linecomment">;; 2. windata.el   - http://www.emacswiki.org/cgi-bin/emacs/windata.el</span>
<span class="linecomment">;; 3. help-dwim.el - http://www.emacswiki.org/cgi-bin/emacs/help-dwim.el</span>
<span class="linecomment">;;</span>
<span class="linecomment">;; If you use perl, install Emacs::PDE instead, it provide more features.</span>

<span class="linecomment">;;; Installation:</span>

<span class="linecomment">;; 1. Download php_manaul_en.tar.gz to local</span>
<span class="linecomment">;; 2. extract to certain directory</span>
<span class="linecomment">;; 3. add this to .emacs</span>
<span class="linecomment">;;    (require 'php-doc nil t)</span>
<span class="linecomment">;;    (setq php-doc-directory "/path/to/php_manual/html")</span>
<span class="linecomment">;;    (add-hook 'php-mode-hook</span>
<span class="linecomment">;;              (lambda ()</span>
<span class="linecomment">;;                (local-set-key "\t" 'php-doc-complete-function)</span>
<span class="linecomment">;;                (local-set-key (kbd "\C-c h") 'php-doc)</span>
<span class="linecomment">;;                (set (make-local-variable 'eldoc-documentation-function)</span>
<span class="linecomment">;;                     'php-doc-eldoc-function)</span>
<span class="linecomment">;;                (eldoc-mode 1)))</span>

<span class="linecomment">;; Put this file into your load-path and the following into your ~/.emacs:</span>
<span class="linecomment">;;   (require 'php-doc)</span>

<span class="linecomment">;;; Code:</span>

(eval-when-compile
  (require 'cl))

(require 'complete)
(require 'tree-mode)
(require 'windata)

(defgroup php-doc nil
  "<span class="quote">View Php manual in emacs</span>"
  :group 'tools)

(defcustom php-doc-directory "<span class="quote">/usr/share/doc/php-doc/html</span>"
  "<span class="quote">*Directory of php manual (multiple page html version)</span>"
  :type 'directory
  :group 'php-doc)

(defcustom php-doc-cachefile "<span class="quote">~/.emacs.d/php-doc</span>"
  "<span class="quote">*File to save php function symbol</span>"
  :type 'file
  :group 'php-doc)

(defcustom php-doc-tree-windata '(frame left 0.3 delete)
  "<span class="quote">*Arguments to set the window buffer display.
See `windata-display-buffer' for setup the arguments.</span>"
  :type 'sexp
  :group 'php-doc)

(defcustom php-doc-tree-theme "<span class="quote">default</span>"
  "<span class="quote">*Theme of tree-widget.</span>"
  :type 'string
  :group 'php-doc)

(defcustom php-doc-tree-buffer "<span class="quote">*PHP-doc*</span>"
  "<span class="quote">*Buffer name for `php-doc-tree'</span>"
  :type 'string
  :group 'php-doc)

(defcustom php-doc-browser-function
  (if (featurep 'w3m-load)
      'php-doc-w3m
    browse-url-browser-function)
  "<span class="quote">*Function to browse html file</span>"
  :type 'function
  :group 'php-doc)

(defvar php-doc-tree nil)

(defvar php-doc-obarray nil
  "<span class="quote">All php functions</span>")

(defsubst php-doc-function-file (sym)
  (expand-file-name (format "<span class="quote">function.%s.html</span>" (replace-regexp-in-string "<span class="quote">_</span>" "<span class="quote">-</span>" (symbol-name sym)))
                    php-doc-directory))

(defun php-doc-build-tree (&optional no-cache)
  (interactive "<span class="quote">P</span>")
  (let (functions function tree path)
    (if (and (not no-cache)
             (file-readable-p php-doc-cachefile))
        (with-temp-buffer
          (insert-file-contents php-doc-cachefile)
          (setq functions (read (current-buffer))))
      (let ((files (directory-files php-doc-directory nil "<span class="quote">\\.html$</span>")))
        (dolist (file files)
          (when (not (string-match "<span class="quote">^index</span>" file))
            (setq path (nbutlast (split-string file "<span class="quote">\\.</span>"))
                  function nil)
            (when (string= (car path) "<span class="quote">function</span>")
              (setq function (replace-regexp-in-string "<span class="quote">-</span>" "<span class="quote">_</span>" (cadr path)))
              (if (string-match "<span class="quote">-</span>" (cadr path))
                  (setq path (nconc (list (car path) (substring (cadr path) 0 (match-beginning 0)))
                                    (cdr path)))))
            (push (cons path function) functions)))
        <span class="linecomment">;; save to cache file</span>
        (when (file-writable-p php-doc-cachefile)
          (with-temp-buffer
            (prin1 functions (current-buffer))
            (write-file php-doc-cachefile)))))
    (setq php-doc-obarray (make-vector 1519 nil))
    (dolist (function functions)
      (when (cdr function)
        (intern (cdr function) php-doc-obarray))
      (php-doc-add-to-tree 'tree (car function)))
    (setq php-doc-tree tree)))

(defun php-doc-add-to-tree (sym list)
  (if list
      (let ((val (assoc (car list) (symbol-value sym)))
            (subtree (gensym))
            restree)
        (unless val
          (setq val (cons (car list) nil))
          (set sym (cons val (symbol-value sym))))
        (set subtree (cdr val))
        (setq restree (php-doc-add-to-tree subtree (cdr list)))
        (if restree
            (setcdr val restree))
        (symbol-value sym))))

(define-derived-mode php-doc-mode tree-mode "<span class="quote">PHPDoc</span>"
  "<span class="quote">List perl module using tree-widget.

\\{perldoc-mode-map}</span>"
  (tree-widget-set-theme php-doc-tree-theme))

(defun php-doc (sym)
  "<span class="quote">Display document of php function</span>"
  (interactive
   (progn
     (or php-doc-obarray (php-doc-build-tree))
     (let ((def (current-word)))
       (list (intern (completing-read (if def
                                          (format "<span class="quote">PHP Function(default %s): </span>" def)
                                        "<span class="quote">PHP Function: </span>")
                                      php-doc-obarray nil t nil nil def) php-doc-obarray)))))
  (let ((browse-url-browser-function php-doc-browser-function)
        (file (php-doc-function-file sym)))
    (if (file-exists-p file)
        (browse-url file))))

(defun php-doc-tree ()
  (interactive)
  (unless php-doc-tree
    (php-doc-build-tree))
  (unless (get-buffer php-doc-tree-buffer)
    (with-current-buffer (get-buffer-create php-doc-tree-buffer)
      (php-doc-mode)
      (widget-apply-action (widget-create (php-doc-tree-widget (cons "<span class="quote">PHP-Doc</span>" php-doc-tree))))
      (widget-setup)
      (goto-char (point-min))))
  (select-window (apply 'windata-display-buffer
                        (get-buffer php-doc-tree-buffer)
                        php-doc-tree-windata)))

(defun php-doc-tree-widget (list)
  `(tree-widget
    :node (push-button :button-face dired-directory
                       :notify php-doc-view-or-expand
                       :tag ,(car list)
                       :format "<span class="quote">%[%t%]\n</span>")
    ,@(mapcar
       (lambda (elem)
         (if (cdr elem)
             (php-doc-tree-widget elem)
           `(push-button :notify php-doc-view-or-expand
                         :tag ,(car elem)
                         :format "<span class="quote">%[%t%]\n</span>")))
       (cdr list))))

(defun php-doc-view-or-expand (node &rest ignore)
  (let ((browse-url-browser-function php-doc-browser-function)
        (me node)
        path)
    (while (widget-get node :parent)
      (push (tree-mode-node-tag node) path)
      (setq node (widget-get node :parent)))
    (if (and (string= (car path) "<span class="quote">function</span>")
             (= (length path) 3))
        (setq path (cons (car path) (cddr path))))
    (setq file (expand-file-name (concat (mapconcat 'identity path "<span class="quote">.</span>") "<span class="quote">.html</span>")
                                 php-doc-directory))
    (if (file-exists-p file)
        (browse-url (concat "<span class="quote">file://</span>" file))
      (tree-mode-toggle-expand))))

(defun php-doc-w3m (url &rest ignore)
  (let ((win (next-window))
        buf)
    (save-window-excursion
      (select-window win)
      (w3m-goto-url url)
      (setq buf (current-buffer)))
    (display-buffer buf)))

(if (featurep 'help-dwim)
    (help-dwim-register
     (cons 'php-doc ["<span class="quote">a-z_</span>" php-doc-obarray nil php-doc]) t))

(defun php-doc-complete-function ()
  (interactive)
  (unless php-doc-tree
    (php-doc-build-tree))
  (let* ((end (point))
         (beg (save-excursion
                (with-syntax-table c-mode-syntax-table
                  (backward-sexp 1)
                  (while (= (char-syntax (following-char)) ?\')
                    (forward-char 1))
                  (point))))
         (minibuffer-completion-table php-doc-obarray)
         (minibuffer-completion-predicate 'identity)
         (PC-not-minibuffer t))
    (if (equal last-command 'PC-lisp-complete-symbol)
        (PC-do-completion nil beg PC-lisp-complete-end t)
      (if PC-lisp-complete-end
          (move-marker PC-lisp-complete-end end)
        (setq PC-lisp-complete-end (copy-marker end t)))
      (PC-do-completion nil beg end t))))

(defun php-doc-eldoc-function ()
  (let (string symbol done)
    (save-excursion
      (while (not (or done symbol))
        (or (and (setq string (thing-at-point 'symbol))
                 (setq symbol (intern-soft string php-doc-obarray)))
            (setq done (null (re-search-backward "<span class="quote">\\&gt;\\s-*(</span>" (line-beginning-position) t))))))
    (when symbol
      (php-doc-function-synopsis symbol))))

(defun php-doc-function-synopsis (sym)
  (or (get sym 'method-synopsis)
      (let ((file (php-doc-function-file sym))
            begin synopsis)
        (when (file-exists-p file)
          (with-temp-buffer
            (insert-file-contents file)
            (re-search-forward "<span class="quote">&lt;div class=\"methodsynopsis dc-description\"&gt;</span>")
            (setq begin (point))
            (re-search-forward "<span class="quote">&lt;/div&gt;</span>")
            (setq synopsis
                  (replace-regexp-in-string "<span class="quote">[ \t\n]+</span>" "<span class="quote"> </span>"
                                            (replace-regexp-in-string "<span class="quote">&lt;[^&lt;]+&gt;</span>" "<span class="quote"></span>" (buffer-substring begin (point)))))
            (put sym 'method-synopsis synopsis)
            synopsis)))))

(provide 'php-doc)
<span class="linecomment">;;; php-doc.el ends here</span></span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a class="local" href="http://www.emacswiki.org/emacs/Search">Search</a> <a class="local" href="http://www.emacswiki.org/emacs/ElispArea">ElispArea</a> <a class="local" href="http://www.emacswiki.org/emacs/HowTo">HowTo</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><span class="translation bar"><br />  <a class="translation new" rel="nofollow" href="http://www.emacswiki.org/emacs?action=translate;id=php-doc.el;missing=de_es_fr_it_ja_ko_pt_ru_se_zh">Add Translation</a></span><span class="edit bar"><br /> <a class="edit" accesskey="e" title="Click to edit this page" rel="nofollow" href="http://www.emacswiki.org/emacs?action=edit;id=php-doc.el">Edit this page</a> <a class="history" rel="nofollow" href="http://www.emacswiki.org/emacs?action=history;id=php-doc.el">View other revisions</a> <a class="admin" rel="nofollow" href="http://www.emacswiki.org/emacs?action=admin;id=php-doc.el">Administration</a></span><span class="time"><br /> Last edited 2010-06-08 08:29 UTC by <a class="author" title="from 195.97.26.99" href="http://www.emacswiki.org/emacs/PierreGaston">PierreGaston</a> <a class="diff" rel="nofollow" href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=php-doc.el">(diff)</a></span><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
