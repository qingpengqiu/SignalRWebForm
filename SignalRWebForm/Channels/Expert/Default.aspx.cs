using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Channels_Expert_Default : System.Web.UI.Page
{
    public PageInfos pf = new PageInfos();
    public string PageBuffer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Blog blog = new Blog();
        BlogInfo bs = blog.Load(200001035, "", "");
        PageBuffer = bs.cContent.Replace("&lt;", "<").Replace("&gt;", ">");
        if(PageBuffer.Length < 1)
        {
            PageBuffer = pf.Focus(321100100, 27);
        }
    }
}
