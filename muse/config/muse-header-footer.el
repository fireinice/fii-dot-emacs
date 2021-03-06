;;;; muse xhtml header
(setq muse-xhtml-header
"<?xml version=\"1.0\" encoding=\"<lisp>
  (muse-html-encoding)</lisp>\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"zh-cn\">
  <head>
    <title><lisp>
        (muse-publishing-directive \"title\")
    </lisp></title>
    <meta name=\"generator\" content=\"Muse\">
    <meta http-equiv=\"<lisp>muse-html-meta-http-equiv</lisp>\"
          content=\"<lisp>muse-html-meta-content-type</lisp>\">
    <link rel=\"stylesheet\" type=\"text/css\" charset=\"utf-8\" media=\"all\"
          href=\"<lisp>(ywb-muse-relative-path \"common/stylesheets/core.css\")</lisp>\" />
    <link rel=\"made\" href=\"mailto:fireinice[AT]gmail.com\" />
    <link rel=\"shortcut icon\" href=\"<lisp>(ywb-muse-relative-path \"common/images/my-icon.ico\")</lisp>\" >
  </head>
  <body>
    <h1><lisp>
        (muse-publishing-directive \"title\")
    </lisp>
   <!-- Google Search -->
     <div class=\"searchbar\">
        <form id=\"searchbar\" method=\"get\" action=\"http://www.google.com/custom\" title=\"My Site Search\">
           <div id=\"searchbar\">
              <label for=\"q\" title=\"Search this site\">
                     <img src=\"<lisp> (ywb-muse-relative-path \"common/images/google.gif\")</lisp>\" ></label>
               <input type=hidden name=domains value=\"http://firelines.cn/\">
               <input type=hidden name=sitesearch value=\"http://firelines.cn/\">
              <input type=\"text\" id=\"q\" name=\"q\" accesskey=\"s\" size=\"16\">
              <input type=\"submit\" id=\"submit\" value=\"Go\">
           </div>
        </form>
     </div>
   <!-- Google Search -->
  </h1>
   <!-- menu start here -->
     <div class=\"menu\">
        <div class=\"menuitem\">
          <a href=\" <lisp> (ywb-muse-relative-path \"index.html\")</lisp>\">Home</a>
        </div>
        <div class=\"menuitem\">
          <a href=\" <lisp> (ywb-muse-relative-path \"wiki/index.html\")</lisp>\">WiKiNotes</a>
        </div>
      </div>
    <!-- menu ends here -->
 <!-- Page published by Emacs Muse begins here -->


")
;;;;  muse xhtml-footer
(setq muse-xhtml-footer "
<!-- Page published by Emacs Muse ends here -->
    <div class=\"navfoot\">
      <hr>
      <table summary=\"Footer navigation\" width=\"100%\" border=\"0\" >
        <col width=\"33%\"><col width=\"34%\" ><col width=\"33%\" >
        <tbody>
          <tr>
          <td align=\"left\">
            <span class=\"footdate\">
              Updated:
              <lisp>
                (format-time-string \"%4Y-%2m-%2d-%T\"
                (nth 5 (file-attributes
                muse-publishing-current-file)))
              </lisp>
          </td>
          <td align=\"center\">
            <span class=\"foothome\">
              <lisp>
                (concat
                \"[ <a href=\"
                (ywb-muse-relative-path \"index.html\")
                \">Home</a> | <a href=\"
                (muse-wiki-resolve-project-page (muse-project))
                \">\" (car (muse-project)) \"</a>\"
                \" | <a href=\"
                (muse-wiki-resolve-project-page (muse-project) \"WikiIndex\")
                \">WikiIndex</a> ]\")
            </lisp>
            </span>
          </td>
          <td align=\"right\">
             <a href=\"mailto:fireinice@gmail.com\"><img style=\"border: 0em none ;\"
             src=\" <lisp> (ywb-muse-relative-path \"common/images/fireinice_gmail.png\")</lisp> \" alt=\"My Email\"></a>
          </td>
          </tr>
        </tbody>
      </table>
      <a href=\"http://www.debian.org/\"><img style=\"border: 0em none ;\"
             src=\" <lisp> (ywb-muse-relative-path \"common/images/powered_by_debian.png\")</lisp> \" alt=\"Debian Logo\"></a>
      <a href=\"http://www.gnu.org/software/emacs/emacs.html\">
        <img style=\"border: 0em none ;\"
                src=\" <lisp> (ywb-muse-relative-path \"common/images/powered_by_GNU_Emacs.jpg\")</lisp> \" alt=\"Emacs Logo\"></a>
      <a href=\"http://www.mwolson.org/projects/EmacsMuse.html\">
        <img style=\"border: 0em none ;\"
                src=\" <lisp> (ywb-muse-relative-path \"common/images/muse-powered-by.png\")</lisp> \" alt=\"Emacs Muse Logo\"></a>
      <a href=\"http://www.emacswiki.org/\"
         style=\"text-decoration: none;\">
        <img src=\" <lisp> (ywb-muse-relative-path \"common/images/emacswiki.png\")</lisp> \" alt=\"Emacswiki.org Logo\"></a>
      <a href=\"http://www.getfirefox.com/\"><img style=\"border: 0em none ;\"
         src=\" <lisp> (ywb-muse-relative-path \"common/images/get_firefox.gif\")</lisp> \" alt=\"Firefox Logo\"></a>
      <a href=\"http://validator.w3.org/check?uri=referer\"
         style=\"text-decoration: none;\">
        <img src=\" <lisp> (ywb-muse-relative-path \"common/images/valid-xh.png\")</lisp> \"
             alt=\"Valid XHTML 1.0!\" height=\"31\" width=\"88\" />
      </a>
      <a href=\"http://jigsaw.w3.org/css-validator/\"
         style=\"text-decoration: none;\">

        <img style=\"border:0;width:88px;height:31px\"
             src=\" <lisp> (ywb-muse-relative-path \"common/images/vcss.gif\")</lisp> \"
             alt=\"Valid CSS!\" />
      </a>
    </div>
  </body>
</html>
")
