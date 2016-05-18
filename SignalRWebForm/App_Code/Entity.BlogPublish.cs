
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region 基本实体类

    public class BlogPublishInfo
    {
        // 编号
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // 页面位置ID
        private int _idPosition = 0;
        public int idPosition
        {
            get { return _idPosition; }
            set { _idPosition = (int)value; }
        }
        // 信息ID
        private int _idInfo = 0;
        public int idInfo
        {
            get { return _idInfo; }
            set { _idInfo = (int)value; }
        }
        // 图片ID
        private int _idImage = 0;
        public int idImage
        {
            get { return _idImage; }
            set { _idImage = (int)value; }
        }
        // 权重
        private int _iWeight = 0;
        public int iWeight
        {
            get { return _iWeight; }
            set { _iWeight = (int)value; }
        }
        // 标题
        private string _cTitle = "";
        public string cTitle
        {
            get { return _cTitle; }
            set { _cTitle = (string)value; }
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

    public partial class BlogPublish : SQLHelper
    {
        // 错误信息
        public string _err = String.Empty;
        // 错误信息
        public string _sql = String.Empty;
        // 分页查询最大页数
        public int _MAX_PAGE_NUMBER = 200;
        // 数据库.表.名称
        private static string Database = "[YP_DB_2].[dbo].[tblBLOG_PUBLISH]";
        // 列表.缓存
        private static string cacheName = "CACHE_OF_BLOGPUBLISH";
        private List<BlogPublishInfo> Items = null;
        // 哈希.缓存
        private string cacheNameOfid = "CACHE_OF_BLOGPUBLISH_ID";
        private Hashtable hashOfid = null;

        public BlogPublish() { }

        public void CacheInitialize()
        {
            if (!CacheHelper.Get(cacheName, out Items))
            {
                int pcnt = 0;
                Items = PageList(0, 0, "", "", out pcnt);
                if (Items != null)
                {
                    CacheHelper.Save(cacheName, Items);
                }
            }
            if (Items == null) { _err = "no list cache."; return; }

            hashOfid = (Hashtable)TCache.Load(cacheNameOfid);
            if (hashOfid == null)
            {
                hashOfid = new Hashtable();
                foreach (BlogPublishInfo item in Items)
                {
                    if (hashOfid[item.id.ToString().ToLower()] == null)
                    {
                        hashOfid.Add(item.id.ToString().ToLower(), item);
                    }
                }
            }
        }

        private void CacheClear()
        {
            CacheHelper.Clear(cacheName);
            TCache.Clear(cacheNameOfid);
        }

        #region 数据操作系列函数

        /// <summary>
        /// 新增记录
        /// </summary>
        /// <param name="item">BlogPublishInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Insert(BlogPublishInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("DECLARE @last_index int;");
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idPosition,idInfo,idImage,iWeight,cTitle) ");
            sql.Append("VALUES (");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idPosition.ToString() + "',");
            _s.Append("'" + item.idInfo.ToString() + "',");
            _s.Append("'" + item.idImage.ToString() + "',");
            _s.Append("'" + item.iWeight.ToString() + "',");
            _s.Append("'" + item.cTitle.ToString() + "',");
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
                    index = Int32.Parse(sr[0].ToString());
                }
                sr.Close();
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            //CacheClear();
            return true;
        }

        /// <summary>
        /// 修改记录(NORMAL)
        /// </summary>
        /// <param name="item">BlogPublishInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Update(BlogPublishInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("idPosition='" + item.idPosition.ToString() + "',");
            _s.Append("idInfo='" + item.idInfo.ToString() + "',");
            _s.Append("idImage='" + item.idImage.ToString() + "',");
            _s.Append("iWeight='" + item.iWeight.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(" ");
            sql.Append("WHERE id=" + item.id.ToString());

            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql.ToString());
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            //CacheClear();
            return true;
        }

        /// <summary>
        /// 修改记录(BY FIELD)
        /// </summary>
        /// <param name="item">BlogPublishInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateBy(BlogPublishInfo item, string fieldName, string fieldValue)
        {
            if (item.id < 1) { _err = "item.id <= 0"; return false; }
            if (fieldName.Length < 1) { _err = "fieldName length = 0"; return false; }

            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.SqlSafe(fieldName) + "='" + XString.SqlSafe(fieldValue) + "' ");
            sql.Append("WHERE id=" + item.id.ToString());
            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql.ToString());
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            //CacheClear();
            return true;
        }

        /// <summary>
        /// 修改记录(BY COMMAND)
        /// </summary>
        /// <param name="item">BlogPublishInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateByCommand(int local_id, string command)
        {
            if (local_id <= 0) { _err = "local_id  <= 0"; return false; }
            if (command.Length < 1) { _err = "no command"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.UnTail(command) + " ");
            sql.Append("WHERE id=" + local_id);
            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql.ToString());
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            //CacheClear();
            return true;
        }

        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="id"></param>
        /// <return>成功返回true，失败返回false</return>
        public bool Delete(int local_id)
        {
            if (local_id <= 0) { _err = "local_id<= 0"; return false; }
            string sql = "";
            sql += "DELETE FROM " + Database + " ";
            sql += "WHERE id=" + local_id;
            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql);
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            //CacheClear();
            return true;
        }

        /// <summary>
        /// 读取记录
        /// </summary>
        /// <param name="id"></param>
        /// <return>BlogPublishInfo</return>
        public BlogPublishInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            BlogPublishInfo item = null;
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
                    item = new BlogPublishInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idPosition = Int32.Parse(sr["idPosition"].ToString());
                    item.idInfo = Int32.Parse(sr["idInfo"].ToString());
                    item.idImage = Int32.Parse(sr["idImage"].ToString());
                    item.iWeight = Int32.Parse(sr["iWeight"].ToString());
                    item.cTitle = "" + sr["cTitle"].ToString();
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
                    if (idx >= pageSize * (pageIndex - 1) && idx < pageSize * pageIndex)
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
        /// <return>BlogPublishInfo List</return>
        public List<BlogPublishInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<BlogPublishInfo> list = new List<BlogPublishInfo>();
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
                    BlogPublishInfo item = new BlogPublishInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idPosition = Int32.Parse(sr["idPosition"].ToString());
                    item.idInfo = Int32.Parse(sr["idInfo"].ToString());
                    item.idImage = Int32.Parse(sr["idImage"].ToString());
                    item.iWeight = Int32.Parse(sr["iWeight"].ToString());
                    item.cTitle = "" + sr["cTitle"].ToString();
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
                    result = Int32.Parse(sr[0].ToString());
                }
                sr.Close();
            }
            catch (Exception ex) { _err = ex.Message; return 0; }
            return result;
        }

        #endregion

        #region 高级查询方法

        /// <summary>
        /// 按序号查询
        /// </summary>
        /// <param name="recordIndex">编号</param>
        /// <return>BlogPublishInfo result</return>
        public BlogPublishInfo Find(int recordIndex)
        {
            // 哈希查询
            if (hashOfid == null) CacheInitialize();
            if (hashOfid == null) return null;
            return (BlogPublishInfo)hashOfid[recordIndex.ToString()];
        }

        /// <summary>
        /// 按字段查询
        /// </summary>
        /// <param name="fieldName">字段名</param>
        /// <param name="fieldValue">字段值</param>
        /// <return>BlogPublishInfo result</return>
        public BlogPublishInfo FindBy(string fieldName, string fieldValue)
        {
            // 哈希查询
            if (String.Compare(fieldName, "id", true) == 0)
            {
                if (hashOfid == null) CacheInitialize();
                if (hashOfid == null) return null;
                return (BlogPublishInfo)hashOfid[fieldValue.ToLower()];
            }

            // 缓存列表查询
            if (Items == null) CacheInitialize();
            if (Items == null) return null;
            foreach (BlogPublishInfo item in Items)
            {
                switch (fieldName.ToLower())
                {
                    case "idposition":
                        if (item.idPosition == Int32.Parse(fieldValue)) { return item; }
                        break;
                    case "idimage":
                        if (item.idImage == Int32.Parse(fieldValue)) { return item; }
                        break;
                }
            }
            return null;
        }
        /*
        /// <summary>
        /// 按字段模糊查询(仅字符串型字段)
        /// </summary>
        /// <param name="fieldName">字段名</param>
        /// <param name="fieldValue">字段值</param>
        /// <return>BlogPublishInfo result</return>
        public BlogPublishInfo FindLike(string fieldName, string fieldValue)
        {
            // 缓存列表模糊查询
            foreach (BlogPublishInfo item in Items)
            {
                switch (fieldName.ToLower())
                {
                }
            }
            return null;
        }
        */
        #endregion

    }
}
