using ERUN360.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
public partial class infocenter_Topics : System.Web.UI.Page
{
    public PageInfos pf = new PageInfos();
    public string PageFace = "";
    public string PageName = "";
    public string PageName1 = "";
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
        Groups groups = new Groups();
        GroupsInfo gk = groups.Find(id);
        if (id != 0)
        {
            PageName = gk.cTitle;
            gk = groups.Find(Int32.Parse(id.ToString().Substring(0, 3) + "100100"));
            PageName1 = gk.cTitle;
        }
        if (!IsPostBack)
        {
            pager.RecordCount = new DB2.tblBLOG_PUBLISH().GetRecordCount("idPosition =" + id);
            pager1.RecordCount = pager.RecordCount;
            int pagesize = pager.PageSize;
            int pageindex = pager.CurrentPageIndex;
            Bind(pageindex, pagesize);
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        pager1.CurrentPageIndex = pageindex;
        Bind(pageindex, pagesize);
    }
    private void Bind(int pageindex, int pagesize)
    {
        BlogPublish publish = new BlogPublish();
        string cacheName = "CACHE_PAGE_TOPICS_" + TopicsIndex;
        if (pageindex == 1)
        {
            PageBuffer = TCache.LoadString(cacheName);
        }

        if (PageBuffer.Length <= 0)
        {
            PageBuffer = publish.Topics_page(TopicsIndex, pagesize, pageindex);
            if (pageindex == 1)
            {
                TCache.SaveString(cacheName, PageBuffer);
            }
        }

    }
    protected void pager1_PageChanged(object sender, EventArgs e)
    {
        int pagesize = pager1.PageSize;
        int pageindex = pager1.CurrentPageIndex;
        pager.CurrentPageIndex = pageindex;
        Bind(pageindex, pagesize);
    }
}