using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyDiscuss : System.Web.UI.Page
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

        int pageCount = 0;
        Discuss diz = new Discuss();
        PageBuffer = diz.MyDiscuss(m.Default.id);

        #region 导航信息
        //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
        //PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发博客</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"/member/\">个人信息</a></div>";
        #endregion

    }
}

