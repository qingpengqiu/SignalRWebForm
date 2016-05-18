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
public partial class Admin_GoodShopList : PageBase
{
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
        if (!IsPostBack)
        {
            //DataSet ds = new DB1.tblIntegral().GetList(0, "", "iType asc,idCode asc");
            DataSet ds = new DB1.tblGoods().GetList(0, "iType=2 ", "dEndTime desc");
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }
    }
    public int isReserve(string idGood)
    {
        return new DB1.tblReserve().GetRecordCount("idGood=" + idGood);
    }
    public int istour(string idGood, string itye)
    {
        if (itye == "1")
        {
            return -1;
        }
        else
        {
            return new DB1.tblTour().GetRecordCount("idGood=" + idGood);
        }
    }
}