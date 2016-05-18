using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Ajax_News : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";
        int id = 200009727;
        Blog b = new Blog();
        BlogInfo n = b.Load(id, "", "");
        if (n != null)
        {
            Response.Write(n.cContent.Replace("&lt;", "<").Replace("&gt;", ">"));
        }
    }
}
