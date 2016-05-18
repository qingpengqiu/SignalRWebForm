using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using ERUN360.Entity;
using Model_DB2 = Erun360.Model.DB2;
using Bll_DB2=Erun360.BLL.DB2;
public partial class Admin_PushManagerOfBlog : System.Web.UI.Page
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
        #region 处理删除数据请求
        string checksum = "";
        if (Request.QueryString["checksum"] != null)
        {
            checksum = Request.QueryString["checksum"].ToString().ToLower();
            int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            if (recordIndex <= 0)
            {
                Response.Write("编号错误(id error)！");
                Response.End();
            }
            if (String.Compare(checksum, XString.MD5(recordIndex.ToString()), true) != 0)
            {
                Response.Write("验证码错误(checksum is error)！");
                Response.End();
            }
            if (new Bll_DB2.tblPush().Delete(recordIndex))
            {
                Response.Write("OK");
                Response.End();
            }
        }
        #endregion

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
        int pageSize = 20;
        // 记录数
        int rowCount = 0;

        // 查询记录（分页）
        string qry = " iType=1 ";
        if (searchField.Length > 0)
        {
            string[] fa = searchField.Split(':');
            if (fa[0].Contains("cInt"))
            {
                qry += " And (LEFT(idHref,1)=4 and  " + fa[1] + " LIKE '%" + searchValue2 + "%')";
            }
            else
            {
                if ((fa[0].Contains("int") || fa[0].Contains("float"))&&!string.IsNullOrEmpty(searchValue1)&& !string.IsNullOrEmpty(searchValue2)) qry += "And (" + fa[1] + " BETWEEN " + searchValue1 + " AND " + searchValue2 + ")";
                if (fa[0].Contains("datetime")) qry += "And (" + fa[1] + " BETWEEN '" + searchValue1 + "' AND '" + searchValue2 + "')";
                if (fa[0].Contains("char") || fa[0].Contains("text"))
                {
                    qry += " And (" + fa[1] + " LIKE '%" + searchValue2 + "%')";
                    pwords = "field=" + fa[1] + "&value=" + searchValue2;
                }
            }
        }
        DataSet dSetofBlogs = new Bll_DB2.tblPush().GetListByPage(qry, "id desc", pageIndex, pageSize);
        rowCount = new Bll_DB2.tblPush().GetRecordCount(qry);
        // 构建页面信息
        StringBuilder sb = new StringBuilder();
        if (dSetofBlogs != null && dSetofBlogs.Tables[0].Rows.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编码</td>");
            sb.AppendLine("\t<td nowrap>用户名称</td>");
            sb.AppendLine("\t<td nowrap>标题</td>");
            sb.AppendLine("\t<td nowrap>摘要</td>");
            sb.AppendLine("\t<td nowrap>推送分类</td>");
            sb.AppendLine("\t<td nowrap>推送时间</td>");
            sb.AppendLine("\t<td nowrap style=\"width:110px;\">操作</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (DataRow item in dSetofBlogs.Tables[0].Rows)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td nowrap><span class=\"span_href\" onclick=\"ItemShow(" + item["id"].ToString() + ")\">" + item["id"].ToString() + "</span></td>");
                sb.AppendLine("\t<td nowrap>" + item["cNickName"].ToString() + "</td>");
                sb.AppendLine("\t<td nowrap><a href=\"" + UrlHelper.BlogUrl(int.Parse(item["idInfo"].ToString())) + "\" target=_blank>" + XString.TruncBreak(item["cTitle"].ToString(), 40, 4) + "</a><br>");
                sb.AppendLine("\t<span class=\"span_href\">");
                
                sb.AppendLine("\t</span>");
                sb.AppendLine("\t</td>");
                sb.AppendLine("\t<td style=\"font-size:12px;\" nowrap>" + XString.TruncBreak(XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(item["cBio"].ToString())), 400), 40, 4) + "...</td>");
                sb.AppendLine("\t<td nowrap>" + item["cClassName"].ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item["dPush"].ToString() + "</td>");
                sb.AppendLine("\t<td>");
                sb.AppendLine("\t<div style=\"float:left;width:40px;text-align:center;padding:3px;border:solid 1px #0000AA;font-size:12px;color:#0000EE;\" onclick=\"ItemDelete(" + item["id"] + "," + idx + ",'" + XString.MD5(item["id"].ToString()) + "');\">删除</div>");
                sb.AppendLine("\t</td>");
                sb.AppendLine("</tr>");
                idx++;
            }
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编码</td>");
            sb.AppendLine("\t<td nowrap>用户名称</td>");
            sb.AppendLine("\t<td nowrap>标题</td>");
            sb.AppendLine("\t<td nowrap>摘要</td>");
            sb.AppendLine("\t<td nowrap>推送分类</td>");
            sb.AppendLine("\t<td nowrap>推送时间</td>");
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
        if (searchField.Length < 1|| string.IsNullOrEmpty(searchValue1) || !string.IsNullOrEmpty(searchValue2))
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, rowCount, "PushManagerOfBlog.aspx?page={0}");
        }

        //#################################################
        if (pwords.Length > 0)
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, rowCount, "PushManagerOfBlog.aspx?page={0}&" + pwords);
        }
    }
}