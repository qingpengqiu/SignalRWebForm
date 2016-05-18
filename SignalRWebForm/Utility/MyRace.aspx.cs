using System;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyRace : System.Web.UI.Page
{
    public UserInfo onwer;
    public string PageFace = "";
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        // �����
        int idbrowse = 0;
        Member m = new Member();
        if (m.Default != null)
        {
            idbrowse = m.Default.id;
        }

        // ����
        int iduser = 0;
        if (Request.QueryString["id"] != null)
        {
            iduser = Int32.Parse(Request.QueryString["id"].ToString());
            if (iduser < 0) iduser = 0;
        }
        else
        {
            if (m.Default != null)
            {
                iduser = m.Default.id;
            }
        }

        if(iduser <= 0)
        {
            Response.Redirect("/Member/");
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

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        #region ���͵�ͼ���
        PageFace = GCommon.FacePanel(onwer.id, (m.Default != null) ? m.Default.id : 0);
        #endregion

        int pageSize = 15;
        int pageCount = 0;

        string qry = "all";
        if(Request.QueryString["cmd"]!=null)
        {
            qry = Request.QueryString["cmd"].ToString().ToLower();
        }

        if (Request.Form.Count > 0)
        {
            if (Request.Form["idCity"] != null && Request.Form["idRoadStyle"] != null)
            {
                qry = "(idRoadStyle=" + Int32.Parse(Request.Form["idRoadStyle"].ToString()) + ") AND ";
                qry += "(idCity=" + Int32.Parse(Request.Form["idCity"].ToString()) + ") AND ";
                qry += "(dOpen BETWEEN '" + Request.Form["date1"].ToString() + " 00:00:00' AND '" + Request.Form["date2"].ToString() + " 23:59:59')";
            }
            if (Request.Form["idCity"] != null && Request.Form["rtime"] != null)
            {
                qry = "(idCity=" + Int32.Parse(Request.Form["idCity"].ToString()) + ") AND ";
                string dstyle = Request.Form["rtime"].ToString();
                if (dstyle == "day")
                {
                    qry += "(dOpen BETWEEN '" + DateTime.Now.ToString("yyyy-MM-dd") + " 00:00:00' AND '" + DateTime.Now.ToString("yyyy-MM-dd") + " 23:59:59')";
                }
                if (dstyle == "week1")
                {
                    int dw1 = (int)DateTime.Now.DayOfWeek;
                    if (dw1 == 0) dw1 = 7;
                    DateTime d1 = DateTime.Now.AddDays(0 - dw1);
                    DateTime d2 = d1.AddDays(7);
                    qry += "(dOpen BETWEEN '" + d1.ToString("yyyy-MM-dd") + " 59:59:59' AND '" + d2.ToString("yyyy-MM-dd") + " 00:00:00')";
                }
                if (dstyle == "week2")
                {
                    int dw2 = (int)DateTime.Now.DayOfWeek;
                    if (dw2 == 0) dw2 = 7;
                    DateTime d1 = DateTime.Now.AddDays(0 - dw2).AddDays(7);
                    DateTime d2 = d1.AddDays(7);
                    qry += "(dOpen BETWEEN '" + d1.ToString("yyyy-MM-dd") + " 59:59:59' AND '" + d2.ToString("yyyy-MM-dd") + " 00:00:00')";
                }
            }
        }

        Blog blogs = new Blog();
        PageBuffer = blogs.UsersAttentions("Race", qry, onwer.id, idbrowse, pageSize, ref pageIndex, ref pageCount);

        if (PageBuffer.Length < 1)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div id=\"blog_m_top\"></div>");
            sb.AppendLine("<div id=\"blog_m_mid\">");
            sb.AppendLine("û���ҵ����ʵ�Լ����Ϣ��<br>");
            sb.AppendLine("<br>");
            sb.AppendLine("ͨ��[��ע]�������ѿɸ�����ز���Լ�ܻ��<br>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_m_bot\"></div>");
            sb.AppendLine("<div id=\"blog_m_spc\"></div>");
            PageBuffer = sb.ToString();
        }

        #region ������Ϣ
        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA�Ĳ���</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA�����</a></div>";
        if (idbrowse == onwer.id)
        {
            PageGuide = "<div class=\"v2\"><a href=\"?cmd=all\">ȫ��Լ��</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"?cmd=me\">�ҷ����</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"?cmd=join\">�Ҳμӵ�</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">�ҹ�ע��</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx?cmd=race\">��Լ��</a></div>";
        }
        #endregion
    }
}
