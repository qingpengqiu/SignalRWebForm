using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public partial class Admin_Plan : PageBase
{
    DB5.tblPlan BLL = new DB5.tblPlan();
    public string idplan = "0";//归属
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
        idplan = TypeChangeDefault.NullToString(Request.QueryString["idplan"], "0");
        if (!IsPostBack)
        {
            BindDDL();
            if (idplan == "0")
            {
                idplan = TypeChangeDefault.NullToString(ddlCode.SelectedValue, "0");
            }
            BindData(idplan);
            ddlCode.SelectedValue = idplan;
        }
    }
    #region 绑定数据
    private void BindData(string code)
    {
        DataTable dt = BLL.GetList(0, "cPanCode='" + code + "'", "iweek,iDay,iOrder").Tables[0];
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }
    protected void BindDDL()
    {
        DataSet ds = BLL.GetPlan("cPanCode");
        ddlCode.DataSource = ds;
        ddlCode.DataTextField = "cPanCode";
        ddlCode.DataValueField = "cPanCode";
        ddlCode.DataBind();
    }
    #endregion
    protected void ddlCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        idplan = TypeChangeDefault.NullToString(ddlCode.SelectedValue, "0");
        Response.Redirect("Plan.aspx?idplan=" + ddlCode.SelectedValue);
        //BindData(ddlCode.SelectedValue);
    }
}