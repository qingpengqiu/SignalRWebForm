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
public partial class Admin_SelfService : PageBase
{
    private string itype = "0";
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
            if (rdotype.SelectedIndex > 0)
            {
                itype = rdotype.SelectedValue;
            }
            BindGood(itype);
        }
    }
    protected void BindGood(string itype)
    {
        if ("0" == itype)
        {
            gvCompany.Visible = false;
            gvPerson.Visible = true;
            DataSet ds = new DB4.tblSelfServiceRace().GetList(0, "iStatus>0 and ikind=" + itype, "id desc");
            gvPerson.DataSource = ds;
            gvPerson.DataBind();
        }
        else if ("1" == itype)
        {
            gvCompany.Visible = true;
            gvPerson.Visible = false;
            DataSet ds = new DB4.tblSelfServiceRace().GetList(0, "iStatus>0 and ikind=" + itype, "id desc");
            gvCompany.DataSource = ds;
            gvCompany.DataBind();            
        } 
       
    }
    protected void rdotype_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGood(rdotype.SelectedValue);
    }
}