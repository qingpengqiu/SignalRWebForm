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
        #region ���ȷ��
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
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">��д���...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }

        #region ���͵�ͼ���
        PageFace = GCommon.FacePanel(onwer.id, (m.Default != null) ? m.Default.id : 0);
        #endregion

        RaceHistory table = new RaceHistory();

        // �������ݲ��������棩
        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
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
                    PageResult = "���ڸ�ʽ����[" + ex.Message + "]�����飡";
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
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
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
                    PageResult = "����(ʱ��)��ʽ����[" + ex.Message + "]�����飡";
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
                    PageResult = "����(װ������)��ʽ����[" + ex.Message + "]�����飡";
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
                    PageResult = "����(�ĵ�)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount > 0 && PageResult.Length == 0)
            {
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    #region ����:����ѵ����¼
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

        PageNext = "<div class=\"v3\"><a href=\"/race/" + iduser + "_" + (pageIndex + 1) + ".aspx\">&gt; �����¼</a></div>";
        if (pageCount <= 1) PageNext = "";

        if (pageCount > 0)
        {
            // ����ҳ����Ϣ
            StringBuilder sb = new StringBuilder();
            if (items != null && items.Count > 0)
            {
                sb.AppendLine("<style>#tableCreate td {font-size:12px;}</style>");
                sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
                sb.AppendLine("<tr class=\"trTitle\">");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td>��·</td>");
                sb.AppendLine("\t<td>����</td>");
                sb.AppendLine("\t<td>��ʱ</td>");
                sb.AppendLine("\t<td>�ٶ�</td>");
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
                            sb.AppendLine("\t<td><a href=\"javascript:\" onclick=\"RcDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\">ɾ��</a></td>");
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
                sb.AppendLine("\t<td>��·</td>");
                sb.AppendLine("\t<td>����</td>");
                sb.AppendLine("\t<td>��ʱ</td>");
                sb.AppendLine("\t<td>�ٶ�</td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("\t<td></td>");
                sb.AppendLine("</tr>");
                sb.AppendLine("</table>");
            }
            else
            {
                sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
            }

            PageBuffer = sb.ToString();
        }

        PageEcho = "<script language=\"javascript\">document.getElementById('formSpan').innerHTML = '<font style=\"font-size:20px;\">" + onwer.cLoginName + " ѵ����¼</font><br><br>';</script>";
        if (qry == "focus")
        {
            PageEcho = "<script language=\"javascript\">document.getElementById('formSpan').innerHTML = '<font style=\"font-size:20px;\">�ҹ�ע������ѵ����¼</font><br><br>';</script>";
        }

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA�Ĳ���</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA�����</a></div>";
        if (m.Default != null)
        {
            if (m.Default.id == onwer.id)
            {
                PageGuide = "<div class=\"v2\"><a href=\"?cmd=me\">�ҵ�ѵ��</a></div>";
                PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">��ע��ѵ��</a></div>";
                //PageEcho = "";
            }
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

