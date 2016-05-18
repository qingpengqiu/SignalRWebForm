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

public partial class _Utility_Subjects : System.Web.UI.Page
{
    public string PageFace = "";
    public string PageName = "";
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageBrowser = "0";
    public int SubjectIndex = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        if (m.Default != null)
        {
            PageBrowser = m.Default.id.ToString();
        }

        if (m.Default != null)
        {
            //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发表博客</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/member/\">我的信息</a></div>";
        }
        else
        {
            PageGuide = "<div class=\"v2\"><a href=\"/member/\">注册</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/member/login.aspx\">登录</a></div>";
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
            if (id < 0) id = 0;
            SubjectIndex = id;
        }

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 30;
        int pageCount = 0;

        #region 缓存机制
        string cacheName = "CACHE_PAGE_SUBJECTS_" + id;
        if (pageIndex == 1)
        {
            PageBuffer = ""; //TCache.LoadString(cacheName);
        }
        #endregion

        if (PageBuffer.Length < 1)
        {
            BlogLinks link = new BlogLinks();
            PageBuffer = link.Subjects(id, pageSize, ref pageIndex, ref pageCount, ref PageName);
        }

        if (pageIndex == 1)
        {
            TCache.SaveString(cacheName, PageBuffer);
        }
    }
}
