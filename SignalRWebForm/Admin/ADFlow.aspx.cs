using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;
using System.Data;
public partial class Admin_ADFlow : PageBase
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
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 30000);
        if (!IsPostBack)
        {
            BindChannel();

            ddlChannel.SelectedValue = id.ToString();
            DataSet ds = new DB2.tblADFlow().GetList(0, "idChannel=" + id, "idChannel,iPage,iIndex,dEndtime desc");
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }
    }
    public string GetChannelName(string idChannel)
    {
        int id = TypeChangeDefault.NullToInt(idChannel, 0);
        DBM2.tblChannel model = new DB2.tblChannel().GetModel(id);
        if (model != null)
        {
            return model.cName;
        }
        return "";
    }
    protected void BindChannel()
    {
        DataTable dt = new DB2.tblChannel().GetList(0, "iStatus=1", "iSort desc").Tables[0];
        ddlChannel.DataSource = dt;
        ddlChannel.DataTextField = "cName";
        ddlChannel.DataValueField = "id";
        ddlChannel.DataBind();
    }
    protected void ddlChannel_SelectedIndexChanged(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 30000);
        Response.Redirect("ADFlow.aspx?id=" + id);
    }
}