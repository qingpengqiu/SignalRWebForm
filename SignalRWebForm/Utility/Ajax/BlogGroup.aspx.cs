using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_BlogGroup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";
        
        Member m = new Member();
        if(m.Default==null) 
        {
        Response.Write("没有信息");
        }

        BlogGroup bg = new BlogGroup();
        Response.Write(bg.UserSelect(m.Default.id, 0));
    }
}
