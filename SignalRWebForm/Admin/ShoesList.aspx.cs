using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
public partial class Admin_ShoesList : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 13 && CurrentUser.uId != 100002818)//添加刘贤娴id：100002818 二乔玉兰
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        if (!IsPostBack)
        {
            DataSet ds = new DB5.tblShoes().GetList(0, "", "id desc,dCreate desc");
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }
    }
}