using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_UserSummery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Member m = new Member();

        int id = 0;
        if (Request.QueryString["iduser"] != null)
        {
            id = Int32.Parse(Request.QueryString["iduser"].ToString());
        }
        else
        {
            if (m.Default != null) id = m.Default.id;
        }

        UserInfo u = Users.Find(id);
        if (u != null)
        {
            Response.ContentType = "text/html;charset=GB2312";

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<div id=\"blog_d_top\"></div>");
            sb.AppendLine("<div id=\"blog_d_mid\">");
            sb.AppendLine("<a href=\"" + UrlHelper.MemberUrl(u.id) + "\"><img src=\"" + u.cAvatar + "\" width=\"150\" height=\"150\" style=\"padding:1px;border:solid 3px #FFFBD6;\"></a>");
            sb.AppendLine("<br>");
            sb.AppendLine("<font style=\"font-size:20px;\">" + u.cLoginName + "</font>");

            if (m.Default != null)
            {
                if (m.Default.id != u.id)
                {
                    sb.AppendLine("<div style=\"padding-top:10px;padding-left:20px;margin-bottom:10px;\">");
                    sb.AppendLine("<div id=\"focus\" style=\"float:left;\">");
                    int pageCount = 0;
                    Attention at = new Attention();
                    List<AttentionInfo> alist = at.PageList(1, 10, "WHERE idUser=" + m.Default.id + " AND idInfo=" + u.id, "", out pageCount);
                    if (pageCount > 0)
                    {
                        sb.AppendLine("<div class=\"v2a\" onclick=\"FocusErase(" + u.id + ",'" + XString.MD5(u.id.ToString()) + "')\">- ȡ����ע</div>");
                    }
                    else
                    {
                        sb.AppendLine("<div class=\"v1a\" onclick=\"FocusCreate(" + u.id + ",'" + XString.MD5(u.id.ToString()) + "')\">+ ��ע</div>");
                    }
                    sb.AppendLine("</div>");
                    sb.AppendLine("<div class=\"v2a\" style=\"width:80px;\" onclick=\"PopupShow(480,160,'��TA����','/utility/include/discussUser.aspx?id=" + u.id + "')\">+ ��TA����</div>");
                    sb.AppendLine("</div>");
                }
            }

            sb.AppendLine("<div id=\"blog_d_usr\">");

            sb.AppendLine("<hr noshade size=\"1\" color=\"#C3C7C9\">");

            bool spp = false;
            if (m.Default != null)
            {
                if (m.Default.id == u.id)
                {

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -90px;\">");
                    sb.Append("<a href=\"" + UrlHelper.MemberUrl(u.id) + "\">���ͣ�" + u.iBlogCount + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -35px;\">");
                    sb.Append("<a href=\"/utility/MyFocus.aspx\">��ע��" + u.iFocus + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -0px;\">");
                    sb.Append("<a href=\"/utility/MyFans.aspx\">��˿��" + u.iFans + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -90px;\">");
                    sb.Append("<a href=\"/utility/MyNotes.aspx\">���ԣ�" + u.iNotes + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -17px;\">");
                    sb.Append("<a href=\"/channels/about/\">����" + u.iBlogLevel + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");

                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -72px;\">");
                    sb.Append("<a href=\"/utility/MyHistory.aspx\">���֣�" + u.iScore + "</a>");
                    sb.Append("</div>");
                    sb.AppendLine("</div>");
                    /*
                    sb.Append("<div id=\"blog_d_usr_line\">");
                    sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -35px;\">");
                    sb.Append("���£�" + u.iWorks);
                    sb.Append("</div>");
                    sb.AppendLine("</div>");
                    */
                    spp = true;
                }
            }
            if (!spp)
            {

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -90px;\">");
                sb.Append("���ͣ�" + u.iBlogCount + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -35px;\">");
                sb.Append("��ע��" + u.iFocus + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -0px;\">");
                sb.Append("��˿��" + u.iFans + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -90px;\">");
                sb.Append("���ԣ�" + u.iNotes + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -17px;\">");
                sb.Append("����" + u.iBlogLevel + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");

                sb.Append("<div id=\"blog_d_usr_line\">");
                sb.Append("<div id=\"blog_d_usr_item\" style=\"background-position:-0px -72px;\">");
                sb.Append("���֣�" + u.iScore + "");
                sb.Append("</div>");
                sb.AppendLine("</div>");
            }

            sb.AppendLine("<hr noshade size=\"1\" color=\"#C3C7C9\">");

            spp = false;
            if (m.Default != null)
            {
                if (m.Default.id == u.id)
                {
                    sb.AppendLine("<div style=\"line-height:20px;\">");
                    //sb.AppendLine("+ <a href=\"" + UrlHelper.MemberUrl(u.id) + "\">�ҵ���ҳ</a><br>");
                    //sb.AppendLine("+ <a href=\"/utility/member.aspx\">�ҵĲ���</a><br>");
                    //sb.AppendLine("+ <a href=\"" + UrlHelper.GalleryUrl(u.id) + "\">�ҵ����</a><br>");
                    sb.AppendLine("+ <a href=\"/utility/write.aspx\">������</a><br>");
                    sb.AppendLine("+ <a href=\"/utility/write.aspx?cmd=race\">��Լ��</a><br>");
                    sb.AppendLine("+ <a href=\"/utility/write.aspx?cmd=equipment\">��װ��</a><br>");
                    //sb.AppendLine("+ <a href=\"/utility/focus.aspx\">�ҵķ�˿</a><br>");
                    sb.AppendLine("+ <a href=\"/race/" + u.id + ".aspx\">��ѵ���ɼ�</a><br>");
                    sb.AppendLine("+ <a href=\"/member/success.aspx\">�˻�����</a><br>");
                    sb.AppendLine("</div>");
                    spp = true;
                }
            }

            if (!spp)
            {
                sb.AppendLine("<div style=\"line-height:20px;\">");
                sb.AppendLine("+ <a href=\"/member/show.aspx?id=" + id + "\">Ta����ϸ��Ϣ</a><br>");
                sb.AppendLine("+ <a href=\"" + UrlHelper.MemberUrl(id) + "\">TA�Ĳ������</a><br>");
                sb.AppendLine("+ <a href=\"/utility/myrace.aspx?id=" + id + "\">TA��Լ��</a><br>");
                sb.AppendLine("+ <a href=\"/utility/myequipments.aspx?id=" + id + "\">TA��װ��</a><br>");
                sb.AppendLine("+ <a href=\"/race/" + u.id + ".aspx\">TA��ѵ���ɼ�</a><br>");
                sb.AppendLine("</div>");
            }

            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_d_clear\"></div>");
            sb.AppendLine("</div>");
            sb.AppendLine("<div id=\"blog_d_bot\"></div>");

            Response.Write(sb.ToString());
        }
        else
        {
            Response.Write("Loading...");
        }
    }
}
