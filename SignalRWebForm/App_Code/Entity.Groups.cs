
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region 基本实体类

    public class GroupsInfo
    {
        // 编码
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // 状态
        private int _iStatus = 1;
        public int iStatus
        {
            get { return _iStatus; }
            set { _iStatus = (int)value; }
        }
        // 积分
        private int _iScore = 0;
        public int iScore
        {
            get { return _iScore; }
            set { _iScore = (int)value; }
        }
        // 分类名称
        private string _cTitle = String.Empty;
        public string cTitle
        {
            get { return _cTitle; }
            set { _cTitle = XString.SqlSafe((string)value); }
        }
        // 备注
        private string _cDescription = String.Empty;
        public string cDescription
        {
            get { return _cDescription; }
            set { _cDescription = XString.SqlSafe((string)value); }
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

    public partial class Groups : SQLHelper
    {
        // 错误信息
        public string _err = String.Empty;
        // 错误信息
        public string _sql = String.Empty;
        // 分页查询最大页数
        public int _MAX_PAGE_NUMBER = 200;
        // 数据库.表.名称
        private static string Database = "[YP_DB_1].[dbo].[tblGROUPS]";
        // 列表.缓存
        private static string cacheList = "CACHE_OF_GROUPS";
        private List<GroupsInfo> Items = null;
        // 哈希.缓存
        private string cacheHash = "CACHE_OF_GROUPS_ID";
        private Hashtable hash = null;

        public Groups()
        {
            CacheInitialize();
        }

        public void CacheInitialize()
        {
            if (!CacheHelper.Get(cacheList, out Items))
            {
                int pcnt = 0;
                Items = PageList(0, 0, "", "", out pcnt);
                if (Items != null)
                {
                    CacheHelper.Save(cacheList, Items);
                }
                _err = "load from db " + _err;
            }
            else
            {
                _err = "load from cache";
            }
            if (Items == null) { /*_err = "no list cache.";*/ return; }

            hash = (Hashtable)TCache.Load(cacheHash);
            if (hash == null)
            {
                hash = new Hashtable();
                foreach (GroupsInfo item in Items)
                {
                    if (hash[item.id.ToString()] == null)
                    {
                        hash.Add(item.id.ToString(), item);
                    }
                }
            }
        }

        private void CacheClear()
        {
            CacheHelper.Clear(cacheList);
            TCache.Clear(cacheHash);
        }

        #region 数据操作系列函数

		/// <summary>
        /// 新增记录
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Insert(GroupsInfo item)
        {
            //index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(id,iScore,cTitle,cDescription) ");
            sql.Append("VALUES (");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.id.ToString() + "',");
            //_s.Append("'" + item.iStatus.ToString() + "',");
            _s.Append("'" + item.iScore.ToString() + "',");
            _s.Append("'" + item.cTitle.ToString() + "',");
            //_s.Append("CHECKSUM('" + item.cTitle.ToString().ToLower() + "'),");
            _s.Append("'" + item.cDescription.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(");");
            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql.ToString());
            }
            catch (Exception ex) { _err = ex.Message; return false; }

            // 清除缓存
            CacheClear();
            return true;
        }


        /// <summary>
        /// 新增记录
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>成功返回true，失败返回false</return>
        private string InsertSql(GroupsInfo item)
        {
            //index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(id,iScore,cTitle,cDescription) ");
            sql.Append("VALUES (");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.id.ToString() + "',");
            //_s.Append("'" + item.iStatus.ToString() + "',");
            _s.Append("'" + item.iScore.ToString() + "',");
            _s.Append("'" + item.cTitle.ToString() + "',");
            //_s.Append("CHECKSUM('" + item.cTitle.ToString().ToLower() + "'),");
            _s.Append("'" + item.cDescription.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(");");
            return sql.ToString();
        }

        
        /// <summary>
        /// 修改记录(NORMAL)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Update(GroupsInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("id='" + item.id.ToString() + "',");
            _s.Append("iStatus='" + item.iStatus.ToString() + "',");
            _s.Append("iScore='" + item.iScore.ToString() + "',");
            _s.Append("cTitle='" + item.cTitle.ToString() + "',");
            _s.Append("iChecksum=CHECKSUM('" + item.cTitle.ToString().ToLower() + "'),");
            _s.Append("cDescription='" + item.cDescription.ToString() + "',");
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
            CacheClear();
            return true;
        }
        
        /// <summary>
        /// 修改记录(BY FIELD)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateBy(GroupsInfo item, string fieldName, string fieldValue)
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
            CacheClear();
            return true;
        }

        /// <summary>
        /// 修改记录(BY COMMAND)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
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
            CacheClear();
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
            CacheClear();
            return true;
        }

        /// <summary>
        /// 读取记录
        /// </summary>
        /// <param name="id"></param>
        /// <return>GroupsInfo</return>
        public GroupsInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            GroupsInfo item = null;
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
                    item = new GroupsInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.iStatus = Int32.Parse(sr["iStatus"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.cTitle = sr["cTitle"].ToString();
                    item.cDescription = sr["cDescription"].ToString();
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
        /// <return>GroupsInfo List</return>
        public List<GroupsInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<GroupsInfo> list = new List<GroupsInfo>();
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
                    GroupsInfo item = new GroupsInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.iStatus = Int32.Parse(sr["iStatus"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.cTitle = sr["cTitle"].ToString();
                    item.cDescription = sr["cDescription"].ToString();
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

        /// <summary>
        /// 按序号查询
        /// </summary>
        /// <param name="recordIndex">编号</param>
        /// <return>GroupsInfo result</return>
        public GroupsInfo Find(int id)
        {
            // 哈希查询
            if (hash == null) CacheInitialize();
            if (hash == null) return null;
            return (GroupsInfo)hash[id.ToString()];
        }

        public string FindTitle(int id)
        {
            // 哈希查询
            if (hash == null) CacheInitialize();
            if (hash == null) return "";
            GroupsInfo gp = (GroupsInfo)hash[id.ToString()];
            if (gp == null) return "";
            return gp.cTitle;
        }

    }
}
