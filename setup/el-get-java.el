;;; el-get-java.el --- using el-get to auto install helper packages for java development

;; Copyright (C) 2011  Zigler Zhang

;; Author: Zigler Zhang <zigler@VMD.localdomain.baidu.com>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(eval-when-compile
  (require 'cl))
(require 'el-get)
(setq el-get-sources
      '(
	(:name jdee
	       ;; require elib bsh
	       :type svn
	       :url "http://jdee.svn.sourceforge.net/svnroot/jdee/trunk/jdee"
	       :load-path "lisp")))
(el-get 'wait)

(provide 'el-get-java)
;;; el-get-java.el ends here
