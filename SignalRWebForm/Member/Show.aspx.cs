using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Member_Show : System.Web.UI.Page
{
    public UserInfo onwer;
    public MemberInfo record = new MemberInfo();
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
        if (idbrowse == onwer.id)
        {
            //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">首页</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">我的博客</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">我的相册</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">发博客</a></div>";
            //PageGuide += "<div class=\"v2\"><a href=\"/member/\">个人信息</a></div>";
        }

        // 读取数据
        Member table = new Member();
        if (Request["id"] != null)
        {
            int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            record = table.Load(recordIndex, "", "");
            if (record == null)
            {
                PageResult = "数据错误(Index error)！";
                return;
            }
        }
        else
        {
            PageResult = "数据错误(Querystring is null)！";
            return;
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */
