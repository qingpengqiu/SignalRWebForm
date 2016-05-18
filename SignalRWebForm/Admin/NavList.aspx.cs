using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB2 = Erun360.BLL.DB2;
public partial class Admin_NavList : PageBase
{
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

        DataSet ds = new DB2.tblChannel().GetAllList();
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    public string GetClassName(string idClass)
    {
        string strWhere = string.Empty;
        if (string.IsNullOrWhiteSpace(idClass))
        {
            return "";
        }
        strWhere = "id in(" + idClass + ")";
        string name = string.Empty;
        DataTable dt = new DB2.tblClass().GetList(strWhere).Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)//给CheckBoxList选中的复选框 赋值
        {
            name += dt.Rows[i]["cName"].ToString() + "|";
            //name += dt.Rows[i]["cName"].ToString() + "(" + dt.Rows[i]["id"].ToString() + ")|";
        }
        return name.TrimEnd('|');
    }
}