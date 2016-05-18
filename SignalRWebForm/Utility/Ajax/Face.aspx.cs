using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_Face : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
            Member m = new Member();
            if (m.Default != null)
            {
                MemberSummary summary = new MemberSummary();
                summary.UpdateByCommand(m.Default.id, "iFace=" + id);

                Users.Face(m.Default.id, id);
            }
        }
        Response.Write(" ");
    }
}
