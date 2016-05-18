using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;

public partial class Admin_TourList : PageBase
{
    private int idgood = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["idgood"] != null)
        {
            idgood = Convert.ToInt32(Request.QueryString["idgood"].ToString());
        }
        if (!IsPostBack)
        {
            
            //DataSet ds = new DB1.tblTour().GetList(0, "", "idGood desc,iBuyNum desc");
            DataSet ds = null;
            if (idgood != 0)
            {
                ds = new DB1.tblTour().GetList(0, "idGood=" + idgood, "idGood desc,iBuyNum desc");
            }
            else
            {
                ds = new DB1.tblTour().GetList(0, "", "idGood desc,iBuyNum desc");
            }
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }
    }
}