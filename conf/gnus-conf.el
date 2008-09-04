(defun prefer-gb2312 ()
  (setq mm-coding-system-priorities
        '(iso-8859-15 gb2312 utf-8)))
(defun prefer-utf-8 ()
  (setq mm-coding-system-priorities
        '(iso-8859-15 utf-8)))

(setq gnus-posting-styles
      '((".*"
         (name "fireinice")
         (From "fireinice@gmail.com")
;; 	 (signature-file "~/.sig/default")
         (eval (prefer-gb2312)))
        ("^cn\\.bbs.*"
         (name "fireinice")
         (From "fireinice <fireinice@gmail.com>")
         (eval (prefer-gb2312)))
        ("otherbbs"
         (name "fireinice")
         (From "fireinice <fireinice@gmail.com>")
         (eval (prefer-utf-8)))))
;;用户资料设定
(setq user-full-name "fireinice")
(setq user-mail-address "fireinice@gmail.com")

;;服务器的设定
(setq gnus-select-method '(nntp "news.CN99.com"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.newsfan.net"))
;(add-to-list 'gnus-secondary-select-methods '(nntp "news.php.net"))
;(add-to-list 'gnus-secondary-select-methods '(nntp "news.newsgroup.com.hk"))
;; (add-to-list 'gnus-secondary-select-methods '(nntp "news.yaako.com"))
;; (add-to-list 'gnus-secondary-select-methods '(nntp "groups.google.com"))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gmane.org"))
;; (add-to-list 'gnus-secondary-select-methods '(nntp "groups.google.com"))

(setq gnus-default-charset 'cn-gb-2312
gnus-group-name-charset-group-alist '((".*" . cn-gb-2312))
;; gnus-group-name-charset-method-alist '(((nntp "news.newsfan.net") . cn-gb-2312))
;; 有时候遇到 big5 的按一下 2 g 就能很容易的搞定
gnus-summary-show-article-charset-alist '((1 . cn-gb-2312) (2 . big5))
;;gnus-newsgroup-ignored-charsets '(unknown-8bit x-unknown iso-8859-1)
)

;; Define how Gnus is to read your mail.  We read mail from
;; your ISP's POP server.
;; (setq mail-sources '((pop :server "pop.your-isp.com")))

;; Say how Gnus is to store the mail.  We use nnml groups.
;; (setq gnus-secondary-select-methods '((nnml "")))

;;;;; 各种各样的变量设置 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; 很多设置，其中由一些也是缺省值，留作参考；在变量名上按 C-h v RET
;;;;; 就能知道是作什么用的了。
(setq gnus-auto-select-subject 'unread
;; gnus-auto-select-first nil
;; gnus-read-active-file nil
      gnus-read-newsrc-file nil
      gnus-save-newsrc-file nil
;; gnus-save-killed-list nil
;; gnus-asynchronous t
;; 看看 gnus 在做什么，每50封显示一下
      gnus-summary-display-while-building 50
;; gnus-summary-display-arrow nil
;; gnus-always-read-dribble-file t
      gnus-confirm-mail-reply-to-news t
      gnus-gcc-mark-as-read t ;; Archive的组自动标记为已读
      gnus-gcc-externalize-attachments 'all ;; 自己附件不做 Archive
;; 只处理最后一部分（body?）的空行，
      gnus-treat-strip-trailing-blank-lines 'last
      gnus-treat-strip-leading-blank-lines 'last
      gnus-treat-strip-multiple-blank-lines 'last)
;; 在 X 下的时候，不要把表情符号翻译为图形
;; gnus-treat-display-smileys nil)
;; 这些都是我的地址，稍微改了改，如果你直接 copy 的，别忘了改啊。设置这
;; 个，在 mail group 里面就不用看自己的名字和地址，而是发送的地址了。
(setq gnus-ignored-from-addresses
(regexp-opt '("dddkk@sina.com"
"sss@aa.lala.cn"
"sss@bb.lalalala.cn"
"chunyu@hhh.hhh")))

;; 索性认为 gb18030 也是 gb2312 罢。
;; (define-coding-system-alias 'gb18030 'gb2312)
;; Archive 的组，按news和mail分开，再按月分。
(setq gnus-message-archive-group
      '((if (message-news-p)
	    (concat "news." (format-time-string "%Y-%m"))
	  (concat "mail." (format-time-string "%Y-%m")))))

(unless window-system
;;;; 突出显示自己发送的帖子和别人回应我的帖子。参考这里设置的：
;; http://my.gnus.org/Members/dzimmerm/HowTo%2C2002-07-25%2C1027619165012198456/view
  (require 'gnus-sum)
  (defface chunyu-gnus-own-related-posting-face nil "Postings by myself.")
  (set-face-attribute 'chunyu-gnus-own-related-posting-face nil :foreground "red" :weight 'bold)
  (add-to-list 'gnus-summary-highlight
	       '((and
		  (> score 6500)
		  (eq mark gnus-unread-mark)) . chunyu-gnus-own-related-posting-face))
  (eval-after-load "gnus-cite"
    '(progn
       (set-face-attribute 'gnus-cite-face-2 nil :foreground "magenta")
       (set-face-attribute 'gnus-cite-face-3 nil :foreground "yellow")
       (set-face-attribute 'gnus-cite-face-4 nil :foreground "cyan"))))

;;;;; group parameters 还没建设好，呵呵
(setq gnus-parameters
;; 按我的邮件分类分别设置不同的 group parameters
      '(("list\\..*" (subscribed . t))
	("misc\\..*" (auto-expire . t))))

;;;;; 喜欢用 Supercite，可以有多种多样的引文形式 ;;;;;;;;;;;;;;;;;;;;;
(setq sc-attrib-selection-list nil
      sc-auto-fill-region-p nil
      sc-blank-lines-after-headers 1
      sc-citation-delimiter-regexp "[>]+\\|\\(: \\)+"
      sc-cite-blank-lines-p nil
      sc-confirm-always-p nil
      sc-electric-references-p nil
      sc-fixup-whitespace-p t
      sc-nested-citation-p nil
      sc-preferred-header-style 4
      sc-use-only-preference-p nil)
(setq mail-self-blind t
      message-from-style 'angles
      message-kill-buffer-on-exit t
      message-cite-function 'sc-cite-original
      message-elide-ellipsis " [...]\n"
      message-sendmail-envelope-from nil
;;有时候肯能需要这个两个变量，比如没有启动 Gnus 的时候打开邮件
      message-signature t
      message-signature-file "~/.sig/default"
      message-forward-as-mime nil ;; 转发不喜欢用附件邮件，还是直接的内容比较好
;; 也不喜欢内容里面由太多的邮件头信息，如果有一个
;; message-forward-with-headers 变量，这里就不用这么麻烦了 :(
      message-forward-ignored-headers
      (concat
       "^X-\\|^Old-\\|^Xref:\\|^Path:\\|^[Cc]c:\\|^Lines:\\|^Sender:"
       "\\|^Thread-\\|^[GB]cc:\\|^Reply-To:\\|^Received:\\|^User-Agent:"
       "\\|^Message-ID:\\|^Precedence:\\|^References:\\|^Return-Path:"
       "\\|^Cancel-Lock:\\|^Delivered-To:\\|^Organization:\\|^content-class:"
       "\\|^Mail-Copies-To:\\|^Return-Receipt-To:\\|^NNTP-Posting-Date:"
       "\\|^NNTP-Posting-Host:\\|^Content-Transfer-Encoding:"
       "\\|^Disposition-Notification-To:\\|^In-Reply-To:\\|^List-"
       "\\|^Status:\\|^Errors-To:\\|FL-Build:"))
;;;;; 压缩保存的邮件
(setq nnml-use-compressed-files t)
;;;;; 邮件分类 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; 如果由重复，删除！
(setq nnmail-treat-duplicates 'delete
      nnmail-crosspost nil ; 同一个邮件不要到多个组
      nnmail-split-methods 'nnmail-split-fancy ; 这个分类方法比较灵活
      nnmail-split-fancy-match-partial-words t ; 单词部分匹配也算成功匹配
      nnmail-split-fancy
      '(| ;; 根据 mailing list 分类
	(any "emacs-devel@gnu.org" "list.emacs-devel")
	(any "guile-user@gnu.org" "list.guile-user")
	(any "guile-sources@gnu.org" "list.guile-sources")
	(any "ding@gnus.org" "list.ding")
	(any "fetchmail-friends" "list.fetchmail")
	(any "zope@zope.org" "list.zope")
	(to "chunyu@hhh.hhh\\|dddkk@sina.com\\|sss@aa" ;; 直接给我的再分类
	    (| (from "bbs@bbs" "mail.bbs") ;; 从 bbs 给自己转发的邮件
	       ;; ... 这里省去了一些 (from ...)
	       (from "m_pupil@yahoo.com.cn" "mail.friends") ;; It's me FKtPp ;)
	       "mail.misc")) ;; 匹配不上
	"misc.misc")) ;; 这里或许是 junk 了
;; topic mode 参考这里：(info "(gnus)Group Topics") ;;;;;;;;;;;;;;;;;;
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'message-mode-hook
	  (lambda ()
	    (setq fill-column 72)
	    (turn-on-auto-fill)))

;; 改变阅读新闻时窗口的布局，窗口划分为上3下7（比例）
(gnus-add-configuration '(article
			  (vertical 1.0
				    (summary .3 point)
				    (article 1.0))))

;;开启记分
(setq gnus-use-adaptive-scoring t)
(setq gnus-save-score t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)

(defvar gnus-default-adaptive-score-alist
'((gnus-kill-file-mark (from -10))
(gnus-unread-mark)
(gnus-read-mark (from 10) (subjnnect 30))
(gnus-catchup-mark (subject -10))
(gnus-killed-mark (from -1) (subject -30))
(gnus-del-mark (from -2) (subject -15))
(gnus-ticked-mark (from 10))
(gnus-dormant-mark (from 5))))

(setq gnus-score-find-score-files-function
'(gnus-score-find-hierarchical gnus-score-find-bnews bbdb/gnus-score)
gnus-use-adaptive-scoring t)

;;;
(setq gnus-confirm-mail-reply-to-news t
message-kill-buffer-on-exit t
message-elide-ellipsis "[...]\n"
)

;;排序
(setq gnus-thread-sort-functions
'(
(not gnus-thread-sort-by-date)
(not gnus-thread-sort-by-number)
))

;; 新闻组分组
;; 有时订阅了很多新闻组，堆在一起不好管理。这个功能可以创建目录来分层管理
;; 这些新闻组。
;; group topic
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)



