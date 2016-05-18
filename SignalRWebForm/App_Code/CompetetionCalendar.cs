using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
using System.Collections;
/// <summary>
/// CompetetionCalendar 的摘要说明
/// </summary>
public class CompetetionCalendarNew
{
    public CompetetionCalendarNew()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    private string Date2Href(int year, int month, int day)
    {
        return "ComptOfDay(" + year + "," + month + "," + day + ")";
    }

    public string XCalendar(int year, int month, int day, int iduser)
    {
        #region 查询并获取 yeay-month 当月的竞赛信息

        DateTime d_a = DateTime.Parse(year + "-" + month + "-1 00:00:00");
        DateTime d_a2 = d_a.AddMonths(1).AddSeconds(-1);
        DataTable dtlist = RaceList();
        DataRow[] drs = dtlist.Select(" ((dRaceBegin>= '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND dRaceBegin<='" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "') or (dRaceEnd >= '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND dRaceEnd <= '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "'))", "dRaceBegin");
        DataTable list = new DataTable();
        if (drs.Length > 0)
        {//判断是否存在符合的数据、为下面copy，不然报错
            list = drs.CopyToDataTable();
        }
        #endregion

        StringBuilder sb = new StringBuilder();
        string head = "\t\t\t";
        DateTime d_01 = DateTime.Parse(year + "-" + month + "-1 00:00:00");
        DateTime d_02 = d_01.AddMonths(1).AddDays(-1);
        DateTime d_03 = d_01.AddMonths(-1);
        DateTime d_04 = d_01.AddMonths(1);
        sb.AppendLine(head + "<div class=\"Calendarheader\">");
        sb.AppendLine(head + "<a class=\"weekfist\" href=\"?year=" + d_03.Year + "&month=" + d_03.Month + "\" title=\"" + d_03.Year + "," + d_03.Month + "\"></a>");
        sb.AppendLine(head + "<div class=\"moremoth\">" + year + "年 " + String.Format("{0:D1}", month) + "月 <div class=\"moremotha\"><a href=\"?year=" + d_01.Year + "&month=1\">1月</a><a href=\"?year=" + d_01.Year + "&month=2\">2月</a><a href=\"?year=" + d_01.Year + "&month=3\">3月</a><a href=\"?year=" + d_01.Year + "&month=4\">4月</a><a href=\"?year=" + d_01.Year + "&month=5\">5月</a><a href=\"?year=" + d_01.Year + "&month=6\">6月</a><a href=\"?year=" + d_01.Year + "&month=7\">7月</a><a href=\"?year=" + d_01.Year + "&month=8\">8月</a><a href=\"?year=" + d_01.Year + "&month=9\">9月</a><a href=\"?year=" + d_01.Year + "&month=10\">10月</a><a href=\"?year=" + d_01.Year + "&month=11\">11月</a><a href=\"?year=" + d_01.Year + "&month=12\">12月</a></div></div>");
        sb.AppendLine(head + "<a class=\"weeklast\" href=\"?year=" + d_04.Year + "&month=" + d_04.Month + "\" title=\"" + d_04.Year + "," + d_04.Month + "\"></a>");
        sb.AppendLine(head + "</div>");
        sb.AppendLine(head + "<div class=\"Calendarbody\"><div class=\"Calendarbodyrighttop\"></div>");
        sb.AppendLine(head + "<div class=\"Calendarbodyleft\">");
        sb.AppendLine(head + "<div class=\"weekbox\">Sun</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Mon</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Tue</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Wed</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Thu</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Fri</div>");
        sb.AppendLine(head + "<div class=\"weekbox\">Sat</div>");
        int didx = 0;
        for (int d = 1; d <= d_02.Day; d++)
        {
            DateTime dt = DateTime.Parse(year + "-" + month + "-" + d + " 00:00:00");
            // 留出第一天前面的星期天数
            if (d == 1)
            {
                int dweek = Int32.Parse(dt.DayOfWeek.ToString("D"));
                if (dweek > 0)
                {
                    for (int j = 0; j < dweek; j++)
                    {
                        sb.AppendLine(head + "<div class=\"cal_space\"></div>");
                        didx++;
                    }
                }
            }
            DateTime DateOfDay = DateTime.Parse(year + "/" + month + "/" + d);
            if (year == DateTime.Now.Year && month == DateTime.Now.Month && d == DateTime.Now.Day)
            {
                if ((int)DateOfDay.DayOfWeek == 6)
                {
                    sb.AppendLine(head + "<div class=\"thisday\" onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(dt.Year, dt.Month, dt.Day, list) + "</div><div class=\"comclear\"><div>");
                }
                else
                {
                    sb.AppendLine(head + "<div class=\"thisday\" onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(dt.Year, dt.Month, dt.Day, list) + "</div>");
                }
                
            }
            else
            {
                if ((int)DateOfDay.DayOfWeek == 6)
                {
                    sb.AppendLine(head + "<div onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(year, month, d, list) + "</div><div class=\"comclear\"></div>");
                }
                else
                {
                    sb.AppendLine(head + "<div onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(year, month, d, list) + "</div>");
                }

            }
            didx++;
        }
        // 继续显示最后一天后面的星期以补齐数量
        while ((didx % 7) != 0)
        {
            sb.AppendLine(head + "<div class=\"cal_space\"></div>");
            didx++;
        }
        if (didx < 42)
        {
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div class=\"cal_spacen\"></div>");
        }
        sb.AppendLine(head + "<div class=\"iconex\"><span class=\"comp_icon_m\">全程马拉松</span><span class=\"comp_icon_h\">半程马拉松</span><span class=\"comp_icon_r\">路跑</span><span class=\"comp_icon_c\">越野跑</span><span class=\"comp_icon_u\">超级马拉松</span><span class=\"comp_icon_t\">其它</span></div></div>");
        sb.AppendLine(head + "<div id=\"competInfos\" class=\"Calendarbodyright\">");
        sb.AppendLine(CompeteList(year, month, day, iduser, list));
        sb.AppendLine(head + "</div>");
        sb.AppendLine(head + "</div>");

        return sb.ToString();
    }

    /// <summary>
    /// 显示赛事信息的标记[U]什么的在日期格子中
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <param name="day"></param>
    /// <param name="list"></param>
    /// <returns></returns>
    private string CompeteIcon(int year, int month, int day, DataTable list)
    {
        if (list == null) return "";
        if (list.Rows.Count == 0) return "";

        StringBuilder sb = new StringBuilder();

        foreach (DataRow myRow in list.Rows)
        {
            int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
            int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
            int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
            if (mYear == year && mMonth == month && mDay == day)
            {
                string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                if (cs.Length > 0)
                {
                    sb.Append("<span class=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\"></span>");
                }
            }
        }
        return sb.ToString();
    }

    /// <summary>
    /// 显示赛事信息于右侧列表
    /// 同时用于AJAX回显
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <param name="day"></param>
    /// <param name="list"></param>
    /// <returns></returns>
    public string CompeteList(int year, int month, int day, int iduser, DataTable list)
    {
        if (list == null) return "";
        StringBuilder sd = new StringBuilder();
        if (list.Rows.Count == 0)
        {
            if (day == 0)
                return "<div class=\"thisdata\">" + year + "年" + month + "月" + "</div><div class=\"todyno\">当月无赛事！</div>";
            else
                return "<div class=\"thisdata\">" + year + "年" + month + "月" + day + "日</div><div class=\"todyno\">当日 无赛事！</div>";
        }

        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"thisdata\">");
        if (day == 0)
        {
            sb.AppendLine(year + "年" + month + "月");
        }
        else
            sb.AppendLine(year + "年" + month + "月" + day + "日");
        sb.AppendLine("</div>");
        DB4.tblRACE_JOIN bllJoin = new DB4.tblRACE_JOIN();
        if (day == 0)
        {
            foreach (DataRow myRow in list.Rows)
            {
                int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
                int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
                int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
                int id = TypeChangeDefault.NullToInt(myRow["id"].ToString(), 0);//赛事id
                int idBlog = TypeChangeDefault.NullToInt(myRow["idBlog"].ToString(), 0);

                if (mYear == year && mMonth == month)
                {
                    string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                    if (cs.Length > 0)
                    {
                        sb.AppendLine("<div class=\"Calendarrbox\">");
                        sb.AppendLine("<span class=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\" title=\"" + cs + "\"></span>");

                        if (idBlog == 0)
                        {
                            sb.AppendLine("<a href=\"/Competetion/EventDetails.aspx?sid=" + id + "&nav=1\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        else
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(idBlog) + "\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        sb.AppendLine("比赛日期：" + Convert.ToDateTime(myRow["dRaceBegin"].ToString()).ToString("yyyy-MM-dd") + "<br>");
                        int page_count = 0;
                        page_count = bllJoin.GetRecordCount("idActivity=" + id);                     
                        sb.AppendLine("关注人数：" + page_count + " 人 ");
                        if (iduser > 0)
                        {
                          
                            int count = bllJoin.GetRecordCount("idActivity=" + id + " AND idUser=" + iduser);
                            if (count == 0)
                            {
                                sb.AppendLine("<br><a class=\"comp_join\"onclick=\"JoinCreate(" + iduser + "," + id + ")\">关注</a> ");
                            }
                            else
                            {
                                sb.AppendLine("<br><a class=\"comp_ygz\">已关注</a> ");
                            }
                        }
                        else
                        {
                            sb.AppendLine("<br><a class=\"comp_join\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">关注</a> ");
                        }

                        if (id >= 300002000)
                        {
                            int bmcount = new DB6.tblRace_Detail().GetRecordCount("idCompete=" + id + " and idUser=" + iduser);
                            if (bmcount > 0)
                            {
                                sb.AppendLine("<a class=\"comp_ybm\">已报名</a> ");
                            }
                            else
                            {
                                if (Convert.ToDateTime(myRow["dJoinEnd"].ToString()) >= DateTime.Now)
                                {
                                    if (idBlog == 0)
                                    {
                                        sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + id + "&nav=2\">立即报名</a>");
                                    }
                                    else
                                    {
                                        sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a> ");
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (new DB4.tblRACE_SIGNUP().ExistsCompete(id))
                            {
                                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetCompeteModelByCache(id);
                                if (mSignup != null)
                                {
                                    if (iduser > 0)
                                    {
                                        if (2 == new DB4.tblRACE_SALES().GetState(iduser, id))
                                        {
                                            sb.AppendLine("<a class=\"comp_ybm\">已报名</a> ");
                                        }
                                        else
                                        {
                                            if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                            {
                                                sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a>");

                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                        {
                                            sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a> ");

                                        }
                                    }

                                }
                            }
                        }
                        sb.AppendLine("</div>");
                    }
                }

            }
        }
        else
        {
            foreach (DataRow myRow in list.Rows)
            {
                int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
                int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
                int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
                int id = TypeChangeDefault.NullToInt(myRow["id"].ToString(), 0);//赛事id
                int idBlog = TypeChangeDefault.NullToInt(myRow["idBlog"].ToString(), 0);

                if (mYear == year && mMonth == month && mDay == day)
                {
                    string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                    if (cs.Length > 0)
                    {
                        sb.AppendLine("<div class=\"Calendarrbox\">");
                        sb.AppendLine("<span class=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\" title=\"" + cs + "\"></span>");
                        if (idBlog > 0)
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(idBlog) + "\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        else
                        {
                            sb.AppendLine("<a href=\"/Competetion/EventDetails.aspx?sid=" + id + "&nav=1\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        sb.AppendLine("比赛日期：" + Convert.ToDateTime(myRow["dRaceBegin"].ToString()).ToString("yyyy-MM-dd") + "<br>");
                        int page_count = 0;
                        page_count = bllJoin.GetRecordCount("idActivity=" + id);                      
                        sb.AppendLine("关注人数：" + page_count + " 人 ");
                        if (iduser > 0)
                        {
                            int count = bllJoin.GetRecordCount("idActivity=" + id + " AND idUser=" + iduser);
                            if (count == 0)
                            {
                                sb.AppendLine("<br><a class=\"comp_join\"onclick=\"JoinCreate(" + iduser + "," + id + ")\">关注</a> ");
                            }
                            else
                            {
                                sb.AppendLine("<br><a class=\"comp_ygz\">已关注</a> ");
                            }
                        }
                        else
                        {
                            sb.AppendLine("<br><a class=\"comp_join\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\">关注</a> ");
                        }
                        if (id >= 300002000)
                        {
                            int bmcount = new DB6.tblRace_Detail().GetRecordCount("idCompete=" + id + " and idUser=" + iduser);
                            if (bmcount > 0)
                            {
                                sb.AppendLine("<a class=\"comp_ybm\">已报名</a> ");
                            }
                            else
                            {
                                if (Convert.ToDateTime(myRow["dJoinEnd"].ToString()) >= DateTime.Now)
                                {
                                    if (idBlog == 0)
                                    {
                                        sb.AppendLine("<a class=\"comp_lbm\" href=\"/Competetion/projects.aspx?sid=" + id + "&nav=2\">立即报名</a>");
                                    }
                                    else
                                    {
                                        sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a> ");
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (new DB4.tblRACE_SIGNUP().ExistsCompete(id))
                            {
                                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetCompeteModelByCache(id);
                                if (mSignup != null)
                                {
                                    if (iduser > 0)
                                    {
                                        if (2 == new DB4.tblRACE_SALES().GetState(iduser, id))
                                        {
                                            sb.AppendLine("<a class=\"comp_ybm\">已报名</a> ");
                                        }
                                        else
                                        {
                                            if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                            {
                                                sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a>");

                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                        {
                                            sb.AppendLine("<a class=\"comp_lbm\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\">立即报名</a> ");

                                        }
                                    }

                                }
                            }
                        }
                        sb.AppendLine("</div>");
                    }
                }

            }
        }
        return sb.ToString();
    }

    //获取赛事列表（新老板赛事）
    public DataTable RaceList()
    {
        string CacheKey = "RaceCalendar";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            string sql = @" SELECT id, idBlog, idCompeteStyle, idCity, cCityname, cTitle
                            ,case  when idCity>3500 then 2 WHEN idCity > 3200 AND idCity < 3500  THEN 3 else 1 end as iType, dRaceBegin, dRaceEnd
                            , dJoinBegin, dJoinEnd, dCreate
                            FROM YP_DB_4.dbo.tblRACE_COMPETETION a
                            where id in(select idCompete from YP_DB_4.dbo.tblRACE_SIGNUP)
                            union all
                            SELECT id, '0' idBlog,idCompeteStyle, idCity, cCityname, cTitle,iType, dRaceBegin, dRaceEnd, dJoinBegin
                            , dJoinEnd, dCreate                                 
                            FROM YP_DB_6.dbo.tblRace_Competition b
                             where iStatus =1 ";
            DataTable sydt = new DB6.tblRace_Competition().QueryByPage(sql, "", "dRaceBegin ", 1, 10000).Tables[0];
            objModel = sydt;
            if (objModel != null)
            {
                int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            }
        }
        return (DataTable)objModel;
    }

}

public class CompetetionCalendar
{
    public CompetetionCalendar()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    private string Date2Href(int year, int month, int day)
    {
        return "ComptOfDay(" + year + "," + month + "," + day + ")";
    }

    public string XCalendar(int year, int month, int day, int iduser)
    {
        #region 查询并获取 yeay-month 当月的竞赛信息

        DateTime d_a = DateTime.Parse(year + "-" + month + "-1 00:00:00");
        DateTime d_a2 = d_a.AddMonths(1).AddSeconds(-1);
        DataTable dtlist = RaceList();
        DataRow[] drs = dtlist.Select(" ((dRaceBegin>= '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND dRaceBegin<='" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "') or (dRaceEnd >= '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND dRaceEnd <= '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "'))", "dRaceBegin");
        DataTable list = new DataTable();
        if (drs.Length > 0)
        {//判断是否存在符合的数据、为下面copy，不然报错
            list = drs.CopyToDataTable();
        }
        #endregion

        StringBuilder sb = new StringBuilder();
        string head = "\t\t\t";

        DateTime d_01 = DateTime.Parse(year + "-" + month + "-1 00:00:00");
        DateTime d_02 = d_01.AddMonths(1).AddDays(-1);
        DateTime d_03 = d_01.AddMonths(-1);
        DateTime d_04 = d_01.AddMonths(1);

        sb.AppendLine(head + "<div>");
        sb.AppendLine(head + "<table width=\"100%\" cellspacing=\"0\"  border=0 style=\"text-align:center;\">");
        sb.AppendLine(head + "<tr>");
        sb.AppendLine(head + "<td class=\"rltitle\">");
        sb.AppendLine(head + "<a class=\"weekfist\" href=\"?year=" + d_03.Year + "&month=" + d_03.Month + "\" title=\"" + d_03.Year + "," + d_03.Month + "\"></a> &nbsp;&nbsp;");
        sb.AppendLine(head + "" + year + "年 " + String.Format("{0:D1}", month) + "月 <div class=\"moremoth\"><div class=\"moremotha\"><a href=\"?year=" + d_01.Year + "&month=1\">1月</a><a href=\"?year=" + d_01.Year + "&month=2\">2月</a><a href=\"?year=" + d_01.Year + "&month=3\">3月</a><a href=\"?year=" + d_01.Year + "&month=4\">4月</a><a href=\"?year=" + d_01.Year + "&month=5\">5月</a><a href=\"?year=" + d_01.Year + "&month=6\">6月</a><a href=\"?year=" + d_01.Year + "&month=7\">7月</a><a href=\"?year=" + d_01.Year + "&month=8\">8月</a><a href=\"?year=" + d_01.Year + "&month=9\">9月</a><a href=\"?year=" + d_01.Year + "&month=10\">10月</a><a href=\"?year=" + d_01.Year + "&month=11\">11月</a><a href=\"?year=" + d_01.Year + "&month=12\">12月</a></div></div>&nbsp;&nbsp;");
        sb.AppendLine(head + "<a class=\"weeklast\" href=\"?year=" + d_04.Year + "&month=" + d_04.Month + "\" title=\"" + d_04.Year + "," + d_04.Month + "\"></a>");
        sb.AppendLine(head + "</td>");
        sb.AppendLine(head + "<td style=\"width:200px;\">");
        sb.AppendLine(head + "</td>");
        sb.AppendLine(head + "</tr>");

        sb.AppendLine(head + "<tr>");
        sb.AppendLine(head + "<td valign=\"top\">");

        sb.AppendLine(head + "<div id=\"cal_href_w\">Sun</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Mon</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Tue</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Wed</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Thu</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Fri</div>");
        sb.AppendLine(head + "<div id=\"cal_href_w\">Sat</div>");

        int didx = 0;
        for (int d = 1; d <= d_02.Day; d++)
        {
            DateTime dt = DateTime.Parse(year + "-" + month + "-" + d + " 00:00:00");
            // 留出第一天前面的星期天数
            if (d == 1)
            {
                int dweek = Int32.Parse(dt.DayOfWeek.ToString("D"));
                if (dweek > 0)
                {
                    for (int j = 0; j < dweek; j++)
                    {
                        sb.AppendLine(head + "<div id=\"cal_space\"></div>");
                        didx++;
                    }
                }
            }
            if (year == DateTime.Now.Year && month == DateTime.Now.Month && d == DateTime.Now.Day)
            {
                sb.AppendLine(head + "<div id=\"cal_href_h\" onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(dt.Year, dt.Month, dt.Day, list) + "</div>");
            }
            else
            {
                sb.AppendLine(head + "<div id=\"cal_href_n\" onclick=\"" + Date2Href(year, month, d) + "\"><em>" + String.Format("{0:D1}", d) + "</em>" + CompeteIcon(year, month, d, list) + "</div>");
            }
            didx++;
        }
        // 继续显示最后一天后面的星期以补齐数量
        while ((didx % 7) != 0)
        {
            sb.AppendLine(head + "<div id=\"cal_space\"></div>");
            didx++;
        }

        if (didx < 42)
        {
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
            sb.AppendLine(head + "<div id=\"cal_spacen\"></div>");
        }

        sb.AppendLine(head + "</td>");
        sb.AppendLine(head + "<td valign=\"top\">");
        sb.AppendLine(head + "<div id=\"competInfos\">");
        sb.AppendLine(CompeteList(year, month, day, iduser, list));
        sb.AppendLine(head + "</td>");
        sb.AppendLine(head + "</tr>");
        sb.AppendLine(head + "</table>");
        sb.AppendLine(head + "</div>");

        return sb.ToString();
    }

    /// <summary>
    /// 显示赛事信息的标记[U]什么的在日期格子中
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <param name="day"></param>
    /// <param name="list"></param>
    /// <returns></returns>
    private string CompeteIcon(int year, int month, int day, DataTable list)
    {
        if (list == null) return "";
        if (list.Rows.Count == 0) return "";

        StringBuilder sb = new StringBuilder();

        foreach (DataRow myRow in list.Rows)
        {
            int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
            int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
            int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
            if (mYear == year && mMonth == month && mDay == day)
            {
                string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                if (cs.Length > 0)
                {
                    sb.Append("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\"></span>");
                }
            }
        }
        return sb.ToString();
    }

    /// <summary>
    /// 显示赛事信息于右侧列表
    /// 同时用于AJAX回显
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <param name="day"></param>
    /// <param name="list"></param>
    /// <returns></returns>
    public string CompeteList(int year, int month, int day, int iduser, DataTable list)
    {
        if (list == null) return "";
        StringBuilder sd = new StringBuilder();
        if (list.Rows.Count == 0)
        {
            if (day == 0)
                return "<div class=\"thisdata\">" + year + "年" + month + "月" + "</div><div class=\"todyno\">当月无赛事！</div>";
            else
                return "<div class=\"thisdata\">" + year + "年" + month + "月" + day + "日</div><div class=\"todyno\">当日 无赛事！</div>";
        }

        StringBuilder sb = new StringBuilder();
        sb.AppendLine("<div class=\"thisdata\">");
        if (day == 0)
        {
            sb.AppendLine(year + "年" + month + "月");
        }
        else
            sb.AppendLine(year + "年" + month + "月" + day + "日");
        sb.AppendLine("</div>");
        DB4.tblRACE_JOIN bllJoin = new DB4.tblRACE_JOIN();
        if (day == 0)
        {
            foreach (DataRow myRow in list.Rows)
            {
                int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
                int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
                int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
                int id = TypeChangeDefault.NullToInt(myRow["id"].ToString(), 0);//赛事id
                int idBlog = TypeChangeDefault.NullToInt(myRow["idBlog"].ToString(), 0);

                if (mYear == year && mMonth == month)
                {
                    string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                    if (cs.Length > 0)
                    {
                        //sb.Append("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\"></span>");
                        sb.AppendLine("<div style=\"border-bottom:solid 1px #f5f5f5;margin-bottom:16px;font-size:12px;padding-bottom:16px;\">");
                        sb.AppendLine("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\" title=\"" + cs + "\"></span>");

                        if (idBlog == 0)
                        {
                            sb.AppendLine("<a href=\"/Competetion/EventDetails.aspx?sid=" + id + "&nav=1\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        else
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(idBlog) + "\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        sb.AppendLine("比赛日期：" + Convert.ToDateTime(myRow["dRaceBegin"].ToString()).ToString("yyyy-MM-dd") + "<br>");
                        int page_count = 0;
                        page_count = bllJoin.GetRecordCount("idActivity=" + id);
                        sb.AppendLine("关注人数：" + page_count + " 人 ");
                        if (iduser > 0)
                        {

                            int count = bllJoin.GetRecordCount("idActivity=" + id + " AND idUser=" + iduser);
                            if (count == 0)
                            {
                                sb.AppendLine("<br><span id=\"comp_join" + id + "\" class=\"comp_join\"onclick=\"JoinCreate(" + iduser + "," + id + ")\"></span> ");
                            }
                            else
                            {
                                sb.AppendLine("<br><span class=\"comp_ygz\"></span> ");
                            }
                        }
                        else
                        {
                            sb.AppendLine("<br><span class=\"comp_join\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\"></span> ");
                        }

                        if (id >= 300002000)
                        {
                            int bmcount = new DB6.tblRace_Detail().GetRecordCount("idCompete=" + id + " and idUser=" + iduser);
                            if (bmcount > 0)
                            {
                                sb.AppendLine("<span class=\"comp_ybm\"></span> ");
                            }
                            else
                            {
                                if (Convert.ToDateTime(myRow["dJoinEnd"].ToString()) >= DateTime.Now)
                                {
                                    if (idBlog == 0)
                                    {
                                        sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + id + "&nav=2\"><span class=\"comp_lbm\"></span></a>");
                                    }
                                    else
                                    {
                                        sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a> ");
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (new DB4.tblRACE_SIGNUP().ExistsCompete(id))
                            {
                                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetCompeteModelByCache(id);
                                if (mSignup != null)
                                {
                                    if (iduser > 0)
                                    {
                                        if (2 == new DB4.tblRACE_SALES().GetState(iduser, id))
                                        {
                                            sb.AppendLine("<span class=\"comp_ybm\"></span> ");
                                        }
                                        else
                                        {
                                            if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                            {
                                                sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a>");

                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                        {
                                            sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a> ");

                                        }
                                    }

                                }
                            }
                        }
                        sb.AppendLine("</div>");
                    }
                }

            }
        }
        else
        {
            foreach (DataRow myRow in list.Rows)
            {
                int mYear = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Year;
                int mMonth = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Month;
                int mDay = Convert.ToDateTime(myRow["dRaceBegin"].ToString()).Day;
                int id = TypeChangeDefault.NullToInt(myRow["id"].ToString(), 0);//赛事id
                int idBlog = TypeChangeDefault.NullToInt(myRow["idBlog"].ToString(), 0);

                if (mYear == year && mMonth == month && mDay == day)
                {
                    string cs = GCommon.FindValue("idCompeteStyle", myRow["idCompeteStyle"].ToString());
                    if (cs.Length > 0)
                    {
                        //sb.Append("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\"></span>");
                        sb.AppendLine("<div style=\"border-bottom:solid 1px #f5f5f5;margin-bottom:16px;font-size:12px;padding-bottom:16px;\">");
                        sb.AppendLine("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\" title=\"" + cs + "\"></span>");
                        if (idBlog > 0)
                        {
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(idBlog) + "\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        else
                        {
                            sb.AppendLine("<a href=\"/Competetion/EventDetails.aspx?sid=" + id + "&nav=1\"  target=\"_blank\">" + myRow["cTitle"].ToString() + "</a><br>");
                        }
                        sb.AppendLine("比赛日期：" + Convert.ToDateTime(myRow["dRaceBegin"].ToString()).ToString("yyyy-MM-dd") + "<br>");
                        int page_count = 0;
                        page_count = bllJoin.GetRecordCount("idActivity=" + id);
                        sb.AppendLine("关注人数：" + page_count + " 人 ");
                        if (iduser > 0)
                        {
                            int count = bllJoin.GetRecordCount("idActivity=" + id + " AND idUser=" + iduser);
                            if (count == 0)
                            {
                                sb.AppendLine("<br><span id=\"comp_join" + id + "\" class=\"comp_join\"onclick=\"JoinCreate(" + iduser + "," + id + ")\"></span> ");
                            }
                            else
                            {
                                sb.AppendLine("<br><span class=\"comp_ygz\"></span> ");
                            }
                        }
                        else
                        {
                            sb.AppendLine("<br><span class=\"comp_join\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\"></span> ");
                        }
                        if (id >= 300002000)
                        {
                            int bmcount = new DB6.tblRace_Detail().GetRecordCount("idCompete=" + id + " and idUser=" + iduser);
                            if (bmcount > 0)
                            {
                                sb.AppendLine("<span class=\"comp_ybm\"></span> ");
                            }
                            else
                            {
                                if (Convert.ToDateTime(myRow["dJoinEnd"].ToString()) >= DateTime.Now)
                                {
                                    if (idBlog == 0)
                                    {
                                        sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + id + "&nav=2\"><span class=\"comp_lbm\"></span></a>");
                                    }
                                    else
                                    {
                                        sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a> ");
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (new DB4.tblRACE_SIGNUP().ExistsCompete(id))
                            {
                                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetCompeteModelByCache(id);
                                if (mSignup != null)
                                {
                                    if (iduser > 0)
                                    {
                                        if (2 == new DB4.tblRACE_SALES().GetState(iduser, id))
                                        {
                                            sb.AppendLine("<span class=\"comp_ybm\"></span> ");
                                        }
                                        else
                                        {
                                            if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                            {
                                                sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a>");

                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                        {
                                            sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + id + "\"><span class=\"comp_lbm\"></span></a> ");

                                        }
                                    }

                                }
                            }
                        }
                        sb.AppendLine("</div>");
                    }
                }

            }
        }
        return sb.ToString();
    }

    //获取赛事列表（新老板赛事）
    public DataTable RaceList()
    {
        string CacheKey = "RaceCalendar";
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            string sql = @" SELECT id, idBlog, idCompeteStyle, idCity, cCityname, cTitle
                            ,case  when idCity>3500 then 2 WHEN idCity > 3200 AND idCity < 3500  THEN 3 else 1 end as iType, dRaceBegin, dRaceEnd
                            , dJoinBegin, dJoinEnd, dCreate
                            FROM YP_DB_4.dbo.tblRACE_COMPETETION a
                            where id in(select idCompete from YP_DB_4.dbo.tblRACE_SIGNUP)
                            union all
                            SELECT id, '0' idBlog,idCompeteStyle, idCity, cCityname, cTitle,iType, dRaceBegin, dRaceEnd, dJoinBegin
                            , dJoinEnd, dCreate                                 
                            FROM YP_DB_6.dbo.tblRace_Competition b
                             where iStatus =1 ";
            DataTable sydt = new DB6.tblRace_Competition().QueryByPage(sql, "", "dRaceBegin ", 1, 10000).Tables[0];
            objModel = sydt;
            if (objModel != null)
            {
                int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            }
        }
        return (DataTable)objModel;
    }

}