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
public partial class Controls_Erun_Header_mini : PageBaseCtrl
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
            return;
        }
        cId = CurrentUser.uId;
        cName = CurrentUser.cNickName;
        if (Admin.IsAdmin())
        {
            admin = "<li><a href=\"/Admin/\">管理入口</a></li>";
        }
        if (CurrentUser.uId == 100001183 || CurrentUser.idMemberStyle == 99)
        {
            admin += "<li><a href=\"/Admin/RaceList.aspx\">赛事管理</a></li>";
        }
        if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser =" + CurrentUser.uId) > 0)
        {
            club += "<li><a href=\"" + UrlHelper.ClubUrl(Convert.ToInt32(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId))) + "\" target=\"_blank\" >管理俱乐部</a>";
        }
        else
        {
            club += "<li><a href=\"/infocenter/appClub.aspx\" target=\"_blank\" >创建俱乐部</a>";
        }
    }
}