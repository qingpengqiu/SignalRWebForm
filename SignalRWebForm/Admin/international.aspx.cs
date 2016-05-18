using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERUN360.Entity;
using Utils;
public partial class Admin_international : PageBase
{
    // 页面反馈信息
    public string PageBuffer = "";
    public string PageResult = "";

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
        int id = 200215291;
        Blog b = new Blog();
        if (Request.Form.Count > 0)
        {
            if (Request.Form["cContent"] != null)
            {
                b.UpdateByCommand(id, "cContent='" + XString.SqlSafe(Request.Form["cContent"].ToString()) + "'");
                PageResult = "提交成功";
            }
        }
        BlogInfo n = b.Load(id, "", "");
        if (n != null) PageBuffer = n.cContent;
        
    }
}