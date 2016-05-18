
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
   #region 基本实体类

   public class WeiboInfo
   {
      // 编号
      private int _id = 0;
      public int id 
      {
         get { return _id; }
         set { _id = (int)value;  }
      }
      // 头像图片地址
      private string _cFaceUrl = String.Empty;
      public string cFaceUrl 
      {
         get { return _cFaceUrl; }
         set { _cFaceUrl = XString.SqlSafe((string)value); }
      }
      // 微博用户名
      private string _cUsername = String.Empty;
      public string cUsername 
      {
         get { return _cUsername; }
         set { _cUsername = XString.SqlSafe((string)value); }
      }
      // 微博地址
      private string _cUserUrl = String.Empty;
      public string cUserUrl 
      {
         get { return _cUserUrl; }
         set { _cUserUrl = XString.SqlSafe((string)value); }
      }
      // 该条微博地址如有
      private string _cWeiboUrl = String.Empty;
      public string cWeiboUrl 
      {
         get { return _cWeiboUrl; }
         set { _cWeiboUrl = XString.SqlSafe((string)value); }
      }
      // 微博内容
      private string _cContent = String.Empty;
      public string cContent 
      {
         get { return _cContent; }
         set { _cContent = XString.SqlSafe((string)value); }
      }
      // 创建时间
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
      // 错误信息
      public string _err = String.Empty;
      // 错误信息
      public string _sql = String.Empty;
      // 分页查询最大页数
      public int _MAX_PAGE_NUMBER = 200;
      // 数据库.表.名称
      private static string Database = "[YP_DB_3].[dbo].[tblWEIBO]";

      public Weibo() { }

      #region 数据库初始化

      /// <summary>
      /// 数据库初始化
      /// </summary>
      public void Database_Initialize()
      {
         StringBuilder sql = new StringBuilder();
         // 创建表TABLE
         // 记得修改种子起始值
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

         // 主键
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

         // 默认值
         // 添加或修改字段，添加字段的话后面加逗号！
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

      #region 数据操作系列函数

      /// <summary>
      /// 新增记录
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>成功返回true，失败返回false</return>
      public bool Insert(WeiboInfo item, out int index)
      {
         index = 0;
         StringBuilder sql = new StringBuilder();
         sql.Append("DECLARE @last_index int;");
         sql.Append("INSERT INTO " + Database + " ");
         sql.Append("(cFaceUrl,cUsername,cUserUrl,cWeiboUrl,cContent) ");
         sql.Append("VALUES (");
         // 构建赋值语句组合
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
      /// 修改记录(NORMAL)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>成功返回true，失败返回false</return>
      public bool Update(WeiboInfo item)
      {
         if (item == null) { _err = "item is null"; return false; }
         if (item.id <= 0) { _err = "item.id <= 0"; return false; }
         StringBuilder sql = new StringBuilder();
         sql.Append("UPDATE " + Database + " SET ");
         // 构建赋值语句组合
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
      /// 修改记录(BY FIELD)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>成功返回true，失败返回false</return>
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
      /// 修改记录(BY COMMAND)
      /// </summary>
      /// <param name="item">WeiboInfo</param>
      /// <return>成功返回true，失败返回false</return>
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
      /// 删除记录
      /// </summary>
      /// <param name="id"></param>
      /// <return>成功返回true，失败返回false</return>
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
      /// 读取记录
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
      /// 分页编号
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
      /// 分页列表
      /// </summary>
      /// <param name="pageIndex">页号（1开始）</param>
      /// <param name="pageSize">每页记录数</param>
      /// <param name="pageCount">总页数</param>
      /// <param name="conditionString">查询条件，含WHERE</param>
      /// <param name="orderString">排序条件，含ORDER BY</param>
      /// <return>WeiboInfo List</return>
      public List<WeiboInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
      {
         // 预先赋值
         pageCount = 0;
         // 检测页号
         if (pageIndex < 0 || pageIndex > _MAX_PAGE_NUMBER)
         { 
            _err = "error page number"; 
            return null; 
         }

         // 检测并修正查询语句
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
         // 查询总数并计算总页数
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

         // 构建合适的查询PL.SQL语句
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
      /// 统计
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
