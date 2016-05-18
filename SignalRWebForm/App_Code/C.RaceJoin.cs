
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public partial class RaceJoin : SQLHelper
    {
        public string JoinerList(int idHref, int idOnwer, int idBrowser)
        {
            int pageCount = 0;
            List<RaceJoinInfo> rlist = PageList(1, 1000, "WHERE idActivity=" + idHref, "", out pageCount);
            if (pageCount > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.AppendLine("<br><br><b>�μ���������</b><br>");
                sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
                sb.AppendLine("<tr class=\"trTitle\">");
                sb.AppendLine("\t<td nowrap>ʱ��</td>");
                sb.AppendLine("\t<td nowrap>�μ���</td>");
                sb.AppendLine("\t<td nowrap>TA����ϵ��ʽ</td>");
                sb.AppendLine("</tr>");

                foreach (RaceJoinInfo ru in rlist)
                {
                    sb.AppendLine("<tr>");
                    sb.AppendLine("<td>" + ru.dCreate.ToString("yyyy-MM-dd HH:mm:ss") + "</td>");
                    sb.AppendLine("<td><a href=\"" + UrlHelper.MemberUrl(ru.idUser) + "\">" + ru.cLoginName + "</a></td>");
                    string ss = "<td>�����߿��Ķ�</td>";

                    if (idBrowser == idOnwer)
                    {
                        UserInfo ui = Users.Find(ru.idUser);
                        if (ui != null)
                        {
                            ss = "<td>";
                            if (ui.cMail.Length > 0) ss += "<a href=\"mailto:" + ui.cMail + "\">" + ui.cMail + "</a>";
                            if (ui.cMobile.Length > 0) ss += "�ֻ�:" + ui.cMobile + " ";
                            if (ui.cCityname.Length > 0) ss += "" + ui.cCityname + " ";
                        }
                        else
                        {
                            ss = "<td>û��TA����Ϣ</td>";
                        }
                    }

                    sb.AppendLine(ss);
                    sb.AppendLine("</tr>");
                }

                sb.AppendLine("<tr class=\"trTitle\">");
                sb.AppendLine("\t<td nowrap>ʱ��</td>");
                sb.AppendLine("\t<td nowrap>�μ���</td>");
                sb.AppendLine("\t<td nowrap>TA����ϵ��ʽ</td>");
                sb.AppendLine("</tr>");
                sb.AppendLine("</table>");

                return sb.ToString();
            }
            return "";
        }
    }
}
