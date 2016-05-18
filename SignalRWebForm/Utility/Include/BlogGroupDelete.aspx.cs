using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Include_BlogGroupDelete : System.Web.UI.Page
{
   protected void Page_Load(object sender, EventArgs e)
   {
      #region ���ȷ��
      Member m = new Member();
      MemberInfo u = m.Default;
      if(u == null) 
      {
         Response.Write("û�в���Ȩ�ޣ�");
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
            Response.Write("���(id)����[" + ex.Message + "]��"); 
            return; 
         }
      }
      else
      {
         Response.Write("���ݴ���(Querystring is null)��");
         return;
      }

      // ��֤��У��
      string checksum = "";
      if (Request.QueryString["checksum"] != null)
      {
         checksum = Request.QueryString["checksum"].ToString().ToLower();
      }
      else
      {
         Response.Write("��֤�����(checksum is null)��");
         return;
      }
      if (String.Compare(checksum, XString.MD5(recordIndex.ToString()), true) != 0)
      {
         Response.Write("��֤�����(checksum is error)��");
         return;
      }

      if (recordIndex <= 0)
      {
         Response.Write("��Ŵ���(id error)��");
         return;
      }

      // ��ȡ����(id)
      BlogGroup table = new BlogGroup();
      BlogGroupInfo record = table.Load(recordIndex, "", "");
      if (record == null)
      {
         Response.Write("���ݴ���(Index error)��");
         return;
      }

      // ����Ϣ�����߲����޸�
      if (record.idUser != u.id)
      {
         Response.Write("����Ϣ�����߲���ɾ��");
         return;
      }

      if (table.Delete(recordIndex))
      {
         Response.Write("OK");
      }
      else
      {
         Response.Write("ϵͳ����" + table._err);
      }
   }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-14 16:40 */

