using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Admin_Weibo_List : System.Web.UI.Page
{
   // ҳ����Ϣ
   public string PageResult = "";
   public string PageNavigator = "";

   protected void Page_Load(object sender, EventArgs e)
   {
      if (!Admin.IsAdmin()) 
      {
         Response.Redirect("/admin/");
      }

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
      Weibo table = new Weibo();
      List<WeiboInfo> items = new List<WeiboInfo>();
      if(searchField.Length > 0)
      {
         pageIndex = 1;
         string[] fa = searchField.Split(':');
         string qry = "";
         if(fa[0].Contains("int") || fa[0].Contains("float")) qry = "WHERE (" + fa[1] + " BETWEEN " + searchValue1 + " AND " + searchValue2 + ")";
         if(fa[0].Contains("datetime")) qry = "WHERE (" + fa[1] + " BETWEEN '" + searchValue1 + "' AND '" + searchValue2 + "')";
         if(fa[0].Contains("char") || fa[0].Contains("text")) qry = "WHERE (" + fa[1] + " LIKE '%" + searchValue1 + "%')";
            items = table.PageList(pageIndex, pageSize, qry, "ORDER BY id DESC", out pageCount);
      }
      else
      {
         items = table.PageList(pageIndex, pageSize, "", "ORDER BY id DESC", out pageCount);
      }

      // ����ҳ����Ϣ
      StringBuilder sb = new StringBuilder();
      if (items !=null && items.Count > 0)
      {
         sb.AppendLine("<table id=\"tableCreate\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\" bordercolor=\"#CCCCCC\" style=\"border-collapse:collapse;\">");
         sb.AppendLine("<tr class=\"trTitle\">");
         sb.AppendLine("\t<td nowrap>���</td>");
         sb.AppendLine("\t<td nowrap>ͼƬ</td>");
         sb.AppendLine("\t<td nowrap>��������</td>");
         sb.AppendLine("\t<td nowrap>������ַ</td>");
         sb.AppendLine("\t<td nowrap>���±���</td>");
         sb.AppendLine("\t<td nowrap>����ʱ��</td>");
         sb.AppendLine("\t<td nowrap style=\"width:120px;\">����</td>");
         sb.AppendLine("</tr>");

         int idx = 1;
         foreach (WeiboInfo item in items)
         {
            sb.AppendLine("<tr id=\"trData_" + idx + "\" class=\"tr1\" onmouseover=\"this.className='tr2';\" onmouseout=\"this.className='tr1';\">");
            sb.AppendLine("\t<td><span class=\"span_href\" onclick=\"ItemShow(" + item.id + ")\">" + item.id.ToString() + "</span></td>");
            sb.AppendLine("\t<td>" + item.cFaceUrl.ToString() + "</td>");
            sb.AppendLine("\t<td>" + item.cUsername.ToString() + "</td>");
            sb.AppendLine("\t<td>" + item.cUserUrl.ToString() + "</td>");
            sb.AppendLine("\t<td>" + item.cContent.ToString() + "</td>");
            sb.AppendLine("\t<td>" + item.dCreate.ToString() + "</td>");
            sb.AppendLine("\t<td>");
            sb.AppendLine("\t<div id=\"span_update\" onclick=\"ItemUpdate(" + item.id + "," + idx + ")\"></div>");
            sb.AppendLine("\t<div id=\"span_delete\" onclick=\"ItemDelete(" + item.id + "," + idx + ",'" + XString.MD5(item.id.ToString()) + "')\"></div>");
            sb.AppendLine("\t</td>");
            sb.AppendLine("</tr>");
            idx++;
         }

         sb.AppendLine("<tr class=\"trTitle\">");
         sb.AppendLine("\t<td nowrap>���</td>");
         sb.AppendLine("\t<td nowrap>ͼƬ</td>");
         sb.AppendLine("\t<td nowrap>��������</td>");
         sb.AppendLine("\t<td nowrap>������ַ</td>");
         sb.AppendLine("\t<td nowrap>���±���</td>");
         sb.AppendLine("\t<td nowrap>����ʱ��</td>");
         sb.AppendLine("\t<td nowrap>����</td>");
         sb.AppendLine("</tr>");
         sb.AppendLine("</table>");
      }
      else
      {
         sb.AppendLine("<div style=\"padding:20px;\">û����Ϣ...</div>");
      }

      PageResult = sb.ToString();

      // ��ҳ�ؼ�
      if(searchField.Length < 1)
      {
         PageNavigator = Pager.Navigator(pageIndex, pageSize, pageCount, "WeiboList.aspx?page={0}");
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */

