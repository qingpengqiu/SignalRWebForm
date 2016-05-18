using ERUN360.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utility_Ajax_NewEvent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";
        int id =200019049;
        Blog b = new Blog();
        BlogInfo n = b.Load(id, "", "");
        if (n != null)
        {
            Response.Write(n.cContent.Replace("&lt;", "<").Replace("&gt;", ">"));
        }
    }
}