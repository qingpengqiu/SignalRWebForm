using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Weibo_Create : System.Web.UI.Page
{

   // ҳ�淴����Ϣ
   public string PageResult = "";
   public WeiboInfo record = new WeiboInfo();

   protected void Page_Load(object sender, EventArgs e)
   {
      if (!Admin.IsAdmin()) 
      {
         Response.Redirect("/admin/");
      }

      // �������ݲ��������棩
      record = new WeiboInfo();
      if (Request.Form.Count > 0)
      {
         #region �����걸�Լ��
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
               PageResult = "����(ͷ��)��ʽ����[" + ex.Message + "]�����飡"; 
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
               PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡"; 
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
               PageResult = "����(������ַ)��ʽ����[" + ex.Message + "]�����飡"; 
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
               PageResult = "����(����΢����ַ����)��ʽ����[" + ex.Message + "]�����飡"; 
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
               PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡"; 
               return; 
            }
         }
         #endregion

         // ���ݼ����ɣ���Ӽ�¼��
         if (finishedFieldCount >= 0 && PageResult.Length == 0)
         {
            Weibo table = new Weibo();
            int recordIndex = 0;
            if (table.Insert(record, out recordIndex))
            {
               PageResult = "������ӳɹ���";
            }
            else
            {
               PageResult = "ϵͳ����" + table._err;
            }
         }
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 10-09 13:39 */

