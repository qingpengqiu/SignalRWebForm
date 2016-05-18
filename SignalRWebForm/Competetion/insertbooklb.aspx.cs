using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Text.RegularExpressions;

public partial class Competetion_insertbooklb : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (Request.QueryString["sid"] != null)
        {
            sid = Convert.ToInt32(Request.QueryString["sid"].ToString());
        }
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition comp = new DB6.tblRace_Competition().GetModel(TypeChangeDefault.NullToInt(sid, 0));
            if (CurrentUser.idMemberStyle != 99)
            {
                if (CurrentUser.uId != comp.idUser)
                {
                    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
            ltlbanner.Text = comp.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + comp.cBanner + "\" height=\"256\" width=\"1200\" alt=\"\"/>";
            title = comp.cTitle;
            bangding();
        }
    }
    public void bangding()
    {
        DataSet ds = new DB2.tblBLOG_LINKS().GetList("idBlog="+ sid +"");

        rptrunrecord.DataSource = ds;
        rptrunrecord.DataBind();
       
    }
    protected void rptrunrecord_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.uId != 100055041 && CurrentUser.uId != 100001183 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
            return;
        }
        LinkButton linkButton = (LinkButton)e.Item.FindControl("LinkButton1");
        int id = TypeChangeDefault.NullToInt(linkButton.CommandArgument,0);
        if (id != 0)
        {
            bool i = new DB2.tblBLOG_LINKS().Delete(TypeChangeDefault.NullToInt(id, 0));
            if (i)
            {
                AlertHelper.JQAlertGo("删除成功！", "insertbooklb.aspx?sid=" + sid + "", true);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo("删除失败！", "", false);
                return;
            }
        }
    }
}