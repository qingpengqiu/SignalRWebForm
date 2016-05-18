using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using ERUN360.Entity;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Admin_RaceAdd : PageBase
{
    public string portrait = string.Empty;
    private int id = 0;
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }       
        if (!IsPostBack)
        {
            BindDDLFriends();
            PreLoadInfo();
        }
    }
    protected void BindDDLFriends()
    {
        DataSet ds = new DB6.tblRace_Competition().GetList(" DATEDIFF([second], getdate() , dJoinEnd)>0");
        DDLRace.DataSource = ds;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "id";
        DDLRace.DataBind();
    }
    protected void PreLoadInfo()
    {
        if (id != 0)
        {
            DDLRace.SelectedValue = id.ToString();
        }
        Session["idCompete"] = DDLRace.SelectedValue;

        DataSet ds = new DB6.tblRace_Item().GetList(" and idCompete=" + DDLRace.SelectedValue);
        this.rptrunrecord.DataSource = ds;
        this.rptrunrecord.DataBind();
        if (ds.Tables[0].Rows.Count > 0)
        {
            signingup.Value = Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinEnd"].ToString()).ToString("yyyy-MM-dd");
            portrait = ds.Tables[0].Rows[0]["cURL"].ToString();
        }
        else
        {
            portrait = "/Html/images/up.png";
        }
    }   
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        id = 0;
        PreLoadInfo();
    }
}