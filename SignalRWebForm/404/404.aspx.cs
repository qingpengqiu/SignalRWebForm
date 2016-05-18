using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _404_404 : PageBase
{
    public string url404 = string.Empty;
    public string Info = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser != null)
        {
            url404 = UrlHelper.MemberUrl(CurrentUser.uId);
            Info = "个人中心";
        }
        else
        {
            url404 = HostInfo.wwwName;
            Info = "首页";
        }
    }
}