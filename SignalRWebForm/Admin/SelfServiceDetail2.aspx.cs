using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using DB4 = Erun360.BLL.DB4;
using System.Data;
public partial class Admin_SelfServiceDetail2 :  PageBase
{
    private int id = 0;
    public DBM4.tblSelfServiceRace model = new DBM4.tblSelfServiceRace();
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
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (!IsPostBack)
        {
            model = new DB4.tblSelfServiceRace().GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("数据加载失败", UrlHelper.MemberUrl(CurrentUser.uId), false);
            }
            //DataSet dsTour = new DB4.tblSelfServiceRace().GetList(" id=" + id);

            //rptperson.DataSource = dsTour;
            //rptperson.DataBind();
        }
    }
}