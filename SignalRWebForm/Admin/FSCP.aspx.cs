using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM4 = Erun360.Model.DB4;
using DB4 = Erun360.BLL.DB4;
using System.Data;
public partial class Admin_FSCP : PageBase
{
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
            int id = Convert.ToInt32(Request.QueryString["id"].ToString());
            DBM4.tblAnnex mAnnex = new DB4.tblAnnex().GetModel(id);
            if (mAnnex != null)
            {
                mAnnex.id = id;
                mAnnex.iState = -1;               
                if (new DB4.tblAnnex().Update(mAnnex))
                {
                    AlertHelper.JQAlertGo("删除成功", "FSCP.aspx", false);
                }
            }
        }
        DataSet ds = new DB4.tblAnnex().GetList(" iState >=0");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
}