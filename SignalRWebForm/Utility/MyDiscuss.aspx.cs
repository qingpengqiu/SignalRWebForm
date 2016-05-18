using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyDiscuss : System.Web.UI.Page
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

        int pageCount = 0;
        Discuss diz = new Discuss();
        PageBuffer = diz.MyDiscuss(m.Default.id);

        #region ������Ϣ
        //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">��ҳ</a></div>";
        //PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">�ҵĲ���</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">�ҵ����</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">������</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"/member/\">������Ϣ</a></div>";
        #endregion

    }
}

