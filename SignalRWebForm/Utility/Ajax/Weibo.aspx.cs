using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using DB4 = Erun360.BLL.DB4;
using ERUN360.Entity;
using System.Data;

public partial class _Utility_Ajax_Weibo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";
        DataTable dt = new DB4.tblRACE_COMPETETION().GetList(" id in(SELECT [idCompete] FROM [YP_DB_4].[dbo].[tblRACE_SIGNUP] where DATEDIFF([second], getdate() , dJoinEnd)>0 )").Tables[0];
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {            
            sb.AppendLine("<li>");
            sb.AppendLine("<a title=\"" + dt.Rows[i]["cTitle"].ToString().Trim() + "\" class=\"title\" target=\"_blank\" href=\"/blog/" + dt.Rows[i]["idBlog"].ToString().Trim() + ".aspx\">");
            string cs = GCommon.FindValue("idCompeteStyle", dt.Rows[i]["idCompeteStyle"].ToString().Trim());
            if (cs.Length > 0)
            {
                sb.Append("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\"></span>");
            }
            sb.AppendLine(dt.Rows[i]["cTitle"].ToString().Trim() + "</a>");

            sb.AppendLine("<p>比赛时间：" + Convert.ToDateTime(dt.Rows[i]["dRaceBegin"]).ToString("yyyy-MM-dd").Trim());
            sb.AppendLine("<a href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + dt.Rows[i]["ID"].ToString().Trim() + "\"><img src=\"/Html/images/lbm.png\" alt=\"\" /></a>");
            sb.AppendLine("</p>");
            sb.AppendLine("</li>");
        }
        Response.Write(sb.ToString());       
    }
}
