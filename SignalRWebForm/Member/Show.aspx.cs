using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Member_Show : System.Web.UI.Page
{
    public UserInfo onwer;
    public MemberInfo record = new MemberInfo();
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

        PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(onwer.id) + "\">TA�Ĳ���</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(onwer.id) + "\">TA�����</a></div>";
        if (idbrowse == onwer.id)
        {
            //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">��ҳ</a></div>";
            PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">�ҵĲ���</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">�ҵ����</a></div>";
            PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">������</a></div>";
            //PageGuide += "<div class=\"v2\"><a href=\"/member/\">������Ϣ</a></div>";
        }

        // ��ȡ����
        Member table = new Member();
        if (Request["id"] != null)
        {
            int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            record = table.Load(recordIndex, "", "");
            if (record == null)
            {
                PageResult = "���ݴ���(Index error)��";
                return;
            }
        }
        else
        {
            PageResult = "���ݴ���(Querystring is null)��";
            return;
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */
