
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
   #region ����ʵ����

   public class WeiboInfo
   {
      // ���
      private int _id = 0;
      public int id 
      {
         get { return _id; }
         set { _id = (int)value;  }
      }
      // ͷ��ͼƬ��ַ
      private string _cFaceUrl = String.Empty;
      public string cFaceUrl 
      {
         get { return _cFaceUrl; }
         set { _cFaceUrl = XString.SqlSafe((string)value); }
      }
      // ΢���û���
      private string _cUsername = String.Empty;
      public string cUsername 
      {
         get { return _cUsername; }
         set { _cUsername = XString.SqlSafe((string)value); }
      }
      // ΢����ַ
      private string _cUserUrl = String.Empty;
      public string cUserUrl 
      {
         get { return _cUserUrl; }
         set { _cUserUrl = XString.SqlSafe((string)value); }
      }
      // ����΢����ַ����
      private string _cWeiboUrl = String.Empty;
      public string cWeiboUrl 
      {
         get { return _cWeiboUrl; }
         set { _cWeiboUrl = XString.SqlSafe((string)value); }
      }
      // ΢������
      private string _cContent = String.Empty;
      public string cContent 
      {
         get { return _cContent; }
         set { _cContent = XString.SqlSafe((string)value); }
      }
      // ����ʱ��
      private DateTime _dCreate = System.DateTime.Now;
      public DateTime dCreate 
      {
         get { return _dCreate; }
         set { _dCreate = (DateTime)value; }
      }
   }

   #endregion

   public class Weibo : SQLHelper
   {
      // ������Ϣ
      public string _err = String.Empty;
      // ������Ϣ
      public string _sql = String.Empty;
      // ��ҳ��ѯ���ҳ��
      public int _MAX_PAGE_NUMBER = 200;
      // ���ݿ�.��.����
      private static string Database = "[YP_DB_3].[dbo].[tblWEIBO]";

      public Weibo() { }

      #region ���ݿ��ʼ��

      /// <summary>
      /// ���ݿ��ʼ��
      /// </summary>
      public void Database_Initialize()
      {
         StringBuilder sql = new StringBuilder();
         // ������TABLE
         // �ǵ��޸�������ʼֵ
         sql.Append("CREATE TABLE [YP_DB_3].[dbo].[tblWEIBO] ");
         sql.Append("(");
         sql.Append("[id] [int] IDENTITY (1, 1) NOT NULL,");
         sql.Append("[cFaceUrl] [varchar] (128) COLLATE Chinese_PRC_CI_AS NULL,");
         sql.Append("[cUsername] [varchar] (32) COLLATE Chinese_PRC_CI_AS NULL,");
         sql.Append("[cUserUrl] [varchar] (128) COLLATE Chinese_PRC_CI_AS NULL,");
         sql.Append("[cWeiboUrl] [varchar] (128) COLLATE Chinese_PRC_CI_AS NULL,");
         sql.Append("[cContent] [varchar] (300) COLLATE Chinese_PRC_CI_AS NULL,");
         sql.Append("[dCreate] [datetime] NULL,");
         sql.Append(")");
         _sql = sql.ToString().Replace(",)",")");
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return; }

         // ����
         sql.Remove(0, sql.Length);
         sql.Append("ALTER TABLE [dbo].[tblWEIBO] WITH NOCHECK ADD ");
         sql.Append("CONSTRAINT [PK_tblWEIBO] PRIMARY KEY  CLUSTERED ");
         sql.Append("(");
         sql.Append("   [id]");
         sql.Append(")  ON [PRIMARY] ");
         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return; }

         // Ĭ��ֵ
         // ��ӻ��޸��ֶΣ�����ֶεĻ�����Ӷ��ţ�
         sql.Remove(0, sql.Length);
         sql.Append("ALTER TABLE [dbo].[tblWEIBO] WITH NOCHECK ADD ");
         sql.Append("CONSTRAINT [DF_tblWEIBO_idUser] DEFAULT (0) FOR [idUser]");
         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return; }
      }

      #endregion

      #region ���ݲ���ϵ�к���

      /// <summary>
      /// ������¼
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>�ɹ�����true��ʧ�ܷ���false</return>
      public bool Insert(WeiboInfo item, out int index)
      {
         index = 0;
         StringBuilder sql = new StringBuilder();
         sql.Append("DECLARE @last_index int;");
         sql.Append("INSERT INTO " + Database + " ");
         sql.Append("(cFaceUrl,cUsername,cUserUrl,cWeiboUrl,cContent) ");
         sql.Append("VALUES (");
         // ������ֵ������
         StringBuilder _s = new StringBuilder();
         _s.Append("'" + item.cFaceUrl.ToString() + "',");
         _s.Append("'" + item.cUsername.ToString() + "',");
         _s.Append("'" + item.cUserUrl.ToString() + "',");
         _s.Append("'" + item.cWeiboUrl.ToString() + "',");
         _s.Append("'" + item.cContent.ToString() + "',");
         sql.Append(XString.UnTail(_s.ToString()));
         sql.Append(");");
         sql.Append("SELECT @last_index = @@IDENTITY;");
         sql.Append("SELECT @last_index;");

         _sql = sql.ToString();
         try
         {
            SqlDataReader sr = SQLHelper.ExecuteReader(sql.ToString());
            if (sr.Read())
            {
               index = (int)(sr[0]);
            }
            sr.Close();
         }
         catch (Exception ex) { _err = ex.Message; return false; }
         return true;
      }

      /// <summary>
      /// �޸ļ�¼(NORMAL)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>�ɹ�����true��ʧ�ܷ���false</return>
      public bool Update(WeiboInfo item)
      {
         if (item == null) { _err = "item is null"; return false; }
         if (item.id <= 0) { _err = "item.id <= 0"; return false; }
         StringBuilder sql = new StringBuilder();
         sql.Append("UPDATE " + Database + " SET ");
         // ������ֵ������
         StringBuilder _s = new StringBuilder();
         _s.Append("cFaceUrl='" + item.cFaceUrl.ToString() + "',");
         _s.Append("cUsername='" + item.cUsername.ToString() + "',");
         _s.Append("cUserUrl='" + item.cUserUrl.ToString() + "',");
         _s.Append("cWeiboUrl='" + item.cWeiboUrl.ToString() + "',");
         _s.Append("cContent='" + item.cContent.ToString() + "',");
         sql.Append(XString.UnTail(_s.ToString()));
         sql.Append(" ");
         sql.Append("WHERE id=" + item.id.ToString());

         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return false; }
         return true;
      }

      /// <summary>
      /// �޸ļ�¼(BY FIELD)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>�ɹ�����true��ʧ�ܷ���false</return>
      public bool UpdateBy(WeiboInfo item, string fieldName, string fieldValue)
      {
         if (item.id < 1) { _err = "item.id <= 0"; return false; }
         if (fieldName.Length < 1) { _err = "fieldName length = 0"; return false; }

         StringBuilder sql = new StringBuilder();
         sql.Append("UPDATE " + Database + " SET ");
         sql.Append( XString.SqlSafe(fieldName) + "='" + XString.SqlSafe(fieldValue) + "' ");
         sql.Append("WHERE id=" + item.id.ToString());
         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return false; }
         return true;
      }

      /// <summary>
      /// �޸ļ�¼(BY COMMAND)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>�ɹ�����true��ʧ�ܷ���false</return>
      public bool UpdateByCommand(int local_id, string command)
      {
         if (local_id <= 0) { _err = "local_id  <= 0"; return false; }
         if (command.Length < 1) { _err = "no command"; return false; }
         StringBuilder sql = new StringBuilder();
         sql.Append("UPDATE " + Database + " SET ");
         sql.Append( XString.UnTail(command) + " ");
         sql.Append("WHERE id=" + local_id);
         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql.ToString());
         }
         catch (Exception ex) { _err = ex.Message; return false; }
         return true;
      }

      /// <summary>
      /// ɾ����¼
      /// </summary>
      /// <param name="id"></param>
      /// <return>�ɹ�����true��ʧ�ܷ���false</return>
      public bool Delete(int local_id)
      {
         if (local_id <=0 ) { _err = "local_id<= 0"; return false; }
         string sql = "";
         sql += "DELETE FROM " + Database + " ";
         sql += "WHERE id=" + local_id;
         _sql = sql.ToString();
         try
         {
            SQLHelper.ExecuteSql(sql);
         }
         catch (Exception ex) { _err = ex.Message; return false; }
         return true;
      }

      /// <summary>
      /// ��ȡ��¼
      /// </summary>
      /// <param name="id"></param>
      /// <return>WeiboInfo</return>
      public WeiboInfo Load(int local_id, string fieldName, string fieldValue)
      {
         if (local_id <= 0) { _err = "local_id <= 0"; return null; }
         WeiboInfo item = null;
         string sql = "";
         sql += "SELECT * FROM " + Database + " ";
         if (local_id > 0)
         {
            sql += "WHERE id=" + local_id;
         }
         else
         {
            sql += "WHERE " + XString.SqlSafe(fieldName) + "='" + XString.SqlSafe(fieldValue) + "'";
         }
         _sql = sql.ToString();
         try
         {
            SqlDataReader sr = SQLHelper.ExecuteReader(sql);
            if (sr.Read())
            {
               item = new WeiboInfo();
               item.id = (int)(sr["id"]);
               item.cFaceUrl = sr["cFaceUrl"].ToString();
               item.cUsername = sr["cUsername"].ToString();
               item.cUserUrl = sr["cUserUrl"].ToString();
               item.cWeiboUrl = sr["cWeiboUrl"].ToString();
               item.cContent = sr["cContent"].ToString();
               item.dCreate = DateTime.Parse(sr["dCreate"].ToString());
            }
            sr.Close();
         }
         catch (Exception ex) { _err = ex.Message; return null; }
         return item;
      }

      /// <summary>
      /// ��ҳ���
      /// </summary>
      /// <param name="pageIndex"></param>
      /// <param name="pageSize"></param>
      /// <param name="conditionString"></param>
      /// <param name="orderString"></param>
      /// <return></return>
      private string IndexOfPage(int pageIndex, int pageSize, string conditionString, string orderString)
      {
         string sql = "";
         sql += "SELECT TOP " + (pageSize * pageIndex) + " id ";
         sql += "FROM " + Database + " ";
         sql += conditionString + " ";
         sql += orderString;
         StringBuilder sb = new StringBuilder();
         _sql = sql.ToString();
         try
         {
            SqlDataReader sr = SQLHelper.ExecuteReader(sql);
            int idx = 0;
            while (sr.Read())
            {
               if (idx >= pageSize*(pageIndex-1) && idx < pageSize*pageIndex )
               {
                  sb.Append(sr[0] + ",");
               }
               idx++;
            }
            sr.Close();
         }
         catch (Exception ex) { _err = ex.Message; return ""; }
         string rsl = sb.ToString();
         if (rsl.Length > 0) rsl = rsl.Substring(0, rsl.Length - 1);
         return rsl;
      }

      /// <summary>
      /// ��ҳ�б�
      /// </summary>
      /// <param name="pageIndex">ҳ�ţ�1��ʼ��</param>
      /// <param name="pageSize">ÿҳ��¼��</param>
      /// <param name="pageCount">��ҳ��</param>
      /// <param name="conditionString">��ѯ��������WHERE</param>
      /// <param name="orderString">������������ORDER BY</param>
      /// <return>WeiboInfo List</return>
      public List<WeiboInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
      {
         // Ԥ�ȸ�ֵ
         pageCount = 0;
         // ���ҳ��
         if (pageIndex < 0 || pageIndex > _MAX_PAGE_NUMBER)
         { 
            _err = "error page number"; 
            return null; 
         }

         // ��Ⲣ������ѯ���
         if (conditionString.Length > 0 && (!conditionString.ToUpper().StartsWith("WHERE ")))
         {
            conditionString = "WHERE " + conditionString; 
         }
         if (orderString.Length > 0 && (!orderString.ToUpper().StartsWith("ORDER BY ")))
         { 
            orderString = "ORDER BY " + orderString; 
         }

         List<WeiboInfo> list = new List<WeiboInfo>();
         string sql = "";
         // ��ѯ������������ҳ��
         sql = "SELECT COUNT(*) FROM " + Database + " " + conditionString;
         try
         {
            SqlDataReader sc = SQLHelper.ExecuteReader(sql);
            if (sc.Read())
            {
               pageCount = Int32.Parse("0" + sc[0].ToString());
            }
            sc.Close();
         }
         catch (Exception ex) { _err = ex.Message; return null; }

         // �������ʵĲ�ѯPL.SQL���
         if (pageIndex == 0) 
         {
            sql = "SELECT * FROM " + Database + " ORDER BY id";
         }
         if (pageIndex == 1) 
         {
            sql = "SELECT TOP " + pageSize + " * FROM " + Database + " " + conditionString + " " + orderString;
         }
         if (pageIndex > 1)
         {
            string ids = IndexOfPage(pageIndex, pageSize, conditionString, orderString);
            if (ids.Length == 0) { _err = "no records"; return null; }
            sql = "SELECT * FROM " + Database + " WHERE id IN (" + ids + ") " + orderString;
         }

         _sql = sql.ToString();
         try
         {
            SqlDataReader sr = SQLHelper.ExecuteReader(sql);
            while (sr.Read())
            {
               WeiboInfo item = new WeiboInfo();
               item.id = (int)(sr["id"]);
               item.cFaceUrl = sr["cFaceUrl"].ToString();
               item.cUsername = sr["cUsername"].ToString();
               item.cUserUrl = sr["cUserUrl"].ToString();
               item.cWeiboUrl = sr["cWeiboUrl"].ToString();
               item.cContent = sr["cContent"].ToString();
               item.dCreate = DateTime.Parse(sr["dCreate"].ToString());
               list.Add(item);
            }
            sr.Close();
         }
         catch (Exception ex) { _err = ex.Message; return null; }
         return list;
      }

      /// <summary>
      /// ͳ��
      /// </summary>
      /// <return></return>
      public int Count()
      {
         int result = 0;
         string sql = "SELECT COUNT(*) FROM " + Database + " ";
         _sql = sql.ToString();
         try
         {
            SqlDataReader sr = SQLHelper.ExecuteReader(sql);
            if (sr.Read())
            {
               result = (int)(sr[0]);
            }
            sr.Close();
         }
         catch (Exception ex) { _err = ex.Message; return 0; }
         return result;
      }

      #endregion

   }
}
