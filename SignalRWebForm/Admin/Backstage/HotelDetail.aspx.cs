using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Data;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Text;

public partial class Admin_Backstage_HotelDetail : PageBase
{
    public int corder = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
         if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
         if (CurrentUser.idMemberStyle != 99)
         {
             if (CurrentUser.uId != 100055041)
             {
                 if (CurrentUser.uId != 100001183)
                 {
                     AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
                     return;
                 }
             }
         }
        corder = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        
        if (!IsPostBack)
        {
            bangding();
        }
    }

    public void bangding()
    {
        DataSet ds = new DB6.tblRace_Detail().GetList("cOrder_no='" + corder + "'");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }

    public string GetNick(string idUser)
    {
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(Convert.ToInt32(idUser));
        if (model != null)
        {
            return model.cNickName;
        }
        return "";
    }
}