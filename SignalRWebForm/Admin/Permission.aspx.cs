using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Permission : System.Web.UI.Page
{

    // 页面信息
    public string PageResult = "";
    public string PageBuffer = "";
    public string PageNavigator = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsSuper())
        {
            //PageResult = "没有操作权限！";
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
                    PageResult = "授权成功";
                }
                else
                {
                    PageResult = "用户ID或登录名错误1";
                }
            }
            else
            {
                PageResult = "用户ID或登录名错误2";
            }
        }

        // 收回授权
        if (Request.QueryString["opr"] != null)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Int32.Parse(Request.QueryString["id"].ToString());
                Member m1 = new Member();
                m1.UpdateByCommand(id, "idMemberStyle=0");
            }
        }

        // 获取页号，默认为1
        int pageIndex = 1;
        if (Request.QueryString["page"] != null)
        {
            pageIndex = Int32.Parse(XString.PureNumber(Request.QueryString["page"].ToString()));
        }
        if (pageIndex < 1)
        {
            PageBuffer = "页号错误！";
            return;
        }
        // 每页记录数(默认30)
        int pageSize = 30;
        // 总页数
        int pageCount = 0;

        // 查询记录（分页）
        Member table = new Member();
        List<MemberInfo> items = table.PageList(pageIndex, pageSize, "WHERE idMemberStyle>0", "ORDER BY id DESC", out pageCount);

        // 构建页面信息
        StringBuilder sb = new StringBuilder();
        if (items != null && items.Count > 0)
        {
            sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
            sb.AppendLine("<tr class=\"trTitle\">");
            sb.AppendLine("\t<td nowrap>编号</td>");
            sb.AppendLine("\t<td nowrap>会员类型</td>");
            sb.AppendLine("\t<td nowrap>登录名</td>");
            //sb.AppendLine("\t<td nowrap>性别</td>");
            sb.AppendLine("\t<td nowrap>姓名</td>");
            //sb.AppendLine("\t<td nowrap>证件类型 ");
            //sb.AppendLine("\t 证件号码</td>");
            sb.AppendLine("\t<td nowrap>手机</td>");
            sb.AppendLine("\t<td nowrap>邮箱</td>");
            sb.AppendLine("</tr>");

            int idx = 1;
            foreach (MemberInfo item in items)
            {
                if (item.idMemberStyle == 99) continue;

                sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
                sb.AppendLine("\t<td nowrap>" + item.id.ToString() + "</td>");
                sb.AppendLine("\t<td nowrap>" + item.idMemberStyle.ToString() + ":" + GCommon.FindValue("idAdminStyle", item.idMemberStyle.ToString()) + " <a href=\"?opr=back&id=" + item.id.ToString() + "\">收回</a></td>");
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
            sb.AppendLine("\t<td nowrap>编号</td>");
            sb.AppendLine("\t<td nowrap>会员类型</td>");
            sb.AppendLine("\t<td nowrap>登录名</td>");
            //sb.AppendLine("\t<td nowrap>性别</td>");
            sb.AppendLine("\t<td nowrap>姓名</td>");
            //sb.AppendLine("\t<td nowrap>证件类型 ");
            //sb.AppendLine("\t 证件号码</td>");
            sb.AppendLine("\t<td nowrap>手机</td>");
            sb.AppendLine("\t<td nowrap>邮箱</td>");
            sb.AppendLine("</tr>");
            sb.AppendLine("</table>");
        }
        else
        {
            sb.AppendLine("<div style=\"padding:20px;\">没有信息...</div>");
        }

        PageBuffer = sb.ToString();

        // 分页控件
        PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "Permission.aspx?page={0}");
    }
}
/* Powered by 北京联高软件开发有限公司 Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:39 */

