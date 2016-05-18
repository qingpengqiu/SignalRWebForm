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
using System.Text;

public partial class Admin_Backstage_Advertisementlb : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        //if (CurrentUser.idMemberStyle < 12)
        //{
        //    AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        //    return;
        //}
        // 马雪蛟
        if (CurrentUser.uId != 100015607 && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            bangding();
        }
    }
    public void bangding()
    {
        DataSet ds = new DB6.tblAdvert().GetList(0, "", "cState desc");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    public string GetNick(string cPosition)
    {
        DBM6.tblAdvert_Nav_Config model = new DB6.tblAdvert_Nav_Config().GetModel(Convert.ToInt32(cPosition));
        if (model != null)
        {
            return model.cName;
        }
        return "";
    }
}