using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Blog : System.Web.UI.Page
{
    public string PageFace = "";
    public string PageSubject = "";
    public string PageGuide = "";
    public string PageFocusBlog = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageLoad = "";
    public string PageNext = "";
    public string PageJoiner = "";
    public string PageDiscuss = "";
    public string PageEdit = "";
    public string PageContent = "";
    public BlogInfo blog = new BlogInfo();
    public UserInfo onwer;
    public BlogSummaryInfo summary;
    int pageCount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try {
        Member m = new Member();

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
            if (id < 0) id = 0;
        }

        Blog blogs = new Blog();
        blog = blogs.Load(id, "", "");
        if (blog == null) return;

        onwer = Users.Find(blog.idUser);

        BlogSummary bs = new BlogSummary();
        summary = bs.Load(blog.id, "", "");
        if (summary == null) summary = new BlogSummaryInfo();

        bs.UpdateByCommand(blog.id, "iShowTimes=iShowTimes+1");

        if (onwer == null) onwer = new UserInfo();

        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">填写简介...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }

        PageContent = XString.PublishContent(UBB.ToHtml(blog.cContent));

        PageDiscuss = "您还没有<a href=\"/member/\" style=\"color:#0000EE;\">注册</a>或<a href=\"/member/login.aspx\" style=\"color:#0000EE;\">登录</a>！<br>";

        #region 博客底图相关
        PageFace = GCommon.FacePanel(onwer.id, (m.Default != null) ? m.Default.id : 0);
        #endregion

        #region 是否有相关博客－专题
        BlogLinks link = new BlogLinks();
        List<BlogLinksInfo> items = link.PageList(1, 1, "WHERE idBlog=" + id, "ORDER BY id ASC", out pageCount);
        if (pageCount > 0)
        {
            PageSubject = "<a href=\"" + UrlHelper.SubjectsUrl(id) + "\"><img src=\"/images/subject.gif\" style=\"margin-bottom:-2px;\"></a>";
        }
        #endregion

        #region 赛事,约跑,俱乐部相关信息显示

        if (blog.idHref > 0)
        {
            PageLoad = "<script language=\"javascript\">ShowExtention(" + blog.idHref + ");</script>";

            RaceJoin rj = new RaceJoin();
            PageJoiner = rj.JoinerList(blog.idHref, blog.idUser, (m.Default != null) ? m.Default.id : 0);
        }
        #endregion

        #region 下一篇

        pageCount = 0;
        List<BlogInfo> last = blogs.PageList(1, 2, "WHERE id>" + blog.id + " AND idUser=" + blog.idUser, "ORDER BY id ASC", out pageCount);
        StringBuilder st = new StringBuilder();
        if (pageCount > 0)
        {
            st.AppendLine("上一篇：<a href=\"" + UrlHelper.BlogUrl(last[0].id) + "\">" + last[0].cTitle + "</a><br>");
        }
        else
        {
            st.AppendLine("上一篇：没有了！<br>");
        }
        pageCount = 0;
        List<BlogInfo> next = blogs.PageList(1, 2, "WHERE id<" + blog.id + " AND idUser=" + blog.idUser, "ORDER BY id DESC", out pageCount);
        if (pageCount > 0)
        {
            st.AppendLine("下一篇：<a href=\"" + UrlHelper.BlogUrl(next[0].id) + "\">" + next[0].cTitle + "</a>");
        }
        else
        {
            st.AppendLine("下一篇：没有了！");
        }
        PageNext = st.ToString();
        #endregion

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA的博客</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA的相册</a></div>";

        #region 需要登录用户方才显示的内容相关

        if (m.Default == null) return;
        if (m.Default.id == 0) return;
        MemberInfo browser = m.Default;

        if (browser.id == onwer.id)
        {
            //PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发博客</a></div>";
            //PageGuide += "<div class=\"v2\"><a href=\"/member/\">个人信息</a></div>";
        }

        pageCount = 0;
        Attention at = new Attention();
        //List<AttentionInfo> alist = at.PageList(1, 10, "WHERE idUser=" + browser.id + " AND idInfo=" + blog.idUser, "", out pageCount);
        //if (pageCount > 0)
        //{
        //    PageFocus = "<div class=\"v2a\" onclick=\"FocusErase(" + alist[0].idInfo + ",'" + XString.MD5(alist[0].idInfo.ToString()) + "')\">- 取消关注</div>";
        //}

        PageFocusBlog = "<div class=\"v1a\" onclick=\"FocusCreate(" + id + ",'" + XString.MD5(id.ToString()) + "')\">+ 收藏</div>";

        pageCount = 0;
        List<AttentionInfo> blist = at.PageList(1, 10, "WHERE idUser=" + browser.id + " AND idInfo=" + id, "", out pageCount);
        if (pageCount > 0)
        {
            PageFocusBlog = "<div class=\"v2a\" onclick=\"FocusErase(" + id + ",'" + XString.MD5(id.ToString()) + "')\">- 取消收藏</div>";
        }

        PageFocusBlog += "<div class=\"v2a\" style=\"width:120px;\">+ <a href=\"/utility/write.aspx?from=" + id + "\">发表相关博客</a></div>";

        if (blog.idHref > 0)
        {
            if (blog.idHref.ToString().Substring(0, 1) == "3") PageFocusBlog = PageFocusBlog.Replace("此文", "此赛事");
            if (blog.idHref.ToString().Substring(0, 1) == "4") PageFocusBlog = PageFocusBlog.Replace("此文", "此活动");
            if (blog.idHref.ToString().Substring(0, 1) == "5") PageFocusBlog = PageFocusBlog.Replace("此文", "此装备");
            if (blog.idHref.ToString().Substring(0, 1) == "6") PageFocusBlog = PageFocusBlog.Replace("此文", "此俱乐部");
        }

        StringBuilder sm = new StringBuilder();
        sm.AppendLine("我要评论：<br>");
        sm.AppendLine("<form id=\"form1\" name=\"form1\" action=\"/utility/include/DiscussCreate.aspx\" method=\"post\">");

        for (int i = 1; i < 25; i++)
        {
            sm.AppendLine("<img src=\"/images/emotion/" + String.Format("{0:D2}", i) + ".gif\" onclick=\"EmotionAdd('" + String.Format("{0:D2}", i) + "')\">");
        }

        sm.AppendLine("<input type=\"hidden\" id=\"idBlog\" name=\"idBlog\" value=\"" + blog.id + "\">");
        sm.AppendLine("<textarea id=\"cContent\" name=\"cContent\" cols=\"70\" rows=\"3\" style=\"font-size:14px;padding:5px;\"></textarea><br>");
        sm.AppendLine("<img src=\"/images/submit.gif\" onclick=\"document.form1.submit();return true;\"> ");
        sm.AppendLine("</form>");
        PageDiscuss = sm.ToString();

        #endregion

        if (browser.id == onwer.id)
        {
            PageEdit = "<span onclick=\"BlogEdit(" + blog.id + ")\" style=\"color:#0000EE;\">编辑</span> ";
        }
        }
        catch(Exception ex)
        {
            Response.Redirect("/channels/about/404.aspx");
        }
    }
}
