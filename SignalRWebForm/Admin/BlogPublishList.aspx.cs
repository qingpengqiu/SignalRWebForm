using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_BlogPublish_List : System.Web.UI.Page
{
    // ҳ����Ϣ
    public string PageResult = "";
    public string PageNavigator = "";
    public Groups groups = new Groups();
    public int position = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
        }

        // ��ȡҳ�ţ�Ĭ��Ϊ1
        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
        }
        if (pageIndex < 1)
        {
            PageResult = "ҳ�Ŵ���";
            return;
        }
        // ���ֶ�������
        string searchField = "";

        if (Request["idPosition"] != null)
        {
            position = Int32.Parse(Request["idPosition"].ToString());
            searchField = "WHERE idPosition=" + Int32.Parse(Request["idPosition"].ToString());
        }

        if (Request["PublishIndex"] != null)
        {
            string dqry = Request["PublishIndex"].ToString().Replace(" ", "");
            if (dqry.Length > 0)
            {
                SQLHelper.ExecuteSql("DELETE FROM [YP_DB_2].[dbo].[tblBLOG_PUBLISH] WHERE id IN(" + dqry + ")");
            }
        }

        // ÿҳ��¼��(Ĭ��30)
        int pageSize = 30;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        BlogPublish table = new BlogPublish();
        List<BlogPublishInfo> items = new List<BlogPublishInfo>();

        items = table.PageList(pageIndex, pageSize, searchField, "ORDER BY id DESC", out pageCount);
       
        StringBuilder sb = new StringBuilder();
        if (pageCount > 0)
        {
            StringBuilder sp = new StringBuilder();
            foreach (BlogPublishInfo item in items)
            {
                sp.Append(item.idInfo + ",");
            }
            int pc = 0;
            Blog blog = new Blog();
            List<BlogInfo> blist = blog.PageList(1, items.Count, "WHERE id IN(" + XString.UnTail(sp.ToString()) + ")", "", out pc);
            Hashtable hash = new Hashtable();
            foreach (BlogInfo bu in blist)
            {
                hash.Add(bu.id, bu.cLoginName + " : " + bu.cTitle);
            }

            // ����ҳ����Ϣ
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>ҳ��λ��ID</td>");
            sb.AppendLine("\t<td nowrap>��ϢID</td>");
            sb.AppendLine("\t<td nowrap>����ʱ��</td>");
            sb.AppendLine("\t<td nowrap style=\"width:120px;\">����</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (BlogPublishInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td>" + item.id.ToString() + "</td>");

                GroupsInfo gp = groups.Find(item.idPosition);
                GroupsInfo gr = groups.Find(Int32.Parse(item.idPosition.ToString().Substring(0, 3) + "100100"));
                sb.AppendLine("\t<td title=\"" + item.idPosition.ToString() + "\">" + gr.cTitle + " &gt; " + gp.cTitle + "</td>");

                string tt = "";
                if (hash[item.idInfo] != null) { tt = " <a href=\"" + UrlHelper.BlogUrl(item.idInfo) + "\" target=\"_blank\">" + (string)hash[item.idInfo] + "</a>";}
                // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                // 2012-10-23
                if (item.cTitle.Length > 0) tt += "<br>�����޸�Ϊ: " + item.cTitle;
                // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

                sb.AppendLine("\t<td>" + item.idInfo.ToString() + "" + tt + "</td>");
                sb.AppendLine("\t<td>" + item.dCreate.ToString() + "</td>");
                sb.AppendLine("\t<td>");
                sb.AppendLine("\t<input type=\"checkbox\" id=\"PublishIndex\" name=\"PublishIndex\" value=\"" + item.id + "\">ɾ��");
                sb.AppendLine("\t</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>ҳ��λ��ID</td>");
            sb.AppendLine("\t<td nowrap>��ϢID</td>");
            sb.AppendLine("\t<td nowrap>����ʱ��</td>");
            sb.AppendLine("\t<td nowrap><div id=\"span_delete\" onclick=\"ItemListDelete()\"></div></td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }

        PageResult = sb.ToString();

        // ��ҳ�ؼ�
        if (searchField.Length < 1)
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "BlogPublishList.aspx?page={0}");
        }
        else
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "BlogPublishList.aspx?idPosition=" + position + "&page={0}");
        }
    }
}
