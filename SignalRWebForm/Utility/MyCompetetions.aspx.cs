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

public partial class _Utility_MyCompetetions : System.Web.UI.Page
{
    public MemberInfo u;
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        u = m.Default;
        if (u == null)
        {
            Response.Redirect("/member/");
        }
        #endregion

        #region ������
        UserInfo onwer = Users.Find(u.id);
        if (onwer == null) onwer = new UserInfo();
        if (onwer.cBio.Length < 1)
        {
            PageUser = "<a href=\"/member/personal.aspx\" style=\"color:#000000;\">��д���...</a>";
        }
        else
        {
            PageUser = onwer.cBio;
        }
        #endregion

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 15;
        int pageCount = 0;

        Blog blogs = new Blog();
        string qry = "all";
        if(Request.QueryString["cmd"]!=null)
        {
            qry = Request.QueryString["cmd"].ToString().ToLower();
        }
        PageBuffer = blogs.UsersAttentions("Competetions", qry, u.id, u.id, pageSize, ref pageIndex, ref pageCount);

        if (PageBuffer.Length < 1)
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<div id=\"blog_m_top\"></div>");
            sb.AppendLine("<div id=\"blog_m_mid\">");
            sb.AppendLine("û���ҵ����ʵľ�����Ϣ��<br>");
            sb.AppendLine("<br>");
            sb.AppendLine("ͨ��[��ע]�������ѿɸ�����ػ�ȡ������Ϣ��<br>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_m_bot\"></div>");
            sb.AppendLine("<div id=\"blog_m_spc\"></div>");
            PageBuffer = sb.ToString();
        }

        #region ������Ϣ
        PageGuide = "<div class=\"v2\"><a href=\"?cmd=all\">ȫ������</a></div>"; 
        PageGuide += "<div class=\"v2\"><a href=\"?cmd=join\">�Ҳμӵ�����</a></div>"; 
        PageGuide += "<div class=\"v2\"><a href=\"?cmd=focus\">�ҹ�ע������</a></div>";
        #endregion
    }
}
