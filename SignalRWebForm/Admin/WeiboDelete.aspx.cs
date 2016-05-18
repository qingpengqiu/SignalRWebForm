using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Weibo_Delete : System.Web.UI.Page
{
   protected void Page_Load(object sender, EventArgs e)
   {
      if (!Admin.IsAdmin()) 
      {
         Response.Redirect("/admin/");
      }

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
      Weibo table = new Weibo();
      WeiboInfo record = table.Load(recordIndex, "", "");
      if (record == null)
      {
         Response.Write("数据错误(Index error)！");
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
/* This file formatted by WizForm 2.1 at 10-09 13:39 */
