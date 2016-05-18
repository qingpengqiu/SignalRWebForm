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

public partial class Admin_ADFixed : PageBase
{
    private int idtpye = 1;
    private int idcode = 0;
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
        idtpye = TypeChangeDefault.NullToInt(Request.QueryString["idtpye"], 1);
        idcode = TypeChangeDefault.NullToInt(Request.QueryString["idcode"], 30000);
        if (!IsPostBack)
        {
            BindChannel();
            //BindClass();
            ddlADtype.SelectedValue = idtpye.ToString();
            if (idtpye == 1)
            {
                ddlChannel.Visible = true;
                ddlClass.Visible = false;
                ddllist.Visible = false;
                ddlChannel.SelectedValue = idcode.ToString();
            }
            else if (idtpye == 2)
            {
                ddlClass.Visible = true;
                ddlChannel.Visible = false;
                ddllist.Visible = false;
                ddlClass.SelectedValue = idcode.ToString();
            }
            else if (idtpye == 3)
            {
                ddlClass.Visible = false;
                ddlChannel.Visible = false;
                ddllist.Visible = true;
                ddllist.SelectedValue = idcode.ToString();
            }
            DataSet ds = new DB2.tblADFixed().GetList(0, "idCode=" + idcode, "idCode,idPosition,dEndtime desc");
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }
    }
    public string GetChannelName(string itpye, string idChannel)
    {
        int id = TypeChangeDefault.NullToInt(idChannel, 0);
        if ("1" == itpye)
        {
            DBM2.tblChannel model = new DB2.tblChannel().GetModel(id);
            if (model != null)
            {
                return model.cName;
            }
        }
        else if ("2" == itpye)
        {
            DBM2.tblClass model = new DB2.tblClass().GetModel(id);
            if (model != null)
            {
                return model.cName;
            }
        }
        return "";
    }
    protected void ddlChannel_SelectedIndexChanged(object sender, EventArgs e)
    {
        idtpye = TypeChangeDefault.NullToInt(ddlADtype.SelectedValue, 1);
        idcode = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 30000);
        Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        idtpye = TypeChangeDefault.NullToInt(ddlADtype.SelectedValue, 1);
        idcode = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 80000);
        Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
    }
    protected void ddlADtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        idtpye = TypeChangeDefault.NullToInt(ddlADtype.SelectedValue, 1);
        if (ddlADtype.SelectedValue == "1")
        {
            idcode = TypeChangeDefault.NullToInt(ddlChannel.SelectedValue, 30000);
            Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
        }
        else if (ddlADtype.SelectedValue == "2")
        {
            idcode = TypeChangeDefault.NullToInt(ddlClass.SelectedValue, 80000);
            Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
        }
        else if (ddlADtype.SelectedValue == "3")
        {
            idcode = TypeChangeDefault.NullToInt(ddllist.SelectedValue, 90000);
            Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
        }
    }
    protected void BindChannel()
    {
        DataTable dt = new DB2.tblChannel().GetList(0, "iStatus=1", "iSort desc").Tables[0];
        ddlChannel.DataSource = dt;
        ddlChannel.DataTextField = "cName";
        ddlChannel.DataValueField = "id";
        ddlChannel.DataBind();
    }
    protected void BindClass()
    {
        DataTable dt = new DB2.tblClass().GetList(0, "iStatus=1", "iSort desc").Tables[0];
        ddlClass.DataSource = dt;
        ddlClass.DataTextField = "cName";
        ddlClass.DataValueField = "id";
        ddlClass.DataBind();
    }
    protected void ddllist_SelectedIndexChanged(object sender, EventArgs e)
    {
        idtpye = TypeChangeDefault.NullToInt(ddlADtype.SelectedValue, 1);
        idcode = TypeChangeDefault.NullToInt(ddllist.SelectedValue, 90000);
        Response.Redirect("ADFixed.aspx?idtpye=" + idtpye + "&idcode=" + idcode);
    }
}