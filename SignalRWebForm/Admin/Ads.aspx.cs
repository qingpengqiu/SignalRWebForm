using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Ads : System.Web.UI.Page
{

    // 页面反馈信息
    public string PageBuffer = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
        }

        int id = 200000336;
        Blog b = new Blog();
        if (Request.Form.Count > 0)
        {
            if (Request.Form["cContent"] != null)
            {
                b.UpdateByCommand(id, "cContent='" + XString.SqlSafe(Request.Form["cContent"].ToString()) + "'");
            }
        }
        BlogInfo n = b.Load(id, "", "");
        if(n!=null) PageBuffer = n.cContent;
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */

