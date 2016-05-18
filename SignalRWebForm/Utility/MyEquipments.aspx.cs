using System;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyEquipments : System.Web.UI.Page
{
    public UserInfo onwer;
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        // 浏览者
        int idbrowse = 0;
        Member m = new Member();
        if (m.Default != null)
        {
            idbrowse = m.Default.id;
        }

        // 博主
        int iduser = 0;
        if (Request.QueryString["id"] != null)
        {
            iduser = Int32.Parse(Request.QueryString["id"].ToString());
            if (iduser < 0) iduser = 0;
        }
        else
        {
            if (m.Default != null)
            {
                iduser = m.Default.id;
            }
        }

        if(iduser <= 0)
        {
            Response.Redirect("/Member/");
        }

        onwer = Users.Find(iduser);
        if (onwer == null) onwer = new UserInfo();

        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">填写简介...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 15;
        int pageCount = 0;

        string qry = "me";
        if(Request.QueryString["cmd"]!=null)
        {
            qry = Request.QueryString["cmd"].ToString().ToLower();
        }

        Blog blogs = new Blog();
        PageBuffer = blogs.UsersAttentions("Equipments", qry, onwer.id, idbrowse, pageSize, ref pageIndex, ref pageCount);

        if (PageBuffer.Length < 1)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div id=\"blog_m_top\"></div>");
            sb.AppendLine("<div id=\"blog_m_mid\">");
            sb.AppendLine("没有找到合适的装备信息！<br>");
            sb.AppendLine("<br>");
            sb.AppendLine("通过[关注]其它跑友可更方便地获取装备信息！<br>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_m_bot\"></div>");
            sb.AppendLine("<div id=\"blog_m_spc\"></div>");
            PageBuffer = sb.ToString();
        }

        #region 导航信息
        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA的博客</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA的相册</a></div>";
        if (idbrowse == onwer.id)
        {
            PageGuide = "<div class=\"v2\"><a href=\"?cmd=me\">我的装备</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">我关注的装备</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx?cmd=equipment\">发装备</a></div>";
        }
        #endregion
    }
}
