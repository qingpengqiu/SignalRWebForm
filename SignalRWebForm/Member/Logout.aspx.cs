using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;
using Erun360.Model;

public partial class _Member_Logout : PageBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        m.Logout();
        Session["CurrentUser"] = null;        
        //Response.Redirect(HostInfo.imgName + "/Member/Logout.aspx");
        Response.Redirect("/Member/Login.aspx");     
    }
}
