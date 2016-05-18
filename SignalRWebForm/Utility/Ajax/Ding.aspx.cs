using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_Ding : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region 身份确认
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("您未注册");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }

        BlogSummary bs = new BlogSummary();
        BlogSummaryInfo summary = bs.Load(id, "", "");
        if (summary != null)
        {
            if (summary.idUserLast != m.Default.id)
            {
                bs.UpdateByCommand(id, "iDing=iDing+1,idUserLast=" + m.Default.id);
                Response.Write(summary.iDing + 1);
                return;
            }
            else
            {
                Response.Write("您已顶过");
            }
        }
        else
        {
            Response.Write(summary.iDing);
        }
    }
}
