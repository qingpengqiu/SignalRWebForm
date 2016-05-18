using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Member_List : System.Web.UI.Page
{
    // ҳ����Ϣ
    public string PageBuffer = "";
    public string PageResult = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            PageBuffer = "û�в���Ȩ�ޣ�";
            return;
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

        // ���ֶ�������
        string searchField = "";
        if (Request["searchField"] != null)
        {
            searchField = XString.SqlSafe(Request["searchField"].ToString());
        }
        string searchValue1 = "";
        if (Request["searchValue1"] != null)
        {
            searchValue1 = XString.SqlSafe(Request["searchValue1"].ToString());
        }
        string searchValue2 = "";
        if (Request["searchValue2"] != null)
        {
            searchValue2 = XString.SqlSafe(Request["searchValue2"].ToString());
        }
        if (searchField.StartsWith("datetime:"))
        {
            if (Request["searchDate1"] != null)
            {
                searchValue1 = XString.SqlSafe(Request["searchDate1"].ToString()) + " 00:00:00";
            }
            if (Request["searchDate2"] != null)
            {
                searchValue2 = XString.SqlSafe(Request["searchDate2"].ToString()) + " 23:59:59";
            }
        }

        // ÿҳ��¼��(Ĭ��30)
        int pageSize = 30;
        // ��ҳ��
        int pageCount = 0;

        // ��ѯ��¼����ҳ��
        Member table = new Member();
        List<MemberInfo> items = new List<MemberInfo>();
        if (searchField.Length > 0)
        {
            pageIndex = 1;
            string[] fa = searchField.Split(':');
            string qry = "";
            if (fa[0].Contains("int") || fa[0].Contains("float")) qry = "WHERE (" + fa[1] + " BETWEEN " + searchValue1 + " AND " + searchValue2 + ")";
            if (fa[0].Contains("datetime")) qry = "WHERE (" + fa[1] + " BETWEEN '" + searchValue1 + "' AND '" + searchValue2 + "')";
            if (fa[0].Contains("char") || fa[0].Contains("text")) qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue2 + "%')";

            //if (fa[0].Contains("char")) qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue1 + "%')";
            //if (fa[0].Contains("varchar")) qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue2 + "%')";
            items = table.PageList(pageIndex, pageSize, qry, "ORDER BY id DESC", out pageCount);
        }
        else
        {
            items = table.PageList(pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount);
        }

        // ����ҳ����Ϣ
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            //sb.AppendLine("\t<td nowrap>��Ա����</td>");
            sb.AppendLine("\t<td nowrap>��¼��</td>");
            sb.AppendLine("\t<td nowrap>�Ա�</td>");
            //sb.AppendLine("\t<td nowrap>��������</td>");
            //sb.AppendLine("\t<td nowrap>ͷ��URL</td>");
            //sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("\t<td nowrap>֤������ ");
            sb.AppendLine("\t ֤������</td>");
            sb.AppendLine("\t<td nowrap>�ֻ�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("\t<td nowrap>�ʱ�</td>");
            sb.AppendLine("\t<td nowrap>��ַ</td>");
            //sb.AppendLine("\t<td nowrap>���б���</td>");
            sb.AppendLine("\t<td nowrap>���ڳ���</td>");
            sb.AppendLine("\t<td nowrap>Ѫ��</td>");
            //sb.AppendLine("\t<td nowrap>ְҵ</td>");
            //sb.AppendLine("\t<td nowrap>���ѧ��</td>");
            //sb.AppendLine("\t<td nowrap>��Ȥ����</td>");
            sb.AppendLine("\t<td nowrap>������ϵ��ʽ</td>");
            //sb.AppendLine("\t<td nowrap>��������</td>");
            //sb.AppendLine("\t<td nowrap>����ʱ��</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (MemberInfo item in items)
            {
                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td><span class=\"span_href\" onclick=\"ItemShow(" + item.id + ")\">" + item.id.ToString() + "</span></td>");
                //sb.AppendLine("\t<td>" + item.idMemberStyle.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cLoginName.ToString() + "</td>");
                sb.AppendLine("\t<td>" + GCommon.FindValue("idGender", item.idGender.ToString()) + "</td>");
                //sb.AppendLine("\t<td>" + item.dBirthday.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.cAvatar.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.cBio.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cName.ToString() + "</td>");
                sb.AppendLine("\t<td>" + GCommon.FindValue("idNationIdType", item.idNationIdType.ToString()) + " ");
                sb.AppendLine("\t" + item.cNationID.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cMobile.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cMail.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cZipcode.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cAddress.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.idCity.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cCityname.ToString() + "</td>");
                sb.AppendLine("\t<td>" + GCommon.FindValue("idBlood", item.idBlood.ToString()) + "</td>");
                //sb.AppendLine("\t<td>" + item.idOccupation.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.idEducation.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.cInterests.ToString() + "</td>");
                sb.AppendLine("\t<td>" + item.cEmergerContact.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.idQuestion.ToString() + "</td>");
                //sb.AppendLine("\t<td>" + item.dCreate.ToString() + "</td>");
                //sb.AppendLine("\t<td>");
                //sb.AppendLine("\t</td>");
                sb.AppendLine("</tr>");
                idx++;
            }

            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>���</td>");
            //sb.AppendLine("\t<td nowrap>��Ա����</td>");
            sb.AppendLine("\t<td nowrap>��¼��</td>");
            sb.AppendLine("\t<td nowrap>�Ա�</td>");
            //sb.AppendLine("\t<td nowrap>��������</td>");
            //sb.AppendLine("\t<td nowrap>ͷ��URL</td>");
            //sb.AppendLine("\t<td nowrap>���</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("\t<td nowrap>֤������ ");
            sb.AppendLine("\t ֤������</td>");
            sb.AppendLine("\t<td nowrap>�ֻ�</td>");
            sb.AppendLine("\t<td nowrap>����</td>");
            sb.AppendLine("\t<td nowrap>�ʱ�</td>");
            sb.AppendLine("\t<td nowrap>��ַ</td>");
            //sb.AppendLine("\t<td nowrap>���б���</td>");
            sb.AppendLine("\t<td nowrap>���ڳ���</td>");
            sb.AppendLine("\t<td nowrap>Ѫ��</td>");
            //sb.AppendLine("\t<td nowrap>ְҵ</td>");
            //sb.AppendLine("\t<td nowrap>���ѧ��</td>");
            //sb.AppendLine("\t<td nowrap>��Ȥ����</td>");
            sb.AppendLine("\t<td nowrap>������ϵ��ʽ</td>");
            //sb.AppendLine("\t<td nowrap>��������</td>");
            //sb.AppendLine("\t<td nowrap>����ʱ��</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
        }

        PageResult = sb.ToString();

        // ��ҳ�ؼ�
        if (searchField.Length < 1)
        {
            PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "MemberList.aspx?page={0}");
        }
    }
}
/* Powered by ������������������޹�˾ Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:39 */

