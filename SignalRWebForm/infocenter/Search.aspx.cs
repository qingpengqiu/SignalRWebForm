using ERUN360.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
public partial class infocenter_Search : System.Web.UI.Page
{
    public string PageWord = "最新博文";
    public string PageBuffer = "";
    public int num = 0;
    string word = "";
    string fname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        #region 创建显示内容
        if (Request["word"] != null)
        {
            word = Request["word"].ToString();
            if (word != "."&&word.Trim().Length>0) 
                PageWord = word;
            else PageWord = "博文排行";
        }
        StringBuilder sql = new StringBuilder();
        if (word.Length > 0)
        {

            if (fname == "loginname") { sql.Remove(0, sql.Length); sql.Append(" cLoginName LIKE '%" + word + "%'"); }
            if (fname == "title") { sql.Remove(0, sql.Length); sql.Append(" cTitle LIKE '%" + word + "%'"); }
            if (fname == "content") { sql.Remove(0, sql.Length); sql.Append(" cContent LIKE '%" + word + "%'"); }
            if (fname == "video") { sql.Remove(0, sql.Length); sql.Append(" cContent LIKE '%/[FLASH/]%' ESCAPE '/'"); }
            if (fname == "image") { sql.Remove(0, sql.Length); sql.Append(" cContent LIKE '%/[IMG/]%' ESCAPE '/'"); }
        }
        if (Request["fname"] != null)
        {
            fname = Request["fname"].ToString().ToLower();
            if (fname == "video") { PageWord = "益跑视频"; word = "flash"; }
            if (fname == "image") { PageWord = "益跑图片"; word = "img"; }
            //if (fname == "loginname") {  }
            //if (fname == "title") { }
            //if (fname == "content") { }
        }


        if (!IsPostBack)
        {
            int pagesize = pager.PageSize;
            int pageindex = pager.CurrentPageIndex;
            Bind(pageindex, pagesize);
            if (num / pagesize > 200)
            {
                num = 200 * pagesize;
            }

            pager.RecordCount = num; //new DB2.tblBLOG().GetRecordCount(sql.ToString());//SELECT COUNT(*) FROM [YP_DB_2].[dbo].[tblBLOG] WHERE cContent LIKE '%赛事%'
            pager1.RecordCount = pager.RecordCount;

        }
        #endregion
    }
    private void Bind(int pageindex, int pagesize)
    {
        Blog blogs = new Blog();
        PageBuffer = blogs.NewestBlog_page(pageindex, pagesize, fname, word, out num) + "<br>"; // + blogs._sql;
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        pager1.CurrentPageIndex = pageindex;
        Bind(pageindex, pagesize);
    }
    protected void pager1_PageChanged(object sender, EventArgs e)
    {
        int pagesize = pager1.PageSize;
        int pageindex = pager1.CurrentPageIndex;
        pager.CurrentPageIndex = pageindex;
        Bind(pageindex, pagesize);
    }
}