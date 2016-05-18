using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
public partial class Admin_Team : PageBase
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
            BindRace();
            if (ddlRace.Items.Count > 0)
            {
                BindItem(ddlRace.SelectedValue);
                //ddlRace.Items[0].Selected = true;

                if (ddlRace.Items.Count > 0)
                {
                    rdlItem.Items[0].Selected = true;
                    BindGV(rdlItem.SelectedValue);
                }
            }
        }
    }
    protected void BindRace()
    {
        DataSet ds = new DB4.tblTeam_Group().GetRace("");
        ddlRace.DataSource = ds;
        ddlRace.DataTextField = "cName";
        ddlRace.DataValueField = "idCompete";
        ddlRace.DataBind();
    }
    protected void BindItem(string idRace)
    {
        DataSet ds = new DB4.tblTeam_Group().GetItem("idCompete=" + idRace);
        rdlItem.DataSource = ds;
        rdlItem.DataTextField = "cItemName";
        rdlItem.DataValueField = "idItem";
        rdlItem.DataBind();
    }
    protected void rdlItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGV(rdlItem.SelectedValue);
    }
    protected void ddlRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindItem(ddlRace.SelectedValue);
    }
    protected void BindGV(string  item)
    {
        DataSet ds = new DB4.tblTeam().GetList(0, "idItem=" + item, "iSNo"); 
        GVmain.DataSource = ds;
        GVmain.DataBind();

    }
}