using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Weibo_Create : System.Web.UI.Page
{

   // 页面反馈信息
   public string PageResult = "";
   public WeiboInfo record = new WeiboInfo();

   protected void Page_Load(object sender, EventArgs e)
   {
      if (!Admin.IsAdmin()) 
      {
         Response.Redirect("/admin/");
      }

      // 接收数据并处理（保存）
      record = new WeiboInfo();
      if (Request.Form.Count > 0)
      {
         #region 数据完备性检查
         int finishedFieldCount = 0;
         if (Request.Form["cFaceUrl"] != null)
         {
            try
            {
               record.cFaceUrl = XString.SqlSafe(Request.Form["cFaceUrl"].ToString());
               finishedFieldCount++;
            }
            catch(Exception ex) 
            { 
               PageResult = "数据(头像)格式错误[" + ex.Message + "]！请检查！"; 
               return; 
            }
         }
         if (Request.Form["cUsername"] != null)
         {
            try
            {
               record.cUsername = XString.SqlSafe(Request.Form["cUsername"].ToString());
               finishedFieldCount++;
            }
            catch(Exception ex) 
            { 
               PageResult = "数据(比赛日期)格式错误[" + ex.Message + "]！请检查！"; 
               return; 
            }
         }
         if (Request.Form["cUserUrl"] != null)
         {
            try
            {
               record.cUserUrl = XString.SqlSafe(Request.Form["cUserUrl"].ToString());
               finishedFieldCount++;
            }
            catch(Exception ex) 
            { 
               PageResult = "数据(赛事网址)格式错误[" + ex.Message + "]！请检查！"; 
               return; 
            }
         }
         /*
         if (Request.Form["cWeiboUrl"] != null)
         {
            try
            {
               record.cWeiboUrl = XString.SqlSafe(Request.Form["cWeiboUrl"].ToString());
               finishedFieldCount++;
            }
            catch(Exception ex) 
            { 
               PageResult = "数据(该条微博地址如有)格式错误[" + ex.Message + "]！请检查！"; 
               return; 
            }
         }
         */
         if (Request.Form["cContent"] != null)
         {
            try
            {
               record.cContent = XString.SqlSafe(Request.Form["cContent"].ToString());
               finishedFieldCount++;
            }
            catch(Exception ex) 
            { 
               PageResult = "数据(赛事名称)格式错误[" + ex.Message + "]！请检查！"; 
               return; 
            }
         }
         #endregion

         // 数据检查完成！添加记录！
         if (finishedFieldCount >= 0 && PageResult.Length == 0)
         {
            Weibo table = new Weibo();
            int recordIndex = 0;
            if (table.Insert(record, out recordIndex))
            {
               PageResult = "数据添加成功！";
            }
            else
            {
               PageResult = "系统错误：" + table._err;
            }
         }
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */

