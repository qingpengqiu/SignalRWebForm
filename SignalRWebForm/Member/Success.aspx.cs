using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Member_Success : System.Web.UI.Page
{
    public string PageBuffer = "";
    public string PageResult = "";
    public int idUser = 0;
    public string PageAdmin = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        //PageResult = m._err;
        if (m.Default == null)
        {
            Response.Redirect("/member/");
            return;
        }
        idUser = m.Default.id;
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        if (Admin.IsAdmin())
        {
            PageAdmin = "<div style=\"border:dotted 1px #CCCCCC;padding:20px;\">";
            PageAdmin += "&bull; <a href=\"/Admin/\">管理入口</a><br>";
            PageAdmin += "</div>";
        }
    }
}
