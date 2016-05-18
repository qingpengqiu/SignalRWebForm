using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Ajax_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["LOGIN_STATUS"] != null)
        {
            if(Session["LOGIN_STATUS"].ToString().Length > 0)
            {
                Response.Write(Session["LOGIN_STATUS"].ToString());
                return;
            }
        }
        Response.Write("FALSE");
    }
}
