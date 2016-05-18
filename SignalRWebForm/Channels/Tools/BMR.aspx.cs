using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Channels_Tools_BMR : System.Web.UI.Page
{
    public string PageWeight = "";
    public string PageHeight = "";
    public string PageAge = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();
        if (m.Default != null)
        {
            MemberInfo me = m.Load(m.Default.id, "", "");

            // 110108196605072234
            if (me.cNationID.Length == 18)
            {
                int a1 = DateTime.Now.Year;
                int a2 = Int32.Parse("0" + XString.PureNumber(me.cNationID.Substring(6, 4)));
                int age = a1 - a2;
                if (age > 0 && age < 100)
                {
                    PageAge = age.ToString();
                }
            }

            // 1101086605072234
            if (me.cNationID.Length == 15)
            {
                int a1 = DateTime.Now.Year;
                int a2 = Int32.Parse("19" + XString.PureNumber(me.cNationID.Substring(6, 2)));
                int age = a1 - a2;
                if (age > 0 && age < 100)
                {
                    PageAge = age.ToString();
                }
            }

            MemberSize ms = new MemberSize();
            MemberSizeInfo sz = ms.Load(m.Default.id, "", "");
            if (sz != null)
            {
                if (sz.iBodyWeight > 0) PageWeight = sz.iBodyWeight.ToString();
                if (sz.iBodyHeight > 0) PageHeight = sz.iBodyHeight.ToString();
            }
        }
    }
}
