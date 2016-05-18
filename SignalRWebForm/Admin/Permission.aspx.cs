using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Permission : System.Web.UI.Page
{

    // ҳ����Ϣ
    public string PageResult = "";
    public string PageBuffer = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsSuper())
        {
            //PageResult = "û�в���Ȩ�ޣ�";
            Response.Redirect("/admin/");
            return;
        }

        if (Request.Form.Count > 0)
        {
            int idUser = 0;
            if (Request.Form["idUser"] != null)
            {
                idUser = Int32.Parse(Request.Form["idUser"].ToString());
            }
            int idAdminStyle = 0;
            if (Request.Form["idAdminStyle"] != null)
            {
                idAdminStyle = Int32.Parse(Request.Form["idAdminStyle"].ToString());
            }
            string cLoginName = "";
            if (Request.Form["cLoginName"] != null)
            {
                cLoginName = XString.SqlSafe(Request.Form["cLoginName"].ToString());
            }

            if (idUser > 0 && idAdminStyle > 0 && cLoginName.Length > 1 && cLoginName.Length < 32)
            {
                Member m = new Member();
                MemberInfo u = m.Load(idUser, "", "");
                if (u.cLoginName.ToLower() == cLoginName.ToLower())
                {
                    m.UpdateByCommand(idUser, "idMemberStyle=" + idAdminStyle);
                    PageResult = "��Ȩ�ɹ�";
                }
                else
                {
                    PageResult = "�û�ID���¼������1";
                }
            }
            else
            {
                PageResult = "�û�ID���¼������2";
            }
        }

        // �ջ���Ȩ
        if (Request.QueryString["opr"] != null)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Int32.Parse(Request.QueryString["id"].ToString());
                Member m1 = new Member();
                m1.UpdateByCommand(id, "idMemberStyle=0");
            }
        }

        // ��ȡҳ�ţ�Ĭ��Ϊ1
        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
        }
        if (pageIndex < 1)
        {
            PageBuffer = "ҳ�Ŵ���";
            return;
        }
        // ÿҳ��¼��(Ĭ��30)
        int pageSize = 30;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        Member table = new Member();
        List<MemberInfo> items = table.PageList(pageIndex, pageSize, "WHERE idMemberStyle>0", "ORDER BY id DESC", out pageCount);

        // ����ҳ����Ϣ
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>��Ա����</td>");
            sb.AppendLine("\t<td nowrap>��¼��</td>");
            //sb.AppendLine("\t<td nowrap>�Ա�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            //sb.AppendLine("\t<td nowrap>֤������ ");
            //sb.AppendLine("\t ֤������</td>");
            sb.AppendLine("\t<td nowrap>�ֻ�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (MemberInfo item in items)
            {
                if (item.idMemberStyle == 99) continue;

                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td nowrap>" + item.id.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.idMemberStyle.ToString() + ":" + GCommon.FindValue("idAdminStyle", item.idMemberStyle.ToString()) + " <a href=\"?opr=back&id=" + item.id.ToString() + "\">�ջ�</a></td>");
                sb.AppendLine("\t<td nowrap>" + item.cLoginName.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + GCommon.FindValue("idGender", item.idGender.ToString()) + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.cName.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + GCommon.FindValue("idNationIdType", item.idNationIdType.ToString()) + " ");
                //sb.AppendLine("\t" + item.cNationID.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.cMobile.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.cMail.ToString() + "</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>��Ա����</td>");
            sb.AppendLine("\t<td nowrap>��¼��</td>");
            //sb.AppendLine("\t<td nowrap>�Ա�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            //sb.AppendLine("\t<td nowrap>֤������ ");
            //sb.AppendLine("\t ֤������</td>");
            sb.AppendLine("\t<td nowrap>�ֻ�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }

        PageBuffer = sb.ToString();

        // ��ҳ�ؼ�
        PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "Permission.aspx?page={0}");
    }
}
/* Powered by ������������������޹�˾ Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:39 */

