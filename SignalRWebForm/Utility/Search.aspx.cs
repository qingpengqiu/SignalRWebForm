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

public partial class _Utility_Search : System.Web.UI.Page
{
    public string PageWord = "最新博文";
    public string PageFace = "";
    public string PageBuffer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region 用户信息与标题部分

        // 浏览者
        int idbrowse = 0;
        Member m = new Member();
        if (m.Default != null)
        {
            idbrowse = m.Default.id;
        }

        #endregion

        #region 博客底图相关
        PageFace = GCommon.FacePanel(idbrowse, (m.Default != null) ? m.Default.id : 0);
        #endregion

        #region 创建显示内容

        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(Request.QueryString["page"].ToString());
            if (pageIndex < 1 || pageIndex > 20) pageIndex = 1;
        }

        int pageSize = 30;
        string word = "";
        if (Request["word"] != null)
        {
            word = Request["word"].ToString();
            if(word!=".") PageWord = "博客搜索(" + word + ")";
            else PageWord = "博文排行";
        }

        string fname = "";
        if (Request["fname"] != null)
        {
            fname = Request["fname"].ToString().ToLower();
            if(fname == "video") { PageWord = "益跑视频"; word = "flash"; }
            if(fname == "image") { PageWord = "益跑图片"; word = "img"; }
        }

        Blog blogs = new Blog();
        PageBuffer = blogs.NewestBlog(pageIndex, pageSize, fname, word) + "<br>"; // + blogs._sql;

        #endregion
    }
}
