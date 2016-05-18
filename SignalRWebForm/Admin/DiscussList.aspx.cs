using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Discuss_List : System.Web.UI.Page
{
    // 页面信息
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            PageBuffer = "没有操作权限！";
            return;
        }

        // 获取页号，默认为1
        int tabIndex = 0;
        if (Request.QueryString["table"] != null)
        {
            tabIndex = Int32.Parse(XString.PureNumber(Request.QueryString["table"].ToString()));
        }
        string searchKey = "";
        if (Request["searchKey"] != null)
        {
            searchKey = Request["searchKey"].ToString();
            if (searchKey != "*") tabIndex = Int32.Parse(XString.PureNumber(searchKey)) % 10;
        }

        if (tabIndex < 0 || tabIndex >= 10)
        {
            PageBuffer = "数据库表序号错误！";
            return;
        }
        // 获取页号，默认为1
        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
        }
        if (pageIndex < 1)
        {
            PageBuffer = "页号错误！";
            return;
        }

        // 按字段搜索？
        string searchField = "";
        if (Request["searchField"] != null)
        {
            searchField = XString.SqlSafe(Request["searchField"].ToString());
        }
        string searchValue1 = "";
        if (Request["searchValue1"] != null)
        {
            searchValue1 = XString.SqlSafe(Request["searchValue1"].ToString());
        }
        string searchValue2 = "";
        if (Request["searchValue2"] != null)
        {
            searchValue2 = XString.SqlSafe(Request["searchValue2"].ToString());
        }
        if (searchField.StartsWith("datetime:"))
        {
            if (Request["searchDate1"] != null)
            {
                searchValue1 = XString.SqlSafe(Request["searchDate1"].ToString()) + " 00:00:00";
            }
            if (Request["searchDate2"] != null)
            {
                searchValue2 = XString.SqlSafe(Request["searchDate2"].ToString()) + " 23:59:59";
            }
        }

        // 每页记录数(默认30)
        int pageSize = 30;
        // 总页数
        int pageCount = 0;

        // 查询记录（分页）
        string cmd = "";
        Discuss table = new Discuss();
        List<DiscussInfo> items = new List<DiscussInfo>();
        if (Request.Form.Count > 0)
        {
            if (searchField.Length > 0)
            {
                pageIndex = 1;
                string[] fa = searchField.Split(':');
                string qry = "";
                if (fa[0].Contains("int") || fa[0].Contains("float")) qry = "WHERE (" + fa[1] + " BETWEEN " + searchValue1 + " AND " + searchValue2 + ")";
                if (fa[0].Contains("datetime")) qry = "WHERE (" + fa[1] + " BETWEEN '" + searchValue1 + "' AND '" + searchValue2 + "')";
                if (fa[0].Contains("char") || fa[0].Contains("text")) qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue1 + "%')";
                int t_start = tabIndex;
                int t_end = tabIndex;
                if (searchKey == "*") { t_start = 0; t_end = 10; }
                int cnt = 0;
                for (int idx = t_start; idx < t_end; idx++)
                {
                    items.AddRange(table.PageList(idx, pageIndex, pageSize, qry, "ORDER BY id DESC", out pageCount));
                    if (cnt < pageCount)
                    {
                        cnt = pageCount;
                    }
                }
                pageCount = cnt;// items.Count;
            }
            else
            {
                items = table.PageList(tabIndex, pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount);
            }
        }
        else
        {
            if (Request.QueryString["table"] != null)
            {
                cmd = "single";
                items = table.PageList(tabIndex, pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount);
            }
            else
            {
                cmd = "multi";
                int cnt = 0;
                for (int idx = 0; idx < 10; idx++)
                {
                    items.AddRange(table.PageList(idx, pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount));
                    if (cnt < pageCount)
                    {
                        cnt = pageCount;
                    }
                }
                //pageCount = items.Count;
                pageCount = cnt;
            }
        }

        items.Sort(delegate(DiscussInfo a, DiscussInfo b) { return Comparer<DateTime>.Default.Compare(b.dCreate, a.dCreate); });

        // 构建页面信息
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编号</td>");
            sb.AppendLine("\t<td nowrap>信息ID</td>");
            sb.AppendLine("\t<td nowrap>用户ID</td>");
            sb.AppendLine("\t<td nowrap>昵称</td>");
            //sb.AppendLine("\t<td nowrap>表情</td>");
            sb.AppendLine("\t<td nowrap>内容</td>");
            sb.AppendLine("\t<td nowrap>创建时间</td>");
            sb.AppendLine("\t<td nowrap style=\"width:120px;\">操作</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (DiscussInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td>TABLE" + (item.idInfo%10) + ": " + item.id.ToString() + "</td>");
                if (item.idInfo > 200000000)
                {
                    sb.AppendLine("\t<td><a href=\"/blog/" + item.idInfo.ToString() + ".aspx#AA\" target=\"_blank\">" + item.idInfo.ToString() + "</a></td>");
                }
                else
                {
                    sb.AppendLine("\t<td>" + item.idInfo.ToString() + "</td>");
                }
                sb.AppendLine("\t<td>" + item.idUser.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cLoginName.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.iMood.ToString() + "</td>");
                sb.AppendLine("\t<td>" + XString.TruncBreak(item.cContent.ToString(), 40, 4) + "</td>");
                sb.AppendLine("\t<td>" + item.dCreate.ToString() + "</td>");
                sb.AppendLine("\t<td>");
                sb.AppendLine("\t<div id=\"span_delete\" onclick=\"ItemDelete(" + item.idInfo + "," + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\"></div>");
                sb.AppendLine("\t</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编号</td>");
            sb.AppendLine("\t<td nowrap>信息ID</td>");
            sb.AppendLine("\t<td nowrap>用户ID</td>");
            sb.AppendLine("\t<td nowrap>昵称</td>");
            sb.AppendLine("\t<td nowrap>表情</td>");
            sb.AppendLine("\t<td nowrap>内容</td>");
            sb.AppendLine("\t<td nowrap>创建时间</td>");
            sb.AppendLine("\t<td nowrap>操作</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">没有信息...</div>");
        }

        PageResult = sb.ToString();

        // 分页控件
        if (searchField.Length < 1)
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "DiscussList.aspx?page={0}&table=" + tabIndex + "");
        }
    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

