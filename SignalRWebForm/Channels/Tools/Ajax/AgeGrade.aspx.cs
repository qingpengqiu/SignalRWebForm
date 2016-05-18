using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Channels_Tools_Ajax_AgeGrade : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        Hashtable hash = Tools.AgeGrade();

        #region 计算过程

        string gender = "male";
        if (Request.QueryString["gender"] != null)
        {
            gender = Request.QueryString["gender"].ToString().ToLower();
        }

        string style = "5km";
        if (Request.QueryString["style"] != null)
        {
            style = Request.QueryString["style"].ToString().ToLower();
        }

        int age = 25;
        if (Request.QueryString["age"] != null)
        {
            age = Int32.Parse(Request.QueryString["age"].ToString());
            if (age < 10) age = 10;
            if (age > 100) age = 100;
        }

        int seconds = 1;
        if (Request.QueryString["seconds"] != null)
        {
            seconds = Int32.Parse(Request.QueryString["seconds"].ToString());
            if (seconds < 1) seconds = 1;
            if (seconds > 57600) seconds = 57600;
        }

        if (hash[gender + style] != null)
        {
            string values = (string)hash[gender + style];
            string[] va = values.Split(',');
            // 获得参考系数
            double fact = Double.Parse(va[age - 3]);
            // 25岁组的成绩
            double best_seconds = Double.Parse(va[1]);
            // 该年龄组的成绩
            double group_seconds = best_seconds / fact;
            // 百分比
            double percent = 100.0 * group_seconds / seconds;

            string desc = "初级水平";
            if (percent >= 100.0) desc = "世界纪录水平";
            else if (percent >= 90.0) desc = "世界水平";
            else if (percent >= 80.0) desc = "全国水平";
            else if (percent >= 70.0) desc = "地区水平";
            else if (percent >= 60.0) desc = "本地水平";
            else desc = "初级水平";

            Response.Write("该年龄(" + age + "周岁)的等级用时是：" + SecondsToHms(100.0 * group_seconds * fact / percent) + "<br>");
            Response.Write("您的年龄等级得分是：" + String.Format("{0:F2}", percent) + " % 属于：" + desc + "<br>");
            Response.Write("要实现世界记录(100%)，需用时：" + SecondsToHms(group_seconds) + " 配速：" + String.Format("{0:F2}", 3600.0 * Double.Parse(va[0]) / group_seconds) + " Km/h(" + SecondsToHms(group_seconds / Double.Parse(va[0])) + "/公里)<br>");
            //Response.Write("要实现当地水平(60%)，需用时：" + SecondsToHms(group_seconds / 0.6) + " 配速：" + String.Format("{0:F2}", 0.6 * 3600.0 * Double.Parse(va[0]) / group_seconds) + " Km/h(" + SecondsToHms(group_seconds * 0.6 / Double.Parse(va[0])) + "/公里)<br>");
        }
        else
        {
            Response.Write("系统错误");
        }

        #endregion
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

        if(hours<1) return String.Format("{0}分{1}秒", hours * 60 + minutes, seconds);
        return String.Format("{0}小时{1}分{2}秒", hours,minutes, seconds);
    }
}
