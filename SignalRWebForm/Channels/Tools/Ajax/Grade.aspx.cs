using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Channels_Tools_Ajax_Grade : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        Hashtable hash = Tools.Grade();

        #region 计算过程


        string gender = "male";
        if (Request.QueryString["gender"] != null)
        {
            gender = Request.QueryString["gender"].ToString();
        }

        string style = "5km";
        if (Request.QueryString["style"] != null)
        {
            style = Request.QueryString["style"].ToString();
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

        if (seconds < 1)
        {
            Response.Write("数据错误<br>");
            return;
        }

        string sname = (gender == "male") ? "男子" : "女子";


        #region 业余成绩

        string[] g1Name = ("一级,二级,三级").Split(',');

        if (hash["a" + gender + style] != null)
        {
            string values = (string)hash["a" + gender + style];
            string[] va = values.Split(',');
            int idx = 0;
            if (age <= 29) idx = 0;
            if (age >= 30 && age <= 44) idx = 3;
            if (age >= 45 && age <= 59) idx = 6;
            if (age >= 60) idx = 9;
            string grsl = "";
            for (int i = idx; i < idx + 3; i++)
            {
                double s_time = String2Time(va[i]);
                if (seconds < s_time)
                {
                    grsl = g1Name[i - idx];
                    /*
                    if (i == idx)
                    {
                        if (seconds < s_time * 0.8)
                        {
                            Response.Write("喔，火箭的速度啊( " + seconds + "vs " + s_time + ")！您的成绩简直难以置信！<br>");
                            break;
                        }
                    }
                    */
                    Response.Write("您的成绩达到了全国田径业余锻炼等级标准(" + sname + "):" + grsl + "运动员的水平，达标成绩为：" + va[i] + "<br>");
                    break;
                }
            }
            if (grsl.Length < 1)
            {
                Response.Write("您的成绩没有达到全国田径业余锻炼等级标准(" + sname + ")运动员的水平，基本达标成绩为：" + va[idx + 2] + "<br>");
            }
        }
        else
        {
            Response.Write("没有该级别全国田径业余锻炼等级标准数据.<br>");
        }

        #endregion

        #region 专业成绩

        string[] g2Name = ("国际级运动健将,运动健将,一级运动员,二级运动员,三级运动员").Split(',');

        if (hash["b" + gender + style] != null)
        {
            string values = (string)hash["b" + gender + style];
            string[] va = values.Split(',');

            string grsl = "";
            for (int i = 0; i < 5; i++)
            {
                double s_time = String2Time(va[i]);
                if (seconds < s_time)
                {
                    grsl = g2Name[i];
                    /*
                    if (i == 0)
                    {
                        if (seconds < s_time * 0.8)
                        {
                            Response.Write("喔，火箭的速度啊！您的成绩简直难以置信！<br>");
                            break;
                        }
                    }
                    */
                    Response.Write("您的成绩达到了(" + sname + ")专业:" + grsl + "的水平，达标成绩为：" + va[i] + "<br>");
                    break;
                }
            }
            if (grsl.Length < 1)
            {
                Response.Write("您的成绩没有达到(" + sname + ")专业运动员的水平，基本达标成绩为：" + va[4] + "<br>");
            }
        }
        else
        {
            Response.Write("没有该级别专业运动员标准数据.<br>");
        }
        #endregion

        #endregion
    }

    private double String2Time(string s)
    {
        string[] sa = s.Split(':');
        if (sa.Length > 2)
        {
            return Int32.Parse(sa[0]) * 3600 + Int32.Parse(sa[1]) * 60 + Int32.Parse(sa[2]);
        }
        else
        {
            return Int32.Parse(sa[0]) * 60 + Int32.Parse(sa[1]);
        }
        return 0;
    }

}
