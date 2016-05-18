using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_MyAttentions : System.Web.UI.Page
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
        Attention att = new Attention();

        string title = "�ҹ�ע�Ĳ���";
        string sql = "WHERE idUser=" + u.id;

        List<AttentionInfo> items = att.PageList(1, 1000, sql, "ORDER BY id DESC", out pageCount);

        StringBuilder sb = new StringBuilder();
        if (pageCount > 0)
        {

            #region ������ע����ID�б�
            Hashtable hash = new Hashtable();
            StringBuilder sx = new StringBuilder();
            foreach (AttentionInfo av in items)
            {
                if (av.idInfo > 200000000)
                {
                    sx.Append(av.idInfo + ",");
                }
            }
            if (sx.ToString().Length > 0)
            {
                Blog blog = new Blog();
                List<BlogInfo> blist = blog.PageList(1, 1000, "WHERE id IN(" + XString.UnTail(sx.ToString()) + ")", "ORDER BY id DESC", out pageCount);
                if (pageCount > 0)
                {
                    foreach (BlogInfo bu in blist)
                    {
                        if (hash[bu.id] == null)
                        {
                            hash.Add(bu.id, bu);
                        }
                    }
                }
            }
            #endregion

            sb.AppendLine("<table id=\"tableList\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td></td>");
            sb.AppendLine("\t<td>" + title + "</td>");
            sb.AppendLine("\t<td>ʱ��</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (AttentionInfo item in items)
            {
                if (item.idInfo < 200000000) continue;

                sb.AppendLine("<tr id=\"trData_" + idx + "\">");
                sb.AppendLine("\t<td style=\"width:50px;text-align:center;\">" + idx + "</td>");

                if (hash[item.idInfo] != null)
                {
                    BlogInfo bv = (BlogInfo)hash[item.idInfo];
                    sb.AppendLine("\t<td><b><a href=\"" + UrlHelper.MemberUrl(bv.idUser) + "\">" + bv.cLoginName + "</a></b><br><a href=\"/blod/" + bv.id + ".aspx\">" + bv.cTitle + "</a></td>");
                }
                else
                {
                    sb.AppendLine("\t<td>-</td>");
                }

                sb.AppendLine("\t<td nowrap style=\"font-size:12px;color:#666666;width:90px;text-align:center;\">" + item.dCreate.ToString("yyyy-MM-dd HH:mm") + "</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td></td>");
            sb.AppendLine("\t<td>" + title + "</td>");
            sb.AppendLine("\t<td>ʱ��</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }
        PageBuffer = sb.ToString();

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

