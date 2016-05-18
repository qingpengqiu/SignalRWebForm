using Erun360.Common.DEncrypt;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Member_Invitation : PageBase
{
    public string url = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        url = "http://www.erun360.com/Member/register.aspx?u=" + CurrentUser.uId;
        //url = "http://www.erun360.com/Member/register.aspx?u=" + DEncrypt.Encrypt(CurrentUser.uId.ToString());
    }
}