
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region 基本实体类

    public class MemberHistoryInfo
    {
        // 编码
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // 用户ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // 积分类型
        private int _idGroup = 0;
        public int idGroup
        {
            get { return _idGroup; }
            set { _idGroup = (int)value; }
        }
        // 积分与功德
        private int _iScore = 0;
        public int iScore
        {
            get { return _iScore; }
            set { _iScore = (int)value; }
        }
        // 创建者ID
        private int _idCreator = 0;
        public int idCreator
        {
            get { return _idCreator; }
            set { _idCreator = (int)value; }
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

    public class MemberHistory : SQLHelper
    {
        // 错误信息
        public string _err = String.Empty;
        // 错误信息
        public string _sql = String.Empty;
        // 分页查询最大页数
        public int _MAX_PAGE_NUMBER = 200;
        // 数据库.表.名称
        private int _table_index_of_idUser = 0;
        private string Database
        {
            get
            {
                return String.Format(@"[YP_DB_1].[dbo].[tblMEMBER_HISTORY_{0:D1}]", _table_index_of_idUser % 10);
            }
        }

        public MemberHistory() { }

        #region 数据操作系列函数

        /// <summary>
        /// 新增记录
        /// </summary>
        /// <param name="user"></param>
        /// <param name="group"></param>
        /// <return></return>
        public void Insert(int iduser, int group, int flag)
        {
            // 分库必需
            _table_index_of_idUser = iduser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return; }

            #region 第一步：修改用户积分

            Groups g = new Groups();
            GroupsInfo s = g.Find(group);
            if (s != null)
            {
                if (s.iScore != 0)
                {
                    MemberSummary ms = new MemberSummary();
                    ms.UpdateByCommand(iduser, "iScore=iScore+(" + s.iScore * flag + ")");
                }
            }
            Users.Score(iduser, s.iScore * flag);

            #endregion

            #region 第二步：保存积分历史

            StringBuilder sql = new StringBuilder();
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idUser,idGroup,iScore) ");
            sql.Append("VALUES (");
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + iduser.ToString() + "',");
            _s.Append("'" + group.ToString() + "',");
            _s.Append("'" + s.iScore * flag + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(");");

            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(_sql);
            }
            catch (Exception ex) { _err = ex.Message; return; }

            #endregion

            return;
        }
        
        /// <summary>
        /// 修改记录(NORMAL)
        /// </summary>
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Update(MemberHistoryInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            // 分库必需
            _table_index_of_idUser = item.idUser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return false; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return false; }

            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("idGroup='" + item.idGroup.ToString() + "',");
            _s.Append("iScore='" + item.iScore.ToString() + "',");
            _s.Append("idCreator='" + item.idCreator.ToString() + "',");
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
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateBy(MemberHistoryInfo item, string fieldName, string fieldValue)
        {
            // 分库必需
            _table_index_of_idUser = item.idUser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return false; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return false; }

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
            return true;
        }

        /// <summary>
        /// 修改记录(BY COMMAND)
        /// </summary>
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateByCommand(int tableIndex, int local_id, string command)
        {
            if (local_id <= 0) { _err = "local_id  <= 0"; return false; }
            if (command.Length < 1) { _err = "no command"; return false; }
            // 分库必需
            _table_index_of_idUser = tableIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return false; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return false; }

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
            return true;
        }

        /// <summary>
        /// 删除记录
        /// </summary>
        /// <param name="id"></param>
        /// <return>成功返回true，失败返回false</return>
        public bool Delete(int tabIndex, int local_id)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return false; }
            // 分库必需
            if (tabIndex < 0) { _err = "table index < 0"; return false; }
            _table_index_of_idUser = tabIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return false; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return false; }

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

        public bool Duplicate(int iduser, int group, string timeLimit)
        {
            // 分库必需
            if (iduser <= 0) { _err = "iduser <= 0"; return true; }
            _table_index_of_idUser = iduser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return true; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return true; }

            int local_id = 0;
            string sql = "SELECT id FROM " + Database + " WHERE idUser=" + iduser + " AND idGroup=" + group + timeLimit;
            SqlDataReader sr = SQLHelper.ExecuteReader(sql);
            if (sr.Read())
            {
                local_id = Int32.Parse(sr["id"].ToString());
            }
            sr.Close();

            return (local_id > 0) ? true : false;
        }

        /// <summary>
        /// 读取记录
        /// </summary>
        /// <param name="id"></param>
        /// <return>MemberHistoryInfo</return>
        public MemberHistoryInfo Load(int tabIndex, int local_id, string fieldName, string fieldValue)
        {
            // 分库必需
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            if (tabIndex < 0) { _err = "table index <= 0"; return null; }
            _table_index_of_idUser = tabIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return null; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return null; }

            MemberHistoryInfo item = null;
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
                    item = new MemberHistoryInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.idGroup = Int32.Parse(sr["idGroup"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.idCreator =Int32.Parse(sr["idCreator"].ToString());
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
        /// <return>MemberHistoryInfo List</return>
        public List<MemberHistoryInfo> PageList(int tabIndex, int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
        {
            // 预先赋值
            pageCount = 0;
            // 分库必需
            if (tabIndex < 0) { _err = "table index < 0"; return null; }
            _table_index_of_idUser = tabIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return null; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return null; }

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

            List<MemberHistoryInfo> list = new List<MemberHistoryInfo>();
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
                    MemberHistoryInfo item = new MemberHistoryInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.idGroup = Int32.Parse(sr["idGroup"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.idCreator = Int32.Parse(sr["idCreator"].ToString());
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
        public int Count(int tabIndex)
        {
            // 分库必需
            if (tabIndex < 0) { _err = "table index <= 0"; return -1; }
            _table_index_of_idUser = tabIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return -1; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return -1; }

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

    }
}
