;; 在 Muse 输出为 html 的格式里面使用语法高亮

(require 'htmlize)
(require 'muse)

;; 让编辑的时候 src 标签显示得和 example 标签一样，并且里面不进行格式解析
(require 'muse-colors)
(add-to-list 'muse-colors-tags
             '("src" t t t muse-colors-example-tag))

(defvar kid-muse-srctag-output-method 'css
  "控制是以 css 方式输出还是以老式的直接使用 <font>、<i> 等标签的方式输出")
(defvar kid-muse-srctag-css-output-styles t
  "如果使用 css 方式的话，是否在当前 tag 处输出根据当前 color-theme 生成的 style 。
因为有可能在一个统一的 css 文件里面手工定义各种类型的关键字显示效果。")

(setq kid-muse-srctag-modes-alist
  '(("c" . c-mode)
    ("cpp" . c++-mode)
    ("elisp" . emacs-lisp-mode)
    ("common-lisp" . lisp-mode)
    ("scheme" . scheme-mode)
    ("python" . python-mode)
    ("sawfish-lisp" . sawfish-mode)
    ("shell-script" . shell-script-mode)
    ("html" . html-mode)
    ("css" . css-mode)
    ("mail" . mail-mode)
    ("conf" . conf-mode)
    ("patch" . diff-mode)
    ("conf" . conf-mode)
    ("latex" . latex-mode)              ; not the heavy AuCTeX's LaTeX-mode
    ("skribe" . skribe-mode)
    ("makefile" . makefile-mode)))

;; 新版本的 Muse 已经具有了处理 src tag 的功能，但是语法和我自己的这个
;; 有一些区别，为了保持向后兼容性，使用我自己的函数进行处理。
(if (assoc "src" muse-html-markup-tags)
    (setcdr (assoc "src" muse-html-markup-tags)
            '(t t nil kid-muse-srctag))
  (add-to-list 'muse-html-markup-tags
               '("src" t t nil kid-muse-srctag)))

(defun kid-muse-srctag (beg end attrs)
  "generate html representation of source code with syntax
  highlighting using htmlize.el."
  (goto-char beg)
  (let* ((mode (or (cdr (assoc "type" attrs)) "nil"))
         (mode-func (or (cdr (assoc mode kid-muse-srctag-modes-alist))
                        (cdr (find-if (lambda (pair)
                                        (save-match-data
                                          (string-match (car pair) mode)))
                                      auto-mode-alist))
                        'fundamental-mode))
         (text (delete-and-extract-region beg end)))
    (save-restriction
      (narrow-to-region (point) (point))
      (insert
       (with-temp-buffer
         (insert text)
         (funcall mode-func)
         ;; the following is copy and modified from htmlize.el
         (font-lock-fontify-buffer)
         (run-hooks 'htmlize-before-hook)
         (htmlize-ensure-fontified)
         (clrhash htmlize-extended-character-cache)
         (let* ((buffer-faces (htmlize-faces-in-buffer))
                 (face-map (htmlize-make-face-map
                            (adjoin 'default
                                    buffer-faces)))
                 (htmlbuf (get-buffer-create
                           (generate-new-buffer-name " *temp")))
                next-change text face-list fstruct-list)
           (goto-char (point-min))
           (with-current-buffer htmlbuf
             (let ((fstruct (gethash 'default face-map)))
               (insert "<pre class=\"src\""
                       (if kid-muse-srctag-css-output-styles
                           (concat " style=\"background-color:"
                                   (htmlize-fstruct-background fstruct)
                                   ";color:"
                                   (htmlize-fstruct-foreground fstruct)
                                   ";\">")
                           ">"))
               (when (and (eq kid-muse-srctag-output-method 'css)
                          kid-muse-srctag-css-output-styles)
                 (insert "<style type=\"text/css\"><!-- ")
                 (dolist (face (sort* (copy-list buffer-faces) #'string-lessp
                                      :key (lambda (f)
                                             (htmlize-fstruct-css-name (gethash f face-map)))))
                   (let* ((fstruct (gethash face face-map))
                          (cleaned-up-face-name
                           (let ((s
                                  ;; Use `prin1-to-string' rather than `symbol-name'
                                  ;; to get the face name because the "face" can also
                                  ;; be an attrlist, which is not a symbol.
                                  (prin1-to-string face)))
                             ;; If the name contains `--' or `*/', remove them.
                             (while (string-match "--" s)
                               (setq s (replace-match "-" t t s)))
                             (while (string-match "\\*/" s)
                               (setq s (replace-match "XX" t t s)))
                             s))
                          (specs (htmlize-css-specs fstruct)))
                     (insert "      ." (htmlize-fstruct-css-name fstruct))
                     (if (null specs)
                         (insert " {")
                         (insert " {\n        /* " cleaned-up-face-name " */\n        "
                                 (mapconcat #'identity specs "\n        ")))
                     (insert "\n      }\n")))
                 (insert  "    --></style>"))))
           ;; 老式的 <font>、<i> 等方式输出无法支持定义关键字的背景色，
           ;; 因此我决定再支持一种 css 方式，但是这里有一个缺点就是
           ;; css 定义写在哪里，如果统一写到一个 css 文件里面，维护起
           ;; 来很麻烦，因为 css 关键字根据 face 的名字来命名，而在
           ;; Emacs 里面添加新的 package 或者其他操作都可能引进新的
           ;; face 。如果是自动根据当前需要生成 css 代码的话，插入的地
           ;; 方又不好选择了。我看 css 的文档里面都是讲的要插入到
           ;; <header> 中，但是在发布单个 src tag 的时候无法定位到
           ;; header 那里，而且各个 src tag 之间 css 整合也是一个问题。
           ;; 所以我这里直接插入到当前这个 <pre> 标签之后，确实是能够
           ;; 正常显示的，不过前面多出来了一行，所以在这里删除一个换行符
           (when (looking-at "\n")
             (delete-char 1))
           (while (not (eobp))
             (setq next-change (htmlize-next-change (point) 'face))
             (setq face-list (htmlize-faces-at-point)
                   fstruct-list (delq nil (mapcar (lambda (f)
                                                    (gethash f face-map))
                                                  face-list)))
             (setq text (htmlize-buffer-substring-no-invisible
                         (point) next-change))
             (setq text (htmlize-untabify text (current-column)))
             (setq text (htmlize-protect-string text))
             (when (> (length text) 0)
               (if (eq kid-muse-srctag-output-method 'css)
                   (htmlize-css-insert-text text fstruct-list htmlbuf)
                   (htmlize-font-insert-text text fstruct-list htmlbuf)))
             (goto-char next-change))
           (run-hooks 'htmlize-after-hook)
           (setq text (with-current-buffer htmlbuf (buffer-string)))
           (kill-buffer htmlbuf)
           text)))
      (insert "</pre>")
      (muse-publish-mark-read-only (point-min) (point-max))
      (goto-char (point-max)))))

;; 60muse-srctag.el ends here
