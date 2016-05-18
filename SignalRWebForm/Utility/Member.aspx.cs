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

public partial class _Utility_Member : System.Web.UI.Page
{
    public UserInfo onwer;
    public string PageFace = "";
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageDiz = "";
    public string PageAtt = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try {
        #region 用户信息与标题部分

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

        onwer = Users.Find(iduser);
        if (onwer == null) onwer = new UserInfo();

        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\">填写简介...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA的博客</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA的相册</a></div>";
        if (idbrowse == onwer.id)
        {
            //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发博客</a></div>";
            //PageGuide += "<div class=\"v2\"><a href=\"/member/\">个人信息</a></div>";
        }

        int groupIndex = 0;
        if (Request.QueryString["group"] != null)
        {
            groupIndex = Int32.Parse(Request.QueryString["group"].ToString());
            if (groupIndex < 0) groupIndex = 1;
        }

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 15;
        int pageCount = 0;

        #endregion

        #region 关注信息显示

        if (Request.QueryString["id"] != null)
        {
            if (m.Default != null)
            {
                if (m.Default.id > 0 && iduser > 0 && m.Default.id == iduser && pageIndex == 1)
                {
                    Attention at = new Attention();
                    Hashtable hash = at.GetAttentions(m.Default.id);

                    Discuss diz = new Discuss();
                    PageDiz = diz.MyNotes(m.Default.id, hash);

                    PageAtt = at.MyAttentions(m.Default.id, hash);
                }
            }
        }

        #endregion

        #region 博客底图相关
        PageFace = GCommon.FacePanel(iduser, (m.Default != null) ? m.Default.id : 0);
        #endregion

        #region 缓存机制
        string cacheName = "CACHE_PAGE_MEMBER_" + onwer.id;
        string cacheNameMe = "CACHE_PAGE_MEMBER_ME_" + onwer.id;
        if (pageIndex == 1 && groupIndex == 0)
        {
            if (idbrowse == iduser) PageBuffer = TCache.LoadString(cacheNameMe);
            else PageBuffer = TCache.LoadString(cacheName);
        }
        #endregion

        #region 创建显示内容

        Blog blogs = new Blog();
        if (PageBuffer.Length < 1)
        {
            PageBuffer = blogs.UsersBlog(iduser, idbrowse, groupIndex, pageSize, ref pageIndex, ref pageCount);
        }

        if (PageBuffer.Length > 0)
        {
            if (pageIndex == 1 && groupIndex == 0)
            {
                if (idbrowse == iduser) TCache.SaveString(cacheNameMe, PageBuffer);
                else TCache.SaveString(cacheName, PageBuffer);
            }
        }
        else
        {
            // 没有Focus也没有发博客；显示最新推荐的PublishedBlogs;
            PageBuffer = blogs.NewestBlog(1, 20, "", "");
        }

        #endregion
        }
        catch(Exception ex)
        {
            Response.Redirect("/channels/about/404.aspx");
        }
    }
}
