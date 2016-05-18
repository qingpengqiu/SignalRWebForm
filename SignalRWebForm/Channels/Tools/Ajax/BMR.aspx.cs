using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Channels_Tools_Ajax_BMR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region 计算过程

        string gender = "male";
        if (Request.QueryString["gender"] != null)
        {
            gender = Request.QueryString["gender"].ToString();
        }

        int age = 25;
        if (Request.QueryString["age"] != null)
        {
            age = Int32.Parse(Request.QueryString["age"].ToString());
            if (age < 10) age = 10;
            if (age > 100) age = 100;
        }

        double weight = 0.0;
        if (Request.QueryString["weight"] != null)
        {
            weight = Double.Parse(Request.QueryString["weight"].ToString());
        }

        double height = 0.0;
        if (Request.QueryString["height"] != null)
        {
            height = Double.Parse(Request.QueryString["height"].ToString());
        }

        double prf = 0.0;
        if (Request.QueryString["prf"] != null)
        {
            prf = Double.Parse(Request.QueryString["prf"].ToString());
        }

		double bmr;
		if(gender == "male") bmr = 66.0 + (13.7 * (weight) ) + (5.0 * (height)) - (6.8 * (age));
		else bmr = 655.0 + (9.6 * (weight) ) + (1.7 * (height)) - (4.7 * (age));

		double bms = bmr * prf;

		StringBuilder sb = new StringBuilder();
		sb.AppendLine("BMR：" + String.Format("{0:F2}",bmr) + "<br>");
		sb.AppendLine("一日所需能量：" + String.Format("{0:F2}",bms) + " 千卡Kcal");
		
		Response.Write(sb.ToString());

        #endregion
    }
}
