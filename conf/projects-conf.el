;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Emacs-Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Filename: projects-conf.el
;; Author: Zhiqiang.Zhang
;; Description: 
;; Created: 五 10月 24 13:15:50 2008 (CST)
;;           By: Zhiqiang.Zhang
;; Last-Updated: 五 11月  7 14:39:23 2008 (CST)
;;     Update #: 25
;; 
;; 
;;; Change log:
;; 

(require 'mk-project)

(project-def "nlayout"
      '((basedir "/home/zigler/work/v2_parser/c++/nlayout/")
        (src-patterns ("*.cc"))
        (ignore-patterns ("*.o"))
;;         (tags-file "/home/me/my-proj/TAGS")
        (file-list-cache "/home/zigler/work/v2_parser/c++/nlayout/.my-proj-files")
        (git-p t)
        (compile-cmd "make")
;;         (startup-hook myproj-startup-hook)
        (shutdown-hook nil)))

(project-def "cssparser"
	     '((basedir "/home/zigler/work/v2_parser/c++/css-parser/")
        (src-patterns ("*.cc"))
        (ignore-patterns ("*.o"))
;;         (tags-file "/home/me/my-proj/TAGS")
        (file-list-cache "/home/zigler/work/v2_parser/c++/css-parser/.my-proj-files")
        (git-p t)
        (compile-cmd "make")
;;         (startup-hook myproj-startup-hook)
        (shutdown-hook nil)))

;; (defun myproj-startup-hook ()
;;   (find-file "/home/me/my-proj/foo.el"))

(project-def "webkit"
      '((basedir "/home/zigler/work/WebKit/")
        (src-patterns ("*.cpp"))
        (ignore-patterns ("*.o"))
;;         (tags-file "/home/me/my-proj/TAGS")
        (file-list-cache "/home/zigler/work/WebKit/.my-proj-files")
;;         (git-p t)
;;         (compile-cmd "make")
;;         (startup-hook myproj-startup-hook)
        (shutdown-hook nil)))

;; (global-set-key (kbd "C-c p c") 'project-compile)
;; (global-set-key (kbd "C-c p g") 'project-grep)
;; (global-set-key (kbd "C-c p l") 'project-load)
;; (global-set-key (kbd "C-c p u") 'project-unload)
;; (global-set-key (kbd "C-c p f") 'project-find-file)
;; (global-set-key (kbd "C-c p i") 'project-index)
;; (global-set-key (kbd "C-c p s") 'project-status)
;; (global-set-key (kbd "C-c p h") 'project-home)
;; (global-set-key (kbd "C-c p d") 'project-dired)
;; (global-set-key (kbd "C-c p t") 'project-tags)
