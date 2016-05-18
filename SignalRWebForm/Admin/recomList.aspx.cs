using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB2 = Erun360.BLL.DB2;
public partial class Admin_recomList : PageBase
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
            DBM3.tblRecom mRecom = new DB3.tblRecom().GetModel(id);
            if (mRecom != null)
            {
                mRecom.id = id;
                mRecom.cState = -1;
                if (new DB3.tblRecom().Update(mRecom))
                {
                    AlertHelper.JQAlertGo("删除成功", "recomList.aspx", false);
                }
            }
        }
        string where = " SELECT  r.idUser, r.cBio, r.cType, r.dUpdate, r.cLoginname, r.cState, m.cNickName, m.cAvatar, r.id FROM  YP_DB_3.dbo.tblRecom AS r INNER JOIN YP_DB_1.dbo.tblMEMBER AS m ON r.idUser = m.id where r.cState>0";
        //DataTable dt = new DB2.ViewHomeList().QueryBySql(where).Tables[0];
        DataSet ds = new DB2.ViewHomeList().QueryBySql(where);
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
}