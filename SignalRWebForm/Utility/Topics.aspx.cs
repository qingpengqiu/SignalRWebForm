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

public partial class _Utility_Topics : System.Web.UI.Page
{
    public string PageFace = "";
    public string PageName = "";
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageBrowser = "0";
    public int TopicsIndex = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        if (m.Default != null)
        {
            PageBrowser = m.Default.id.ToString();
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
            if (id < 0) id = 0;
            TopicsIndex = id;
        }

        if (m.Default != null)
        {
            //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">��ҳ</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">�ҵĲ���</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">�ҵ����</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">������</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/member/\">�ҵ���Ϣ</a></div>";
        }
        else
        {
            PageGuide = "<div class=\"v2\"><a href=\"/member/\">ע��</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/member/login.aspx\">��¼</a></div>";
        }

        Groups groups = new Groups();
        GroupsInfo gk = groups.Find(id);
        PageName = gk.cTitle;

        gk = groups.Find(Int32.Parse(id.ToString().Substring(0, 3) + "100100"));
        PageName = gk.cTitle + " - " + PageName;

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 100) pageIndex = 1;
        }

        int pageSize = 15;
        int pageCount = 0;

        #region �������
        string cacheName = "CACHE_PAGE_TOPICS_" + id;
        if (pageIndex == 1)
        {
            PageBuffer = TCache.LoadString(cacheName);
        }
        #endregion

        if (PageBuffer.Length < 1)
        {
            BlogPublish publish = new BlogPublish();
            PageBuffer = publish.Topics(id, pageSize, ref pageIndex, ref pageCount);
        }

        if (pageIndex == 1)
        {
            TCache.SaveString(cacheName, PageBuffer);
        }
    }
}
