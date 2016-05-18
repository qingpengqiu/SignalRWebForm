using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using ERUN360.Entity;
using System.Data;

public partial class _Utility_Ajax_Competetion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

		#region 身份确认
        Member m = new Member();
        int iduser = 0;
        if (m.Default != null)
        {
            iduser = m.Default.id;
        }
        #endregion

        int year = 0;
        if (Request.QueryString["year"] != null)
        {
            year = Int32.Parse(Request.QueryString["year"].ToString());
        }
        int month = 0;
        if (Request.QueryString["month"] != null)
        {
            month = Int32.Parse(Request.QueryString["month"].ToString());
        }
        int day = 0;
        if (Request.QueryString["day"] != null)
        {
            day = Int32.Parse(Request.QueryString["day"].ToString());
        }

        #region 查询并获取 yeay-month 当月的竞赛信息

        DateTime d_a1 = DateTime.Parse(year + "-" + month + "-" + day);
        CompetetionCalendarNew rc = new CompetetionCalendarNew(); 
        DataTable dtlist =rc.RaceList();
        DataRow[] drs = dtlist.Select("dRaceBegin >= '" + d_a1.ToString("yyyy-MM-dd 0:00:00") + "' and dRaceBegin <='" + d_a1.ToString("yyyy-MM-dd 23:59:59")+"'", "dRaceBegin");
        DataTable list = new DataTable();
        if (drs.Length > 0)
        {//判断是否存在符合的数据、为下面copy，不然报错
            list = drs.CopyToDataTable();
        }
        int page_count = list.Rows.Count;
      
        #endregion

        if (page_count > 0)
        {
                     
            //RaceCompetetion rc = new RaceCompetetion();
            Response.Write(rc.CompeteList(year, month, day, iduser, list) + " ");
        }
        else
        {
            //Response.Write("没有" + year + "年" + month + "月" + day + "日的比赛信息");

            Response.Write("<div class=\"thisdata\">"+year+"年"+month+"月"+day+"日"+"</div><div class=\"todyno\">当日无赛事！</div>");
        }
    }
}
