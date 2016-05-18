using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public partial class Admin_ADPosition : PageBase
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle < 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        DataSet ds = new DataSet();
        if (id != 0)
        {
            ds = new DB2.tblADPosition().GetList(0, "idCode=" + id, "idCode,idPosition");
        }
        else
        {
            //ds = new DB2.tblADPosition().GetList(0, "", "iADType,idPosition");
            ds = new DB2.tblADPosition().GetList(0, "", "idCode,idPosition");
        }

        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
}