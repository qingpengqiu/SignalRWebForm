using ERUN360.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Choice : System.Web.UI.Page
{
    // 页面反馈信息
    public string PageBuffer = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
        }

        int id = 200009729;
        Blog b = new Blog();
        if (Request.Form.Count > 0)
        {
            if (Request.Form["cContent"] != null)
            {
                b.UpdateByCommand(id, "cContent='" + XString.SqlSafe(Request.Form["cContent"].ToString()) + "'");
                PageResult = "提交成功";
            }
        }
        BlogInfo n = b.Load(id, "", "");
        if (n != null) PageBuffer = n.cContent;
        
    }
}