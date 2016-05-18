using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Channels_Tools_Ajax_MarathonPace : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region 基本数据

        string values = Tools.MarathonPace();

        #endregion

        #region 计算过程

        int seconds = 1;
        if (Request.QueryString["seconds"] != null)
        {
            seconds = Int32.Parse(Request.QueryString["seconds"].ToString());
        }

        if (seconds < 1)
        {
            Response.Write("数据错误<br>");
            return;
        }

        int mode = 0;
        if (Request.QueryString["mode"] != null)
        {
            mode = Int32.Parse(Request.QueryString["mode"].ToString());
        }

        // 转换为 公里/小时
        double speed = 0.0;
        if (mode == 0) { speed = 42.2 / (seconds / 3600.0); }
        if (mode == 1) { speed = 3600.0 / seconds; }

        bool find = false;
        string[] va = values.Split('|');
        int cnt = va.Length - 1;
        for (int i=0; i<cnt; i++)
        {
            string[] v2 = va[i].Split(',');

            if (speed < double.Parse(v2[1]))
            {
                if (i == 0) break;

                string[] v1 = va[i - 1].Split(',');

                StringBuilder sk = new StringBuilder();
                sk.AppendLine("<table id=\"tab\" width=\"100%\" border=\"1\" bordercolor=\"#CCCCCC\" cellpadding=\"0\" cellspacing=\"0\">");
                sk.AppendLine("<tr>");
                sk.AppendLine("<td align=\"right\">1 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(6, 1.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("<td align=\"right\">20 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(13, 20.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("</tr>");
                sk.AppendLine("<tr>");
                sk.AppendLine("<td align=\"right\">2 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(8, 2.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("<td align=\"right\">半程马拉松</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(14, 21.1, speed, v1, v2)) + "</td>");
                sk.AppendLine("</tr>");
                sk.AppendLine("<tr>");
                sk.AppendLine("<td align=\"right\">5 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(10, 5.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("<td align=\"right\">30 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(15, 30.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("</tr>");
                sk.AppendLine("<tr>");
                sk.AppendLine("<td align=\"right\">10 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(11, 10.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("<td align=\"right\">全程马拉松</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(16, 42.2, speed, v1, v2)) + "</td>");
                sk.AppendLine("</tr>");
                sk.AppendLine("<tr>");
                sk.AppendLine("<td align=\"right\">15 Km</td>");
                sk.AppendLine("<td>" + SecondsToHms(Intreplate(12, 15.0, speed, v1, v2)) + "</td>");
                sk.AppendLine("<td></td>");
                sk.AppendLine("<td></td>");
                sk.AppendLine("</tr>");
                sk.AppendLine("</table>");

                Response.Write(sk.ToString());

                find = true;
                break;
            }
        }

        if (find == false)
        {
            //Response.Write("没有匹配数据" + String.Format("{0:F2}",speed) + String.Format("{0:F2}",seconds/3600.0) + "<br>");
            //Response.Write("没有匹配数据<br>");
            
            if(speed < 3.25) 
            {
                Response.Write("简直不可思议!没有匹配数据<br>");
                return;
            }

            if(speed > 19.0) 
            {
                Response.Write("简直不可思议!没有匹配数据<br>");
                return;
            }

            StringBuilder ss = new StringBuilder();

            //ss.AppendLine(String.Format("{0:F2}",speed) + "<br>");

            ss.AppendLine("<table id=\"tab\" width=\"100%\" border=\"1\" bordercolor=\"#CCCCCC\" cellpadding=\"0\" cellspacing=\"0\">");
            ss.AppendLine("<tr>");
            ss.AppendLine("<td align=\"right\">1 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(1.0, speed)) + "</td>");
            ss.AppendLine("<td align=\"right\">20 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(20.0, speed)) + "</td>");
            ss.AppendLine("</tr>");
            ss.AppendLine("<tr>");
            ss.AppendLine("<td align=\"right\">2 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(2.0, speed)) + "</td>");
            ss.AppendLine("<td align=\"right\">半程马拉松</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(21.1, speed)) + "</td>");
            ss.AppendLine("</tr>");
            ss.AppendLine("<tr>");
            ss.AppendLine("<td align=\"right\">5 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(5.0, speed)) + "</td>");
            ss.AppendLine("<td align=\"right\">30 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(30.0, speed)) + "</td>");
            ss.AppendLine("</tr>");
            ss.AppendLine("<tr>");
            ss.AppendLine("<td align=\"right\">10 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(10.0, speed)) + "</td>");
            ss.AppendLine("<td align=\"right\">全程马拉松</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(42.2, speed)) + "</td>");
            ss.AppendLine("</tr>");
            ss.AppendLine("<tr>");
            ss.AppendLine("<td align=\"right\">15 Km</td>");
            ss.AppendLine("<td>" + SecondsToHms(Balance(15.0, speed)) + "</td>");
            ss.AppendLine("<td></td>");
            ss.AppendLine("<td></td>");
            ss.AppendLine("</tr>");
            ss.AppendLine("</table>");

            Response.Write(ss.ToString());

            return;
        }

        #endregion
    }

    private double String2Time(string s)
    {
        string[] sa = s.Split(':');
        if (sa.Length > 2)
        {
            return Int32.Parse(sa[0]) * 3600.0 + Int32.Parse(sa[1]) * 60.0 + Int32.Parse(sa[2]);
        }
        else
        {
            return Int32.Parse(sa[0]) * 60.0 + Int32.Parse(sa[1]);
        }
        return 0.0;
    }

    private double Intreplate(int idx, double distance, double speed, string[] v1, string[] v2)
    {
        double x = speed;
        double x1 = Double.Parse(v1[1]);
        double x2 = Double.Parse(v2[1]);
        double y1 = String2Time(v1[idx]);
        double y2 = String2Time(v2[idx]);
        double y = (x - x1) * (y2 - y1) / (x2 - x1) + y1;
        return y;
    }


    private double Balance(double distance, double speed)
    {
        // speed = km / hour
        return (distance * 3600.0 / speed);
    }

    /// <summary>
    /// 将“秒”转换为“?分?秒”
    /// </summary>
    /// <param name="local_seconds"></param>
    /// <returns></returns>
    private string SecondsToHms(double local_seconds)
    {
        int hours = (int)Math.Floor(local_seconds / 60.0 / 60.0);
        int minutes = (int)Math.Floor((local_seconds - hours * 3600.0) / 60.0);
        int seconds = (int)Math.Floor(local_seconds - hours * 3600.0 - minutes * 60.0);

        return String.Format("{0:D2}时{1:D2}分{2:D2}秒", hours , minutes, seconds);
    }
}
