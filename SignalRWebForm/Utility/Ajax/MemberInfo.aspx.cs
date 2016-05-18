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
            Response.Write("<a class=\"wlogin\" href=\"/Member/\">ע��</a><a class=\"wlogin\">|</a>");
            Response.Write("<a class=\"wlogin\" href=\"/Member/Login.aspx\" >��¼</a>");
            return;
        }

        UserInfo u = Users.Find(m.Default.id);
        if (u != null)
        {
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            StringBuilder sb = new StringBuilder();
        sb.AppendLine("<a class=\"username\" alt=\"username\" href=\"" + UrlHelper.MemberUrl(u.id) + "\"><em>" +CurrentUser.cNickName+ "</em></a>");
        sb.AppendLine("<div class=\"topr vertical\">");
        sb.AppendLine("<span class=\"msgshowa\">�ҵ�����</span>");
        sb.AppendLine("<ul>");
        sb.AppendLine("<li><a href=\"/infocenter/Account.aspx?uId=" + u.id + "\" target=\"_blank\">�ʻ�����</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Message.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowl\">����</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Comments.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowpl\">����</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<!-- <li><a href=\"/infocenter/Default.aspx?uId=" + u.id + "\" target=\"_blank\">�ܽ���Ƭ</a> </li> -->");
        sb.AppendLine("<li><a href=\"/infocenter/Integral.aspx?uId=" + u.id + "\" target=\"_blank\">����</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/Member/Logout.aspx\">�˳���¼</a>");
        sb.AppendLine("</li>");
        if (Admin.IsAdmin())
        {
        sb.AppendLine("<li><a href=\"/Admin/\">�������</a>");
        sb.AppendLine("</li>");          
        }
        if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
        {
            sb.AppendLine("<li><a href=\"/Admin/RaceList.aspx\">���¹���</a>");
            sb.AppendLine("</li>");
        }
        sb.AppendLine("</ul>");
        sb.AppendLine("</div>");
        sb.AppendLine("<div class=\"topr vertical\">");
        sb.AppendLine("<span class=\"msgshowb\">�ҵĺ���</span>");
        sb.AppendLine("<ul>");
        sb.AppendLine("<li><a href=\"/infocenter/Focus.aspx?uId=" + u.id + "\" target=\"_blank\">��ע</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("<li><a href=\"/infocenter/Fans.aspx?uId=" + u.id + "\" target=\"_blank\" class=\"msgshowf\">��˿</a>");
        sb.AppendLine("</li>");
        sb.AppendLine("</ul>");
        sb.AppendLine("</div>");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Write(sb.ToString());

            Session["LOGIN_STATUS"] = "";
        }
        else
        {
            Response.Write("<a class=\"wlogin\" href=\"/Member/\">ע��</a><a class=\"wlogin\">|</a>");
            Response.Write("<a class=\"wlogin\" href=\"/Member/Login.aspx\" >��¼</a>");
        }
    }
}
