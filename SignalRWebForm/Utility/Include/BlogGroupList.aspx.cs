using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Include_BlogGroupList : System.Web.UI.Page
{
    // ҳ����Ϣ
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            PageBuffer = "û�в���Ȩ�ޣ�";
            return;
        }
        #endregion

        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            BlogGroupInfo record = new BlogGroupInfo();
            record.idUser = u.id;
            int finishedFieldCount = 0;
            if (Request.Form["cTitle"] != null)
            {
                try
                {
                    record.cTitle = XString.SqlSafe(Request.Form["cTitle"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(����)��";
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 1 && PageBuffer.Length == 0)
            {
                BlogGroup bg = new BlogGroup();
                int recordIndex = 0;
                if (bg.Insert(record, out recordIndex))
                {
                    ;
                }
                else
                {
                    ;
                }
            }
        }

        int pageIndex = 1;
        // ÿҳ��¼��(Ĭ��30)
        int pageSize = 30;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        BlogGroup table = new BlogGroup();
        List<BlogGroupInfo> items = table.PageList(pageIndex, pageSize, "WHERE idUser=" + u.id, "ORDER BY id DESC", out pageCount);

        // ����ҳ����Ϣ
        StringBuilder sb = new StringBuilder();
        if (pageCount > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>���</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td>����</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (BlogGroupInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\">");
                //sb.AppendLine("\t<td>" + item.id.ToString() + "</td>");
                sb.AppendLine("\t<td>" + idx + "</td>");
                sb.AppendLine("\t<td>" + item.cTitle.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.iNumber.ToString() + "</td>");
                sb.AppendLine("\t<td>");
                if (item.iNumber < 1)
                {
                    sb.AppendLine("<div id=\"span_delete\" onclick=\"ItemDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\"></div>");
                }
                sb.AppendLine("</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td>���</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td>��������</td>");
            sb.AppendLine("\t<td>����</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }

        PageResult = sb.ToString();
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

