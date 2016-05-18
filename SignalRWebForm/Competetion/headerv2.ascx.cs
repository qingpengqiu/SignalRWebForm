using Erun360.BLL;
using Erun360.Model;
using ERUN360.Entity;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;

public partial class Controls_headerv2 : PageBaseCtrl
{
    //public int uId = 0;//通过参数传递过来的用户id
    public int cId = 0;
    public string cName = string.Empty;
    public string admin = string.Empty;
    public string club = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        //    //通过参数传递过来的用户id：uId
        //    if (Request.QueryString["uId"] != null)
        //    {
        //        uId = int.Parse(Request.QueryString["uId"].ToString());
        //    }
        if (CurrentUser == null)
        {
            ltlstatus.Text = "<a href=\"\" class=\"dla\">注册</a><a class=\"zca\" href=\"javascript:\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">登录</a>";
            return;
        }
        else
        {
            cId = CurrentUser.uId;
            cName = CurrentUser.cNickName;
            ltlstatus.Text = "Hello，<a href=\"/user/" + cId + ".aspx\">" + cName + "</a><i></i><dl><dt><a href=\"/infocenter/Account.aspx?uId=" + cId + "\">帐户管理</a></dt><dt><a href=\"/infocenter/Message.aspx?uId=" + cId + "\">留言</a></dt><dt><a href=\"/infocenter/Comments.aspx?uId=" + cId + "\">评论</a></dt><dt><a href=\"/infocenter/Integral.aspx?uId=" + cId + "\">积分</a></dt><dt><a href=\"/Member/Logout.aspx\">退出登录</a></dt></dl>";
        }
        //if (Admin.IsAdmin())
        //{
        //    admin = "<li><a href=\"/Admin/\">管理入口</a></li>";
        //}
        //if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
        //{
        //    admin += "<li><a href=\"/Admin/RaceList.aspx\">赛事管理</a></li>";
        //}
        //if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser =" + CurrentUser.uId) > 0)
        //{
        //    club += "<li><a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId))) + "\">管理俱乐部</a>";
        //}
        //else
        //{
        //    club += "<li><a href=\"/infocenter/appClub.aspx\">创建俱乐部</a>";
        //}
    }
}