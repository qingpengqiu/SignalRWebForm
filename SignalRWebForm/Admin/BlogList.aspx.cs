using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Blog_List : System.Web.UI.Page
{
    // 页面信息
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/Member/Login.aspx");
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
        string pwords = "";
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

        //#################################################
        if (Request.QueryString["field"] != null)
        {
            searchField = "text:" + Request.QueryString["field"].ToString();
            if (Request.QueryString["value"] != null)
            {
                searchValue2 = Request.QueryString["value"].ToString();
            }
        }
        //#################################################

        // 每页记录数(默认30)
        int pageSize = 30;
        // 总页数
        int pageCount = 0;

        // 查询记录（分页）
        Blog table = new Blog();
        List<BlogInfo> items = new List<BlogInfo>();
        if (searchField.Length > 0)
        {
            //pageIndex = 1;
            string[] fa = searchField.Split(':');
            string qry = "";
            if (fa[0].Contains("cInt"))
            {
                qry = "WHERE (LEFT(idHref,1)=4 and  " + fa[1] + " LIKE '%" + searchValue2 + "%')";
                items = table.PageList(pageIndex, pageSize, qry, "ORDER BY dCreate DESC", out pageCount);
            }
            else
            {

                if (fa[0].Contains("int") || fa[0].Contains("float")) qry = "WHERE (" + fa[1] + " BETWEEN " + searchValue1 + " AND " + searchValue2 + ")";
                if (fa[0].Contains("datetime")) qry = "WHERE (" + fa[1] + " BETWEEN '" + searchValue1 + "' AND '" + searchValue2 + "')";
                if (fa[0].Contains("char") || fa[0].Contains("text"))
                {
                    qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue2 + "%')";
                    //#################################################
                    pwords = "field=" + fa[1] + "&value=" + searchValue2;
                }
                items = table.PageList(pageIndex, pageSize, qry, "ORDER BY id DESC", out pageCount);
            }
        }
        else
        {
            items = table.PageList(pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount);
        }

        // 构建页面信息
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编码</td>");
            //sb.AppendLine("\t<td nowrap>个人分组</td>");
            //sb.AppendLine("\t<td nowrap>关联信息ID</td>");
            //sb.AppendLine("\t<td nowrap>用户ID</td>");
            sb.AppendLine("\t<td nowrap>用户名称</td>");
            sb.AppendLine("\t<td nowrap>标题</td>");
            sb.AppendLine("\t<td nowrap>内容</td>");
            sb.AppendLine("\t<td nowrap>创建时间</td>");
            sb.AppendLine("\t<td nowrap style=\"width:110px;\">操作</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (BlogInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td nowrap><span class=\"span_href\" onclick=\"ItemShow(" + item.id + ")\">" + item.id.ToString() + "</span></td>");
                //sb.AppendLine("\t<td>" + item.idPersonGroup.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.idHref.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.idUser.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.cLoginName.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + XString.TruncBreak(item.cTitle.ToString(), 40, 4) + "<br>");
                sb.AppendLine("\t<span class=\"span_href\">");
               
                string classify = item.idHref.ToString().Substring(0, 1);
             
                if (classify == "0")
                {
                    sb.AppendLine("\t[<a href=\"" + UrlHelper.BlogUrl(item.id) + "\" target=_blank>预览</a>] ");
                    sb.AppendLine("\t[<a href=\"/admin/bloglink.aspx?id=" + item.id + "\">创建或维护专题</a>]");
                    sb.AppendLine("\t[<a>博客</a>]");
                }
                else if (classify == "5")
                {
                    sb.AppendLine("\t[<a href=\"" + UrlHelper.BlogUrl(item.id) + "\" target=_blank>预览</a>] ");
                    //sb.AppendLine("\t[<a href=\"/admin/bloglink.aspx?id=" + item.id + "\">创建或维护专题</a>]");
                    sb.AppendLine("\t[<a>装备</a>]");
                }
                else if (classify == "3")
                {
                    sb.AppendLine("\t[<a href=\"" + UrlHelper.BlogUrl(item.id) + "\" target=_blank>预览</a>] ");
                    sb.AppendLine("\t[<a href=\"/admin/bloglink.aspx?id=" + item.id + "\">创建或维护专题</a>]");
                    sb.AppendLine("\t[<a>赛事</a>]");
                }
                else if (classify == "4")
                {
                    sb.AppendLine("\t[<a href=\"" + UrlHelper.RaceUrl(item.idHref) + "\" target=_blank>预览</a>] ");
                    //sb.AppendLine("\t[<a href=\"/admin/bloglink.aspx?id=" + item.id + "\">创建或维护专题</a>]");
                    sb.AppendLine("\t[<a>约跑</a>]");
                }
                sb.AppendLine("\t</span>");
                sb.AppendLine("\t</td>");
                //sb.AppendLine("\t<td><div style=\"width:300px;height:100px;overflow:hidden;font-size:12px;\">" + item.cContent.ToString() + "</div></td>");
                sb.AppendLine("\t<td style=\"font-size:12px;\" nowrap>" + XString.TruncBreak(XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(item.cContent.ToString())), 400), 40, 4) + "...</td>");
                sb.AppendLine("\t<td nowrap>" + item.dCreate.ToString() + "</td>");
                sb.AppendLine("\t<td>");
                sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;margin-right:3px;\" onclick=\"Publish(" + item.id + ");\">发布</div>");
                if (classify == "0")
                {
                    sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;margin-right:3px;\" onclick=\"Pushblog(" + item.id + ");\">推送博文</div>");
                }
                //else if (classify == "3")
                //{
                //    sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;margin-right:3px;\" onclick=\"Pushblog(" + item.id + ");\">推送赛事</div>");
                //}
                else if (classify == "4")
                {
                    sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;margin-right:3px;\" onclick=\"PushRun(" + item.idHref + ");\">推送约跑</div>");
                }
                sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;\" onclick=\"ItemDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "');\">删除</div>");
                sb.AppendLine("\t</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编码</td>");
            //sb.AppendLine("\t<td nowrap>个人分组</td>");
            //sb.AppendLine("\t<td nowrap>关联信息ID</td>");
            //sb.AppendLine("\t<td nowrap>用户ID</td>");
            sb.AppendLine("\t<td nowrap>用户名称</td>");
            sb.AppendLine("\t<td nowrap>标题</td>");
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
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "BlogList.aspx?page={0}");
        }

        //#################################################
        if (pwords.Length > 0)
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "BlogList.aspx?page={0}&" + pwords);
        }
    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