;; 现在可以在group buffer里面M-x gnus-topic-create-topic来创建一个"topic"，
;; 然后将某个新闻组或者其他topic给C-k掉，再移动到你创建的topic下C-y，就可以
;; 将它们收到这个topic下。
;; topic的好处除了分层之外，还有就是可以将不常看的topic折叠起来，不要显示。
;; 就像下面这样。
;;
;; [ Gnus -- 0 ]
;; [ MAIL -- 3 ]...
;; [ NEWS -- 0 ]
;; [ emacs -- 0 ]
;; *: nntp+binghe.6600.org: gnu.emacs.help
;; *: nntp+binghe.6600.org:gnu.emacs.gnus
;; [ 人文与社会 -- 0 ]
;; [ 语言 -- 0 ]
;; *: nntp+news.newsfan.net:教育就业.外语.日语
;; *: nntp+news.newsfan.net: 教育就业.外语.英语
;; [ misc -- 0 ]...
;;
;; 参考 gnus info -> Group Buffer -> Group Topics


;; ;另外，有些用web方式发出的邮件里有html，加入下面的设置，只看其中的
;; ;plain text部分：
;; (eval-after-load "mm-decode"
;; '(progn
;; (add-to-list 'mm-discouraged-alternatives "text/html")
;; (add-to-list 'mm-discouraged-alternatives "text/richtext")))

;; ;;设置头像文件
;; (setq gnus-posting-styles
;; '((".*"
;; (name "YouName")
;; (face "")
;; ;;这个我都是抄老外的，自己找去,在Gnus里看到好的头像，然后到
;; ;;groups.google里把他的字符串贴过来 -_-!
;; (address "YouEmail@gmail.com")
;; (organization "www.emacs.cn")
;; (signature "
;; My name is K T")
;; )
;; ))