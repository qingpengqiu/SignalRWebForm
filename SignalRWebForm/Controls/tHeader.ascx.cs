using ERUN360.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;

public partial class Controls_tHeader : PageBaseCtrl
{
    public string login = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        if (CurrentUser == null)
        {
            sb.AppendLine("<a class=\"wlogin\" href=\"/Member/register.aspx\">注册</a><a class=\"wlogin\">|</a>");
            sb.AppendLine("<a class=\"wlogin\" href=\"javascript:void(0)\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">登录</a>");
            login = sb.ToString();
            return;
        }
        else
        {
            sb.AppendLine("<a class=\"username\" alt=\"username\" href=\"" + UrlHelper.MemberUrl(CurrentUser.uId) + "\"><em>" + CurrentUser.cNickName + "</em></a>");
            sb.AppendLine("<div class=\"topr vertical\">");
            sb.AppendLine("<span class=\"msgshowa\">我的益跑</span>");
            sb.AppendLine("<ul>");
            sb.AppendLine("<li><a href=\"/infocenter/Account.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\">帐户管理</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/Message.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\" class=\"msgshowl\">留言</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/Comments.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\" class=\"msgshowpl\">评论</a>");
            sb.AppendLine("</li>");
            //sb.AppendLine("<!-- <li><a href=\"/infocenter/Default.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\">跑界名片</a> </li> -->");
            sb.AppendLine("<li><a href=\"/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\">积分</a>");
            sb.AppendLine("</li>");
            if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
            {
                sb.AppendLine("<li><a href=\"/Admin/RaceList.aspx\" target=\"_blank\">赛事管理</a>");
                sb.AppendLine("</li>");
            }
            sb.AppendLine("<li><a href=\"/Member/Logout.aspx\">退出登录</a>");
            sb.AppendLine("</li>");
            if (Admin.IsAdmin())
            {
                sb.AppendLine("<li><a href=\"/Admin/\">管理入口</a>");
                sb.AppendLine("</li>");
            }
            sb.AppendLine("</ul>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div class=\"topr vertical\">");
            sb.AppendLine("<span class=\"msgshowb\">我的好友</span>");
            sb.AppendLine("<ul>");
            sb.AppendLine("<li><a href=\"/infocenter/Focus.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\">关注</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/Fans.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\" class=\"msgshowf\">粉丝</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/recom.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\" >编辑推荐</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/findpeople.aspx?uId=" + CurrentUser.uId + "\" target=\"_blank\" >查找好友</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("</ul>");
            sb.AppendLine("</div>");
            
            sb.AppendLine("<div class=\"topr vertical\">");
            sb.AppendLine("<span>&nbsp;&nbsp;俱乐部&nbsp;&nbsp;&nbsp;</span>");
            sb.AppendLine("<ul>");
            sb.AppendLine("<li><a href=\"/infocenter/ClubJoin.aspx\" target=\"_blank\">我加入的</a>");
            sb.AppendLine("</li>");
            sb.AppendLine("<li><a href=\"/infocenter/SearchClub.aspx\" target=\"_blank\" >搜索俱乐部</a>");
            sb.AppendLine("</li>");
            if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser =" + CurrentUser.uId) > 0)
            {
                sb.AppendLine("<li><a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId )))+ "\" target=\"_blank\" >管理俱乐部</a>");
            }
            else
            {
                sb.AppendLine("<li><a href=\"/infocenter/appClub.aspx\" target=\"_blank\" >创建俱乐部</a>");
            }
            
            sb.AppendLine("</li>");
            sb.AppendLine("</ul>");
            sb.AppendLine("</div>");

            Session["LOGIN_STATUS"] = "";
            login = sb.ToString();
        }
    }
}