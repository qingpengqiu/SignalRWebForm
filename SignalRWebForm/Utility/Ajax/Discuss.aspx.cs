using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_Discuss : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }

        int pageCount = 0;
        Discuss board = new Discuss();
        List<DiscussInfo> list = board.PageList(id, 1, 50, "WHERE idInfo=" + id, "ORDER BY id DESC", out pageCount);
        if (pageCount == 0) { Response.Write("还没有评论！"); return; }

        StringBuilder sb = new StringBuilder();
        foreach (DiscussInfo du in list)
        {
            sb.AppendLine("<div id=\"blog_diz\">");
            sb.AppendLine("<div id=\"blog_diz_img\">");

            UserInfo u = Users.Find(du.idUser);
            if (u == null)
            {
                sb.AppendLine("<img src=\"/images/noname.gif\" width=\"60\" height=\"60\">");
            }
            else
            {
                sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(u.id) + "\"><img src=\"" + u.cAvatar + "\" width=\"60\" height=\"60\"></a>");
            }
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_diz_mem\">");
            sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(du.idUser) + "\">" + du.cLoginName + "</a> " + du.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "<br>");
            sb.AppendLine( UBB.MoodToHtml(du.cContent) + "");
            sb.AppendLine("</div>");
            sb.AppendLine("</div>");
        }

        Response.Write(sb.ToString());
    }
}
