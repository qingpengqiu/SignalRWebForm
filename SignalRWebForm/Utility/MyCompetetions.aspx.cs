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

public partial class _Utility_MyCompetetions : System.Web.UI.Page
{
    public MemberInfo u;
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        u = m.Default;
        if (u == null)
        {
            Response.Redirect("/member/");
        }
        #endregion

        #region 简介相关
        UserInfo onwer = Users.Find(u.id);
        if (onwer == null) onwer = new UserInfo();
        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">填写简介...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }
        #endregion

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 15;
        int pageCount = 0;

        Blog blogs = new Blog();
        string qry = "all";
        if(Request.QueryString["cmd"]!=null)
        {
            qry = Request.QueryString["cmd"].ToString().ToLower();
        }
        PageBuffer = blogs.UsersAttentions("Competetions", qry, u.id, u.id, pageSize, ref pageIndex, ref pageCount);

        if (PageBuffer.Length < 1)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div id=\"blog_m_top\"></div>");
            sb.AppendLine("<div id=\"blog_m_mid\">");
            sb.AppendLine("没有找到合适的竞赛信息！<br>");
            sb.AppendLine("<br>");
            sb.AppendLine("通过[关注]其它跑友可更方便地获取竞赛信息！<br>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_m_bot\"></div>");
            sb.AppendLine("<div id=\"blog_m_spc\"></div>");
            PageBuffer = sb.ToString();
        }

        #region 导航信息
        PageGuide = "<div class=\"v2\"><a href=\"?cmd=all\">全部赛事</a></div>"; 
        PageGuide += "<div class=\"v2\"><a href=\"?cmd=join\">我参加的赛事</a></div>"; 
        PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">我关注的赛事</a></div>";
        #endregion
    }
}
