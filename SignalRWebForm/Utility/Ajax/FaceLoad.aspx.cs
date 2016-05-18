using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_FaceLoad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        int iduser = 0;
        Member m = new Member();
        if (m.Default != null)
        {
            iduser = m.Default.id;
        }

        if (Request.QueryString["id"] != null)
        {
            iduser = Int32.Parse(Request.QueryString["id"].ToString());
        }

        if (iduser > 0)
        {
            UserInfo u = Users.Find(iduser);
            if (u != null)
            {
                if (u.iFace > 0)
                {
                    Response.Write(u.iFace);
                    return;
                }
            }
        }
        Response.Write("1");
    }
}
