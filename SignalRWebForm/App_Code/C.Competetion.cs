
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using DB4=Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
namespace ERUN360.Entity
{

    public partial class RaceCompetetion : SQLHelper
    {

        private string Date2Href(int year, int month, int day)
        {
            return "ComptOfDay(" + year + "," + month + "," + day + ")";
        }

        public string XCalendar(int year, int month, int day, int iduser)
        {
            #region 查询并获取 yeay-month 当月的竞赛信息

            DateTime d_a = DateTime.Parse(year + "-" + month + "-1 00:00:00");
            //DateTime d_a1 = d_a.AddSeconds(-1);
            DateTime d_a2 = d_a.AddMonths(1).AddSeconds(-1);

            int page_count = 0;
            RaceCompetetion comp = new RaceCompetetion();
            //List<RaceCompetetionInfo> list = comp.PageList(1, 1000, "WHERE idBlog>0 AND (dRaceBegin BETWEEN '" + d_a1.ToString("yyyy-MM-dd HH:mm:ss") + "' AND '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "')", "ORDER BY dRaceBegin ASC", out page_count);

            List<RaceCompetetionInfo> list = comp.PageList(1, 1000, "WHERE idBlog>0 AND ((dRaceBegin BETWEEN '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "') or (dRaceEnd BETWEEN '" + d_a.ToString("yyyy-MM-dd HH:mm:ss") + "' AND '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "'))", "ORDER BY dRaceBegin ASC", out page_count);

            #endregion

            //int tableWidth = 647;
            ////int leftWidth = 350;
            //string hrefNormal = "#000000";
            //string hrefLight = "#EE0000";
            //string backLeft = "#F0F0F0";
            ////string backRight = "#F0F0F0";
            //string borderColor = "#C0C0C0";

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
        private string CompeteIcon(int year, int month, int day, List<RaceCompetetionInfo> list)
        {
            if (list == null) return "";
            if (list.Count == 0) return "";

            StringBuilder sb = new StringBuilder();
            foreach (RaceCompetetionInfo c in list)
            {
                if (c.dRaceBegin.Year == year && c.dRaceBegin.Month == month && c.dRaceBegin.Day == day)
                {
                    string cs = GCommon.FindValue("idCompeteStyle", c.idCompeteStyle.ToString());
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
        public string CompeteList(int year, int month, int day, int iduser, List<RaceCompetetionInfo> list)
        {

            int page_count = 0;
            if (list == null)
            {
                DateTime d_a = DateTime.Parse(year + "-" + month + "-1 00:00:00");
                DateTime d_a1 = d_a.AddSeconds(-1);
                DateTime d_a2 = d_a.AddMonths(1).AddDays(-1);
                RaceCompetetion comp = new RaceCompetetion();
                list = comp.PageList(1, 100, "WHERE idBlog>0 AND (dRaceEnd BETWEEN '" + d_a1.ToString("yyyy-MM-dd HH:mm:ss") + "' AND '" + d_a2.ToString("yyyy-MM-dd HH:mm:ss") + "')", "ORDER BY dRaceBegin ASC", out page_count);
                if (page_count == 0) return "";
            }
            if (list == null) return "";

            StringBuilder sd = new StringBuilder();
            foreach (RaceCompetetionInfo c in list)
            {
                if (c.idBlog > 0)
                {
                    sd.Append(c.idBlog + ",");
                }
            }
            if (sd.Length < 0) return "";

            Hashtable hash = new Hashtable();
            Blog bl = new Blog();
            List<BlogInfo> blist = bl.PageList(1, 1000, "WHERE id IN (" + XString.UnTail(sd.ToString()) + ")", "ORDER BY id ASC", out page_count);
            if (page_count == 0)
            {
                if(day==0)
                {
                    return "<div class=\"thisdata\">" + year + "年" + month + "月" + "</div><div class=\"todyno\">当月无赛事！</div>";
                }
                else
                return "<div class=\"thisdata\">" + year + "年" + month + "月" +day+ "日</div><div class=\"todyno\">当日 无赛事！</div>";
            }
            foreach (BlogInfo bu in blist)
            {
                if (hash[bu.id] == null)
                {
                    hash.Add(bu.id, bu);
                }
            }

            RaceJoin rj = new RaceJoin();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div class=\"thisdata\">");
            if (day == 0)
            {
                sb.AppendLine(year + "年" + month + "月");
            }
            else
                sb.AppendLine(year + "年" + month + "月" + day + "日");
            sb.AppendLine("</div>");
            foreach (RaceCompetetionInfo c in list)
            {
                if ((c.dRaceEnd.Year == year && c.dRaceEnd.Month == month) || (c.dRaceBegin.Year == year && c.dRaceBegin.Month == month))
                {
                    string cs = GCommon.FindValue("idCompeteStyle", c.idCompeteStyle.ToString());
                    if (cs.Length > 0)
                    {
                        BlogInfo bs = (BlogInfo)hash[c.idBlog];
                        if (bs != null)
                        {
                            sb.AppendLine("<div style=\"border-bottom:solid 1px #f5f5f5;margin-bottom:16px;font-size:12px;padding-bottom:16px;\">");
                            sb.AppendLine("<span id=\"comp_icon_" + cs.Substring(0, 1).ToLower() + "\" title=\"" + cs + "\"></span>");
                            sb.AppendLine("<a href=\"" + UrlHelper.BlogUrl(c.idBlog) + "\"  target=\"_blank\">" + bs.cTitle + "</a><br>");
                            sb.AppendLine("比赛日期：" + c.dRaceBegin.ToString("yyyy-MM-dd") + "<br>");

                            List<RaceJoinInfo> jlist = rj.PageList(1, 10000, "WHERE idActivity=" + c.id, "", out page_count);
                            sb.AppendLine("关注人数：" + page_count + " 人 ");
                            if (iduser > 0)
                            {
                                page_count = 0;
                                List<RaceJoinInfo> mlist = rj.PageList(1, 1, "WHERE idActivity=" + c.id + " AND idUser=" + iduser, "", out page_count);
                                if (page_count == 0)
                                {
                                    sb.AppendLine("<br><span id=\"comp_join"+c.id+"\" class=\"comp_join\"onclick=\"JoinCreate(" + bs.idUser + "," + c.id + ")\"></span> ");
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
                            //if (DateTime.Now < c.dJoinEnd)
                            //{
                                
                            //}
                            //else
                            //{
                            //    sb.AppendLine("<span class=\"comp_yjz\">已截止</span> ");
                            //}                            
                            if (new DB4.tblRACE_SIGNUP().ExistsCompete(c.id))
                            {                                
                                DBM4.tblRACE_SIGNUP mSignup = new DB4.tblRACE_SIGNUP().GetCompeteModelByCache(c.id);
                                if (mSignup != null)
                                {
                                    if (iduser > 0)
                                    {
                                        if (2 == new DB4.tblRACE_SALES().GetState(iduser, c.id))
                                        {
                                            sb.AppendLine("<span class=\"comp_ybm\"></span> ");
                                        }
                                        else
                                        {
                                            if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                            {
                                                sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + c.id + "\"><span class=\"comp_lbm\"></span></a>");

                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (Convert.ToDateTime(mSignup.dJoinEnd.ToString()) >= DateTime.Now)
                                        {
                                            sb.AppendLine("<a  id=\"baoming_info\" target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + c.id + "\"><span class=\"comp_lbm\"></span></a> ");

                                        }
                                    }
                                    
                                }
                                //else
                                //{
                                //    //if (DateTime.Now > Convert.ToDateTime(c.dJoinEnd.ToString()))
                                //    //{
                                //    //    State.AppendLine("<a id=\"foucs_ss3\">报名截止</a>");
                                //    //}
                                //}
                            }
                           

                            //sb.AppendLine("<span class=\"comp_lbm\">立即报名</span> ");
                            //sb.AppendLine("<span class=\"comp_ybm\">已报名</span> ");
                            sb.AppendLine("</div>");
                        }
                    }
                }
            }
            return sb.ToString();
        }
    }
}
