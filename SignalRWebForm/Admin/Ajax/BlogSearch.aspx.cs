using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Ajax_BlogSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //if (!Admin.IsAdmin())
        //{
        //    Response.Write("");
        //    return;
        //}

        string fname = "";
        if (Request["fname"] != null)
        {
            fname = Request["fname"].ToString();
        }
        string str = "";
        string qry = "";
        if (Request["str"] != null)
        {
            str = Request["str"].ToString();
            qry = "WHERE cTitle LIKE '%" + str + "%'";
            if (fname == "cloginname") qry = "WHERE cLoginName LIKE '%" + str + "%'";
        }

        // ÿҳ��¼��(Ĭ��30)
        int pageIndex = 1;
        if (Request["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request["page"].ToString()));
        }

        int pageSize = 15;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        Blog table = new Blog();
        List<BlogInfo> items = table.PageList(pageIndex, pageSize, qry, "ORDER BY id DESC", out pageCount);
        
        //Response.ContentType = "text/html;charset=GB2312";

        if (pageCount == 0)
        {
            Response.Write("û�к��ʵĽ��");
            return;
        }

        // ����ҳ����Ϣ
        StringBuilder sb = new StringBuilder();

        int idx = 1;
        sb.Append("<style>#tabu td { padding:3px;font-size:12px; } #tabu a { font-size:12px;color:#0000EE; }</style>");
        sb.Append("<table id=\"tabu\" width=\"100%\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
        foreach (BlogInfo item in items)
        {
            sb.Append("<tr id=\"tr_num_" + idx + "\">");

            string hlogin = item.cLoginName;
            if (fname == "cloginname") hlogin = hlogin.Replace(str, "<font style=\"font-size:12px;color:#AA0000;\">" + str + "</font>");

            sb.Append("<td nowrap>" + hlogin + "</td>");

            string htitle = item.cTitle;
            if (fname == "ctitle") htitle = htitle.Replace(str, "<font color=red>" + str + "</font>");

            sb.Append("<td>" + htitle + "</td>");
            sb.Append("<td nowrap>");
            sb.Append("<a href=\"javascript:;\" onclick=\"BlogAdd(" + idx + "," + item.idUser + ",'" + item.cLoginName + "'," + item.id + ",'" + item.cTitle.ToString() + "')\">+���</a>");
            sb.Append("</td>");
            sb.Append("</tr>");
            idx++;
        }
        sb.Append("</table>");
        sb.Append("<br>");

        if(pageIndex > 1)
        {
            sb.AppendLine("<a href=\"javascript:;\" onclick=\"SearchMore(" + (pageIndex-1) + ")\" style=\"font-size:12px;color:#EE0000;\">&lt;&lt; ��һҳ</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        }

        if (pageCount >= pageSize)
        {
            sb.AppendLine("<a href=\"javascript:;\" onclick=\"SearchMore(" + (pageIndex+1) + ")\" style=\"font-size:12px;color:#EE0000;\">&gt;&gt; ��һҳ</a>");
        }

        if (idx == 1) return;
        Response.Write(sb.ToString());
    }
}
/* Powered by ������������������޹�˾ Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

