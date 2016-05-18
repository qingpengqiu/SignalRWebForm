using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERUN360.Entity;
public partial class Utility_Ajax_Choice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";
        int id = 200009729;
        Blog b = new Blog();
        BlogInfo n = b.Load(id, "", "");
        if (n != null)
        {
            Response.Write(n.cContent.Replace("&lt;", "<").Replace("&gt;", ">"));
        }
    }
}