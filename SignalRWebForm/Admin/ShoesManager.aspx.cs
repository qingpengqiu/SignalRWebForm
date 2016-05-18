using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using System.Data;
using DB5_Bll = Erun360.BLL.DB5;
using DB5_Model = Erun360.Model.DB5;
using Newtonsoft.Json;
using System.Text;
using System.IO;
using System.Data.OleDb;
using System.Xml;


public partial class Admin_ShoesManager : PageBase
{
    DB5_Bll.tblShoes shoes_bll = new DB5_Bll.tblShoes();
    DB5_Model.tblShoes modelofshoes = new DB5_Model.tblShoes();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (!IsPostBack)
        {
            BindShoes();
        }
    }
    //绑定赛事
    private void BindShoes()
    {
        DataTable dt = shoes_bll.GetList("").Tables[0];
        DDLShoes.DataSource = dt;
        DDLShoes.DataTextField = "cName";
        DDLShoes.DataValueField = "id";
        DDLShoes.DataBind();
    }
}