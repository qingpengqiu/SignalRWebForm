using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_MemberDuplicate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string login = "";
        if (Request["cloginname"] != null)
        {
            login = XString.SqlSafe(Request["cloginname"].ToString().ToLower());

            if (GCommon.BadLoginname(login))
            {
                Response.Write("OK");
                return;
            }

            int page_count = 0;
            Member table = new Member();
            // Ò³ºÅ±ØÐëÎª1
            List<MemberInfo> find = table.PageList(1, 100, "WHERE iChecksum=CHECKSUM('" + login + "')", "ORDER BY id DESC", out page_count);
            if (page_count > 0)
            {
                Response.Write("OK");
                return;
            }
            else
            {
                Response.Write("ERROR");
                return;
            }
        }
        Response.Write("ERROR");
    }
}
