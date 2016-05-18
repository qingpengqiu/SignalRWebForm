using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_RaceHistory : System.Web.UI.Page
{
    public UserInfo onwer;
    public string PageFace = "";
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";
    public string PageEcho = "";
    public string PageNext = "";
    public int iduser = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 身份确认
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u != null)
        {
            iduser = u.id;
        }
        #endregion

        if (Request.QueryString["id"] != null)
        {
            iduser = Int32.Parse(Request.QueryString["id"].ToString());
            if (iduser < 0) iduser = 0;
        }

        if (iduser <= 0)
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        if (Prison.Find(iduser))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        onwer = Users.Find(iduser);
        if (onwer == null) onwer = new UserInfo();

        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">填写简介...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }

        #region 博客底图相关
        PageFace = GCommon.FacePanel(onwer.id, (m.Default != null) ? m.Default.id : 0);
        #endregion

        RaceHistory table = new RaceHistory();

        // 接收数据并处理（保存）
        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            if (m.Default == null)
            {
                Response.Redirect("/");
            }

            RaceHistoryInfo record = new RaceHistoryInfo();
            record.idUser = m.Default.id;
            record.cName = m.Default.cLoginName;

            int finishedFieldCount = 0;
            
            if (Request.Form["year"] != null && Request.Form["month"] != null && Request.Form["day"] != null)
            {
                try
                {
                    record.dCreate = DateTime.Parse(Request.Form["year"].ToString() + "-" + Request.Form["month"].ToString() + "-" + Request.Form["day"].ToString() + " " + String.Format("{0:D2}:{1:D2}:{2:D2}", DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second));
                }
                catch (Exception ex)
                {
                    PageResult = "日期格式错误[" + ex.Message + "]！请检查！";
                }
            }
 
            if (Request.Form["idRoadStyle"] != null)
            {
                record.idRoadStyle = Int32.Parse(Request.Form["idRoadStyle"].ToString());
            }

            if (Request.Form["iDistance"] != null)
            {
                try
                {
                    record.iDistance = decimal.Parse(Request.Form["iDistance"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(距离)格式错误[" + ex.Message + "]！请检查！";
                }
                finishedFieldCount++;
            }

            if (Request.Form["iHours"] != null && Request.Form["iMinutes"] != null && Request.Form["iSeconds"] != null)
            {
                try
                {
                    record.dRunTime = DateTime.Parse("2001-01-01 " + Request.Form["iHours"].ToString() + ":" + Request.Form["iMinutes"].ToString() + ":" + Request.Form["iSeconds"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(时间)格式错误[" + ex.Message + "]！请检查！";
                }
                finishedFieldCount++;
            }

            if (Request.Form["cEquipment"] != null)
            {
                try
                {
                    record.cEquipment = XString.SqlSafe(Request.Form["cEquipment"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(装备描述)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            if (Request.Form["cMemo"] != null)
            {
                try
                {
                    record.cMemo = XString.SqlSafe(Request.Form["cMemo"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "数据(心得)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount > 0 && PageResult.Length == 0)
            {
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    #region 积分:发表训练记录
                    MemberHistory history = new MemberHistory();
                    history.Insert(u.id, 100800116, 1);
                    #endregion

                    CacheHelper.Clear("CACHE_RECENT_RACEHISTORY");
                    //Response.Redirect("/race/" + u.id + ".aspx");
                    Response.Redirect(UrlHelper.ScoreUrl(u.id));//"/infocenter/Trained.aspx?uId=" + u.id );
                }
                else
                {
                    PageResult = "";
                }
            }
        }

        int pageIndex = 1;
        int pageSize = 30;
        int pageCount = 0;

        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        string qry = "me";
        if (Request.QueryString["cmd"] != null)
        {
            qry = Request.QueryString["cmd"].ToString().ToLower();
        }

        string sql = "WHERE idUser=" + iduser;
        if (qry == "focus")
        {
            sql = "WHERE idUser IN (SELECT idInfo FROM [YP_DB_3].[dbo].[tblATTENTION] WHERE idUser=" + iduser + ")";
        }

        List<RaceHistoryInfo> items = new List<RaceHistoryInfo>();
        if (qry == "me")
        {
            items = table.PageList(iduser, pageIndex, pageSize, sql, "ORDER BY id DESC", out pageCount);
        }
        if (qry == "focus")
        {
            pageSize = 10;
            for (int i = 0; i < 10; i++)
            {
                int pc = 0;
                items.AddRange(table.PageList(i, pageIndex, pageSize, sql, "ORDER BY id DESC", out pc));
                if (pc > pageCount) pageCount = pc;
            }
            items.Sort(delegate(RaceHistoryInfo a, RaceHistoryInfo b) { return Comparer<DateTime>.Default.Compare(b.dCreate, a.dCreate); });
        }

        if ((pageCount % pageSize) > 0)
        {
            pageCount = (pageCount - (pageCount % pageSize)) / pageSize + 1;
        }
        else
        {
            pageCount = pageCount / pageSize;
        }

        if (pageCount <= (pageIndex + 1))
        {
            pageIndex = pageCount;
        }

        PageNext = "<div class=\"v3\"><a href=\"/race/" + iduser + "_" + (pageIndex + 1) + ".aspx\">&gt; 更多记录</a></div>";
        if (pageCount <= 1) PageNext = "";

        if (pageCount > 0)
        {
            // 构建页面信息
            StringBuilder sb = new StringBuilder();
            if (items != null && items.Count > 0)
            {
                sb.AppendLine("<style>#tableCreate td {font-size:12px;}</style>");
                sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
                sb.AppendLine("<tr class=\"trTitle\">");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td>道路</td>");
                sb.AppendLine("\t<td>距离</td>");
                sb.AppendLine("\t<td>用时</td>");
                sb.AppendLine("\t<td>速度</td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("</tr>");

                int idx = 1;
                foreach (RaceHistoryInfo item in items)
                {

                    UserInfo ua = Users.Find(item.idUser);
                    if (ua != null)
                    {
                        sb.AppendLine("<tr id=\"trData_" + idx + "\">");
                        sb.AppendLine("\t<td>" + item.dCreate.ToString("yyyy-MM-dd HH:mm") + " <a href=\"" + UrlHelper.MemberUrl(ua.id) + "\">" + ua.cLoginName + "</a></td>");
                        sb.AppendLine("\t<td>" + GCommon.FindValue("idRoadStyle", item.idRoadStyle.ToString()) + "</td>");
                        sb.AppendLine("\t<td>" + item.iDistance.ToString() + " Km</td>");
                        sb.AppendLine("\t<td>" + item.dRunTime.ToString("yyyy-MM-dd HH:mm:ss").Substring(11) + "</td>");
                        sb.AppendLine("\t<td>" + SpeedHelper.Format(float.Parse(item.iDistance.ToString()), item.dRunTime) + "</td>");
                        sb.AppendLine("\t<td>- " + item.cEquipment.ToString() + " " + item.cMemo.ToString() + "</td>");
                        if(m.Default != null && m.Default.id==iduser) {
                            sb.AppendLine("\t<td><a href=\"javascript:\" onclick=\"RcDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\">删除</a></td>");
                        }
                        else
                        {
                            sb.AppendLine("\t<td></td>");
                        }
                        sb.AppendLine("</tr>");
                        idx++;
                    }
                }

                sb.AppendLine("<tr class=\"trTitle\">");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td>道路</td>");
                sb.AppendLine("\t<td>距离</td>");
                sb.AppendLine("\t<td>用时</td>");
                sb.AppendLine("\t<td>速度</td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("</tr>");
                sb.AppendLine("</table>");
            }
            else
            {
                sb.AppendLine("<div style=\"padding:20px;\">没有信息...</div>");
            }

            PageBuffer = sb.ToString();
        }

        PageEcho = "<script language=\"javascript\">document.getElementById('formSpan').innerHTML = '<font style=\"font-size:20px;\">" + onwer.cLoginName + " 训练记录</font><br><br>';</script>";
        if (qry == "focus")
        {
            PageEcho = "<script language=\"javascript\">document.getElementById('formSpan').innerHTML = '<font style=\"font-size:20px;\">我关注博主的训练记录</font><br><br>';</script>";
        }

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA的博客</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA的相册</a></div>";
        if (m.Default != null)
        {
            if (m.Default.id == onwer.id)
            {
                PageGuide = "<div class=\"v2\"><a href=\"?cmd=me\">我的训练</a></div>";
                PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">关注的训练</a></div>";
                //PageEcho = "";
            }
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

