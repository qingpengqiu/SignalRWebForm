using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Import : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["cnt"] != null)
        {
            PageResult = "总共成功导入了 " + Request.QueryString["cnt"].ToString() + " 篇博客！";
        }
    }
}
