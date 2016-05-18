using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Ajax_MemberInfo : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("<a class=\"wlogin\" href=\"/Member/\">注册</a><a class=\"wlogin\">|</a>");
            Response.Write("<a class=\"wlogin\" href=\"/Member/Login.aspx\" >登录</a>");
            return;
        }

        UserInfo u = Users.Find(m.Default.id);
        if (u != null)
        {
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            StringBuilder sb = new StringBuilder();
        sb.AppendLine("<a class=\"username\" alt=\"username\" href=\"" + UrlHelper.MemberUrl(u.id) + "\"><em>" +CurrentUser.cNickName+ "</em></a>");
        sb.AppendLine("<div class=\"topr vertical\">");
        sb.AppendLine("<span class=\"msgshowa\">我的益跑</span>");
        sb.AppendLine("<ul>");
        sb.AppendLine("<li><a href=\"/infocenter/Account.aspx?uId=" + u.id + "\" target=\"_blank\">帐户管理</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Message.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowl\">留言</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Comments.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowpl\">评论</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<!-- <li><a href=\"/infocenter/Default.aspx?uId=" + u.id + "\" target=\"_blank\">跑界名片</a> </li> -->");
        sb.AppendLine("<li><a href=\"/infocenter/Integral.aspx?uId=" + u.id + "\" target=\"_blank\">积分</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/Member/Logout.aspx\">退出登录</a>");
        sb.AppendLine("</li>");
        if (Admin.IsAdmin())
        {
        sb.AppendLine("<li><a href=\"/Admin/\">管理入口</a>");
        sb.AppendLine("</li>");          
        }
        if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
        {
            sb.AppendLine("<li><a href=\"/Admin/RaceList.aspx\">赛事管理</a>");
            sb.AppendLine("</li>");
        }
        sb.AppendLine("</ul>");
        sb.AppendLine("</div>");
        sb.AppendLine("<div class=\"topr vertical\">");
        sb.AppendLine("<span class=\"msgshowb\">我的好友</span>");
        sb.AppendLine("<ul>");
        sb.AppendLine("<li><a href=\"/infocenter/Focus.aspx?uId=" + u.id + "\" target=\"_blank\">关注</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Fans.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowf\">粉丝</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("</ul>");
        sb.AppendLine("</div>");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Write(sb.ToString());

            Session["LOGIN_STATUS"] = "";
        }
        else
        {
            Response.Write("<a class=\"wlogin\" href=\"/Member/\">注册</a><a class=\"wlogin\">|</a>");
            Response.Write("<a class=\"wlogin\" href=\"/Member/Login.aspx\" >登录</a>");
        }
    }
}
