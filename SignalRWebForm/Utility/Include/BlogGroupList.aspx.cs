using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Include_BlogGroupList : System.Web.UI.Page
{
    // 页面信息
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            PageBuffer = "没有操作权限！";
            return;
        }
        #endregion

        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            BlogGroupInfo record = new BlogGroupInfo();
            record.idUser = u.id;
            int finishedFieldCount = 0;
            if (Request.Form["cTitle"] != null)
            {
                try
                {
                    record.cTitle = XString.SqlSafe(Request.Form["cTitle"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(标题)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(标题)！";
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount >= 1 && PageBuffer.Length == 0)
            {
                BlogGroup bg = new BlogGroup();
                int recordIndex = 0;
                if (bg.Insert(record, out recordIndex))
                {
                    ;
                }
                else
                {
                    ;
                }
            }
        }

        int pageIndex = 1;
        // 每页记录数(默认30)
        int pageSize = 30;
        // 总页数
        int pageCount = 0;

        // 查询记录（分页）
        BlogGroup table = new BlogGroup();
        List<BlogGroupInfo> items = table.PageList(pageIndex, pageSize, "WHERE idUser=" + u.id, "ORDER BY id DESC", out pageCount);

        // 构建页面信息
        StringBuilder sb = new StringBuilder();
        if (pageCount > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>序号</td>");
            sb.AppendLine("\t<td>分类名称</td>");
            sb.AppendLine("\t<td>博客数量</td>");
            sb.AppendLine("\t<td>操作</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (BlogGroupInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\">");
                //sb.AppendLine("\t<td>" + item.id.ToString() + "</td>");
                sb.AppendLine("\t<td>" + idx + "</td>");
                sb.AppendLine("\t<td>" + item.cTitle.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.iNumber.ToString() + "</td>");
                sb.AppendLine("\t<td>");
                if (item.iNumber < 1)
                {
                    sb.AppendLine("<div id=\"span_delete\" onclick=\"ItemDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\"></div>");
                }
                sb.AppendLine("</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>序号</td>");
            sb.AppendLine("\t<td>分类名称</td>");
            sb.AppendLine("\t<td>博客数量</td>");
            sb.AppendLine("\t<td>操作</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">没有信息...</div>");
        }

        PageResult = sb.ToString();
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

