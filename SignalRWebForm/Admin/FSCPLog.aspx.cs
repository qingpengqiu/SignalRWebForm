using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Admin_FSCPLog : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            BindDDL();
            BindGV(DDLRace.SelectedValue);
        }
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGV(DDLRace.SelectedValue);
    }
    protected void BindDDL()
    {
        DataSet ds = new DB4.tblRACE_SIGNUP().GetRace("idCompete in (SELECT [idCompete]  FROM [YP_DB_4].[dbo].[tblAnnexLog])");
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "idCompete";
        DDLRace.DataBind();
    }
    private void BindGV(string idRace)
    {
        string StrWhere = "iState >0";
        if (idRace.Trim().Length > 0)
        {
            StrWhere += " and idCompete=" + idRace;
        }
        DataSet ds = new DB4.tblAnnexLog().GetList(StrWhere);
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    public string GetNick(string idUser)
    {
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(Convert.ToInt32(idUser));
        if (model != null)
        {
            return model.cName;
        }
        return "";
    }
    public string GetidItem(string idItem)
    {
        DBM4.tblRACE_SIGNUP model = new DB4.tblRACE_SIGNUP().GetModel(Convert.ToInt32(idItem));
        if (model != null)
        {
            return model.cType;
        }
        return "";
    }
}