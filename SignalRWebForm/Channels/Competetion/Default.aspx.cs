using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Channels_Competetion_Default : System.Web.UI.Page
{
    public PageInfos pf = new PageInfos();
    public string DateBuffer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Member u = new Member();
        int iduser = 0;
        if (u.Default != null) iduser = u.Default.id;

        int y = DateTime.Now.Year;
        if (Request.QueryString["year"] != null)
        {
            y = Int32.Parse(Request.QueryString["year"].ToString());
        }
        int m = DateTime.Now.Month;
        if (Request.QueryString["month"] != null)
        {
            m = Int32.Parse(Request.QueryString["month"].ToString());
        }
        int d = 0;
        if (Request.QueryString["day"] != null)
        {
            d = Int32.Parse(Request.QueryString["day"].ToString());
        }

        DateBuffer = ""; //TCache.LoadString("CACHE_COMPETETION" + String.Format("{0:D4}{1:D2}", y, m));
        if (DateBuffer.Length == 0)
        {
            //RaceCompetetion rc = new RaceCompetetion();
            CompetetionCalendar rc = new CompetetionCalendar();
            DateBuffer = rc.XCalendar(y, m, d, iduser);
            //TCache.SaveString("CACHE_COMPETETION" + String.Format("{0:D4}{1:D2}", y, m), DateBuffer);
        }
    }
}
