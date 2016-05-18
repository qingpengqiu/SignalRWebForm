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
public partial class Admin_GoodDetail : PageBase
{
    private int id = 0;
    public DBM1.tblGoods good = new DBM1.tblGoods();
    public DBM1.tblReserve reserve = new DBM1.tblReserve();
    public DBM1.tblTour tour = new DBM1.tblTour();
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            good = new DB1.tblGoods().GetModel(id);
            reserve = new DB1.tblReserve().GetModel(id);
            tour = new DB1.tblTour().GetModel(id);

            DataSet dsReserve = new DB1.tblReserve().GetGoodReserve(" idGood=" + id);

            gvReserve.DataSource = dsReserve;
             gvReserve.DataBind();

             DataSet dsTour = new DB1.tblTour().GetTourList(" idGood=" + id, "iBuyNum desc");

             gvTour.DataSource = dsTour;
             gvTour.DataBind();
            
        }

    }
}