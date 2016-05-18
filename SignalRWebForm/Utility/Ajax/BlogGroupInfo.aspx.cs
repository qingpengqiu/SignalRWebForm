using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_BlogGroupInfo : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();

        int id = 0;
        if (Request.QueryString["iduser"] != null)
        {
            id = Int32.Parse(Request.QueryString["iduser"].ToString());
        }
        else
        {
            if (m.Default != null) id = m.Default.id;
        }

        Response.ContentType = "text/html;charset=GB2312";

        int page_count = 0;
        BlogGroup gp = new BlogGroup();
        List<BlogGroupInfo> items = gp.PageList(1, 100, "WHERE idUser=" + id, "ORDER BY id DESC", out page_count);

        StringBuilder sb = new StringBuilder();

        sb.AppendLine("<div id=\"blog_d_top\"></div>");
        sb.AppendLine("<div id=\"blog_d_mid\">");
        sb.AppendLine("<div id=\"blog_d_group\">");

        sb.AppendLine("博客分类:");
        if (m.Default != null)
        {
            if (m.Default.id == id)
            {
                sb.AppendLine("<span style=\"color:#0000EE;font-size:12px;cursor:pointer;\" onclick=\"PopupShow(600, 400, '分类管理', '/Utility/Include/BlogGroupList.aspx');\">+ 管理分类</span>");
            }
        }
        sb.AppendLine("<hr noshade size=\"1\" color=\"#C3C7C9\">");

        foreach (BlogGroupInfo lv in items)
        {
            sb.AppendLine("+ <a href=\"" + UrlHelper.MemberUrl(id,lv.id,1) + "\">" + lv.cTitle + "(" + lv.iNumber + ")</a><br>");
        }

        sb.AppendLine("</div>");
        sb.AppendLine("<div id=\"blog_d_clear\"></div>");
        sb.AppendLine("</div>");
        sb.AppendLine("<div id=\"blog_d_bot\"></div>");

        Response.Write(sb.ToString());

    }
}
