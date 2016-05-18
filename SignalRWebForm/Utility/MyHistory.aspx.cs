using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyHistory : System.Web.UI.Page
{
    public MemberInfo u;
    public string PageGuide = "";
    public string PageBuffer = "";
    public string PageUser = "";
    public string PageResult = "";
    public string PageNavigator = "";

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

        // ��ȡҳ�ţ�Ĭ��Ϊ1
        int tabIndex = u.id % 10;

        // ��ȡҳ�ţ�Ĭ��Ϊ1
        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
        }
        if (pageIndex < 1)
        {
            PageResult = "ҳ�Ŵ���";
            return;
        }

        // ÿҳ��¼��(Ĭ��30)
        int pageSize = 30;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        MemberHistory table = new MemberHistory();
        List<MemberHistoryInfo> items = new List<MemberHistoryInfo>();
        items = table.PageList(tabIndex, pageIndex, pageSize, "WHERE idUser=" + u.id, "ORDER BY id DESC", out pageCount);

        Groups group = new Groups();

        // ����ҳ����Ϣ
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>ʱ��</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td align=right>����</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (MemberHistoryInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\">");
                sb.AppendLine("\t<td style=\"font-size:12px;color:#666666;\">" + item.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</td>");
                sb.AppendLine("\t<td>" + item.idGroup.ToString() + " : " + group.FindTitle(item.idGroup) + "</td>");
                sb.AppendLine("\t<td align=right>" + item.iScore.ToString() + "&nbsp;</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>ʱ��</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td align=right>����</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }

        PageBuffer = sb.ToString();

        // ��ҳ�ؼ�
        PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "MemberHistoryList.aspx?page={0}&table=" + tabIndex + "");

        #region ������Ϣ
        //PageGuide = "<div class=\"v2\"><a href=\"" + UrlHelper.MemberUrl(m.Default.id) + "\">��ҳ</a></div>";
        PageGuide = "<div class=\"v2\"><a href=\"/utility/member.aspx\">�ҵĲ���</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"" + UrlHelper.GalleryUrl(m.Default.id) + "\">�ҵ����</a></div>";
        PageGuide += "<div class=\"v2\"><a href=\"/utility/write.aspx\">������</a></div>";
        //PageGuide += "<div class=\"v2\"><a href=\"/member/\">������Ϣ</a></div>";
        #endregion

    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

