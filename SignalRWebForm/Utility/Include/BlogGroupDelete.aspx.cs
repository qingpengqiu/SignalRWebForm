using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Include_BlogGroupDelete : System.Web.UI.Page
{
   protected void Page_Load(object sender, EventArgs e)
   {
      #region 身份确认
      Member m = new Member();
      MemberInfo u = m.Default;
      if(u == null) 
      {
         Response.Write("没有操作权限！");
         return;
      }
      #endregion

      int recordIndex = 0;
      if (Request.QueryString["id"] != null)
      {
         try
         {
            recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
         }
         catch(Exception ex) 
         { 
            Response.Write("编号(id)错误[" + ex.Message + "]！"); 
            return; 
         }
      }
      else
      {
         Response.Write("数据错误(Querystring is null)！");
         return;
      }

      // 验证码校验
      string checksum = "";
      if (Request.QueryString["checksum"] != null)
      {
         checksum = Request.QueryString["checksum"].ToString().ToLower();
      }
      else
      {
         Response.Write("验证码错误(checksum is null)！");
         return;
      }
      if (String.Compare(checksum, XString.MD5(recordIndex.ToString()), true) != 0)
      {
         Response.Write("验证码错误(checksum is error)！");
         return;
      }

      if (recordIndex <= 0)
      {
         Response.Write("编号错误(id error)！");
         return;
      }

      // 读取数据(id)
      BlogGroup table = new BlogGroup();
      BlogGroupInfo record = table.Load(recordIndex, "", "");
      if (record == null)
      {
         Response.Write("数据错误(Index error)！");
         return;
      }

      // 非信息所有者不可修改
      if (record.idUser != u.id)
      {
         Response.Write("非信息所有者不可删除");
         return;
      }

      if (table.Delete(recordIndex))
      {
         Response.Write("OK");
      }
      else
      {
         Response.Write("系统错误：" + table._err);
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

