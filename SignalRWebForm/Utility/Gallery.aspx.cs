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

public partial class _Utility_Gallery : System.Web.UI.Page
{
    public string PageFace = "";
    public UserInfo onwer;
    public string PageGuide = "";
    public string PageBuffer = "<br>呵呵！TA没有发布任何图片！<br><br>&nbsp;";
    public string PageUser = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();

        int iduser = 0;
        if (Request.QueryString["id"] != null)
        {
            iduser = Int32.Parse(Request.QueryString["id"].ToString());
            if (iduser < 0) iduser = 0;
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

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA的博客</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA的相册</a></div>";
        if (m.Default != null)
        {
            if(m.Default.id == iduser)
            {
                //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
                PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
                PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
                PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发博客</a></div>";
                //PageGuide += "<div class=\"v2\"><a href=\"/member/\">个人信息</a></div>";
            }
        }

        #region 博客底图相关
        PageFace = GCommon.FacePanel(onwer.id, (m.Default != null) ? m.Default.id : 0);
        #endregion

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 30;
        int pageCount = 0;

        Images imgs = new Images();
        PageBuffer = imgs.Gallery(iduser, pageSize, ref pageIndex, ref pageCount);
        if (PageBuffer.Length < 1)
        {
               PageBuffer = "<br>呵呵！TA没有发布任何图片！<br><br>&nbsp;";
        }
    }
}
