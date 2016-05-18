using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Weibo_Detail : System.Web.UI.Page
{

   // 页面信息
   public string PageResult = "";
   public WeiboInfo record = new WeiboInfo();

   protected void Page_Load(object sender, EventArgs e)
   {
      if (!Admin.IsAdmin()) 
      {
         Response.Redirect("/admin/");
      }

      // 读取数据
      Weibo table = new Weibo();
      if (Request["id"] != null)
      {
         int recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
         record = table.Load(recordIndex, "", "");
         if (record == null)
         {
            record = new WeiboInfo();
            PageResult = "无效数据错误(Data null)！";
            return;
         }
      }
      else
      {
         PageResult = "数据错误(Querystring is null)！";
         return;
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */

