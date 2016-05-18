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

public partial class Admin_FocusmapHome : PageBase
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
        if (Request.QueryString["id"] != null)
        {
            int id = Convert.ToInt32(Request.QueryString["id"].ToString());
            DBM2.tblFocusmap mFocusmap = new DB2.tblFocusmap().GetModel(id);
            if (mFocusmap != null)
            {
                mFocusmap.id = id;
                mFocusmap.iStatus = -1;
                mFocusmap.idUser = CurrentUser.uId;
                //mFocusmap.dCreate = DateTime.Now;
                if (new DB2.tblFocusmap().Update(mFocusmap))
                {
                    string CacheKey = "tblFocusmap";
                    Erun360.Common.DataCache.RemoveAllCache(CacheKey);
                    AlertHelper.JQAlertGo("删除成功", "FocusmapList.aspx", false);
                }
            }
        }
        DataSet ds = new DB2.tblFocusmap().GetList(0, "iStatus >=0 and idChannel is not null", "id desc");
        Repeater1.DataSource = ds;
        Repeater1.DataBind();
    }
    public string GetChannelName(string idChannel)
    {
        int id = TypeChangeDefault.NullToInt(idChannel, 0);
        DBM2.tblChannel model = new DB2.tblChannel().GetModel(id);
        if (model != null)
        {
            return model.cName;
        }
        return "";
    }
}