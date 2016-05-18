using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;
using System.Data;
public partial class Admin_AdList : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (CurrentUser.idMemberStyle != 99 && CurrentUser.idMemberStyle != 13)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            int id = Convert.ToInt32(Request.QueryString["id"].ToString());
            DBM2.tblAD mAD = new DB2.tblAD().GetModel(id);
            if (mAD != null)
            {
                mAD.id = id;
                mAD.iState = -1;
                mAD.idUser = CurrentUser.uId;
                mAD.dCreate = DateTime.Now;
                if (new DB2.tblAD().Update(mAD))
                {
                    AlertHelper.JQAlertGo("删除成功", "AdList.aspx", false);
                }
            }
        }
        DataSet ds = new DB2.tblAD().GetList(" and iState >=0");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
}