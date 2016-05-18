
using System;   
using System.Text;
//using System.Web;
//using System.Web.Caching;

/// <summary>
/// 扩展的Cache类
/// </summary>
public static class Pager
{

    /// <summary>
    /// 分页导航
    /// </summary>
    /// <param name="type"></param>
    /// <param name="pindex"></param>
    /// <returns></returns>
    public static string Navigator(int pageIndex, int pageSize, int pageCount, string fmtString)
    {
        // 查询记录总数
        //int group = 4002;
        int pcnt = pageCount;
        //if (pcnt == 0) return "<br><font class=\"low\">暂时没有相关信息，请继续关注...</font>";
        if (pcnt == 0) return "";

        int ptotal = pcnt;
        if ((pcnt % pageSize) > 0)
        {
            pcnt = (pcnt - (pcnt % pageSize)) / pageSize + 1;
        }
        else
        {
            pcnt = pcnt / pageSize;
        }

        StringBuilder sb = new StringBuilder();
        //sb.AppendLine("<br><hr size=1 noshade color=\"#CCCCCC\">");
        sb.AppendLine("<div id=\"pageShow\">");
        sb.AppendLine("\t<div style=\"float:left;text-align:left;margin-right:10px;padding-top:3px;\">共" + ptotal + "篇</div> ");
        sb.AppendLine("\t<div>");
        if (pageIndex > 1)
        {
            sb.AppendLine("\t\t<div class=ad2 onclick=\"window.location='" + String.Format(fmtString, 1) + "'\"></div> ");
            sb.AppendLine("\t\t<div class=ad3 onclick=\"window.location='" + String.Format(fmtString, (pageIndex - 1)) + "'\"></div> ");
        }

        int pa = pageIndex - 3;
        if (pa < 1) pa = 1;
        int pb = pageIndex + 3;
        for (int i = pa; i <= pb && i <= pcnt; i++)
        {
            if (i == pageIndex)
            {
                sb.AppendLine("\t\t<div class=ad0 onclick=\"window.location='" + String.Format(fmtString, i) + "'\">" + i.ToString() + "</div> ");
            }
            else
            {
                sb.AppendLine("\t\t<div class=ad1 onclick=\"window.location='" + String.Format(fmtString, i) + "'\">" + i.ToString() + "</div> ");
            }
        }
        if (pcnt > 1)
        {
            if (pageIndex < (pcnt - 1))
            {
                sb.AppendLine("\t\t<div class=ad4 onclick=\"window.location='" + String.Format(fmtString, (pageIndex + 1)) + "'\"></div> ");
            }
            sb.AppendLine("\t\t<div class=ad5 onclick=\"window.location='" + String.Format(fmtString, pcnt) + "'\"></div> ");
        }
        sb.AppendLine("\t\t<div style=\"float:left;text-align:left;margin-right:10px;padding-top:3px;\">");
        sb.AppendLine("\t\t\t第" + pageIndex + "页 ");
        sb.AppendLine("\t\t\t共" + pcnt + "页 ");
        sb.AppendLine("\t\t\t每页" + pageSize + "条 ");
        sb.AppendLine("\t\t</div>");
        sb.AppendLine("\t</div>");
        sb.AppendLine("</div>");
        sb.AppendLine("<br>");

        return sb.ToString();

    }
}
