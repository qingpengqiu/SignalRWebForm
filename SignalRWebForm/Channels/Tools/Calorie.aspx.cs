using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Channels_Tools_Calorie : System.Web.UI.Page
{
    public string PageWeight = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        if (m.Default != null)
        {
            MemberSize ms = new MemberSize();
            MemberSizeInfo sz = ms.Load(m.Default.id, "", "");
            if (sz != null)
            {
                if (sz.iBodyWeight > 0) PageWeight = sz.iBodyWeight.ToString();
                //if (sz.iBodyHeight > 0) PageHeight = sz.iBodyHeight.ToString();
            }
        }
    }
}
