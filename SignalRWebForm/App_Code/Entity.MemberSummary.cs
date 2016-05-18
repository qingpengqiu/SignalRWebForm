
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region 基本实体类

    public class MemberSummaryInfo
    {
        // 用户ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // 登录次数
        private int _iLoginTimes = 0;
        public int iLoginTimes
        {
            get { return _iLoginTimes; }
            set { _iLoginTimes = (int)value; }
        }
        // 博客数
        private int _iBlogCount = 0;
        public int iBlogCount
        {
            get { return _iBlogCount; }
            set { _iBlogCount = (int)value; }
        }
        // 博客级别
        private int _iBlogLevel = 0;
        public int iBlogLevel
        {
            get { return _iBlogLevel; }
            set { _iBlogLevel = (int)value; }
        }
        // 积分
        private int _iScore = 0;
        public int iScore
        {
            get { return _iScore; }
            set { _iScore = (int)value; }
        }
        // 功德
        private int _iWorks = 0;
        public int iWorks
        {
            get { return _iWorks; }
            set { _iWorks = (int)value; }
        }
        // 粉丝
        private int _iFans = 0;
        public int iFans
        {
            get { return _iFans; }
            set { _iFans = (int)value; }
        }
        // 账户余额
        private double _fMoney = 0.0;
        public double fMoney
        {
            get { return _fMoney; }
            set { _fMoney = (double)value; }
        }
        // 关注博主数
        private int _iFocus = 0;
        public int iFocus
        {
            get { return _iFocus; }
            set { _iFocus = (int)value; }
        }
        // 评论数
        private int _iDiscuss = 0;
        public int iDiscuss
        {
            get { return _iDiscuss; }
            set { _iDiscuss = (int)value; }
        }
        // 留言数
        private int _iNotes = 0;
        public int iNotes
        {
            get { return _iNotes; }
            set { _iNotes = (int)value; }
        }
        // 主题图片
        private int _iFace = 0;
        public int iFace
        {
            get { return _iFace; }
            set { _iFace = (int)value; }
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

    public class MemberSummary : SQLHelper
    {
        // 错误信息
        public string _err = String.Empty;
        // 错误信息
        public string _sql = String.Empty;
        // 分页查询最大页数
        public int _MAX_PAGE_NUMBER = 200;
        // 数据库.表.名称
        private static string Database = "[YP_DB_1].[dbo].[tblMEMBER_SUMMARY]";

        public MemberSummary() { }

        #region 数据操作系列函数

        /// <summary>
        /// 修改记录(NORMAL)
        /// </summary>
        /// <param name="item">MemberSummaryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Update(MemberSummaryInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.idUser <= 0) { _err = "item.idUser <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("iLoginTimes='" + item.iLoginTimes.ToString() + "',");
            _s.Append("iBlogCount='" + item.iBlogCount.ToString() + "',");
            _s.Append("iBlogLevel='" + item.iBlogLevel.ToString() + "',");
            _s.Append("iScore='" + item.iScore.ToString() + "',");
            _s.Append("iWorks='" + item.iWorks.ToString() + "',");
            _s.Append("iFans='" + item.iFans.ToString() + "',");
            _s.Append("fMoney='" + item.fMoney.ToString() + "',");
            _s.Append("iFocus='" + item.iFocus.ToString() + "',");
            _s.Append("iNotes='" + item.iNotes.ToString() + "',");
            _s.Append("iFace='" + item.iFace.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(" ");
            sql.Append("WHERE idUser=" + item.idUser.ToString());

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
        /// <param name="item">MemberSummaryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateBy(MemberSummaryInfo item, string fieldName, string fieldValue)
        {
            if (item.idUser < 1) { _err = "item.idUser <= 0"; return false; }
            if (fieldName.Length < 1) { _err = "fieldName length = 0"; return false; }

            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.SqlSafe(fieldName) + "='" + XString.SqlSafe(fieldValue) + "' ");
            sql.Append("WHERE idUser=" + item.idUser.ToString());
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
        /// <param name="item">MemberSummaryInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateByCommand(int local_iduser, string command)
        {
            if (local_iduser <= 0) { _err = "local_iduser  <= 0"; return false; }
            if (command.Length < 1) { _err = "no command"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.UnTail(command) + " ");
            sql.Append("WHERE idUser=" + local_iduser);
            _sql = sql.ToString();
            try
            {
                SQLHelper.ExecuteSql(sql.ToString());
            }
            catch (Exception ex) { _err = ex.Message; return false; }
            return true;
        }

        /// <summary>
        /// 读取记录
        /// </summary>
        /// <param name="iduser"></param>
        /// <return>MemberSummaryInfo</return>
        public MemberSummaryInfo Load(int local_iduser, string fieldName, string fieldValue)
        {
            if (local_iduser <= 0) { _err = "local_iduser <= 0"; return null; }
            MemberSummaryInfo item = null;
            string sql = "";
            sql += "SELECT * FROM " + Database + " ";
            if (local_iduser > 0)
            {
                sql += "WHERE idUser=" + local_iduser;
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
                    item = new MemberSummaryInfo();
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.iLoginTimes = Int32.Parse(sr["iLoginTimes"].ToString());
                    item.iBlogCount = Int32.Parse(sr["iBlogCount"].ToString());
                    item.iBlogLevel = Int32.Parse(sr["iBlogLevel"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.iWorks = Int32.Parse(sr["iWorks"].ToString());
                    item.iFans = Int32.Parse(sr["iFans"].ToString());
                    item.fMoney = Double.Parse(sr["fMoney"].ToString());
                    item.iFocus = Int32.Parse(sr["iFocus"].ToString());
                    item.iDiscuss = Int32.Parse(sr["iDiscuss"].ToString());
                    item.iNotes = Int32.Parse(sr["iNotes"].ToString());
                    item.iFace = Int32.Parse(sr["iFace"].ToString());
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
            sql += "SELECT TOP " + (pageSize * pageIndex) + " idUser ";
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
        /// <return>MemberSummaryInfo List</return>
        public List<MemberSummaryInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<MemberSummaryInfo> list = new List<MemberSummaryInfo>();
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
                sql = "SELECT * FROM " + Database + " ORDER BY idUser";
            }
            if (pageIndex == 1)
            {
                sql = "SELECT TOP " + pageSize + " * FROM " + Database + " " + conditionString + " " + orderString;
            }
            if (pageIndex > 1)
            {
                string ids = IndexOfPage(pageIndex, pageSize, conditionString, orderString);
                if (ids.Length == 0) { _err = "no records"; return null; }
                sql = "SELECT * FROM " + Database + " WHERE idUser IN (" + ids + ") " + orderString;
            }

            _sql = sql.ToString();
            try
            {
                SqlDataReader sr = SQLHelper.ExecuteReader(sql);
                while (sr.Read())
                {
                    MemberSummaryInfo item = new MemberSummaryInfo();
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.iLoginTimes = Int32.Parse(sr["iLoginTimes"].ToString());
                    item.iBlogCount = Int32.Parse(sr["iBlogCount"].ToString());
                    item.iBlogLevel = Int32.Parse(sr["iBlogLevel"].ToString());
                    item.iScore = Int32.Parse(sr["iScore"].ToString());
                    item.iWorks = Int32.Parse(sr["iWorks"].ToString());
                    item.iFans = Int32.Parse(sr["iFans"].ToString());
                    item.fMoney = Double.Parse(sr["fMoney"].ToString());
                    item.iFocus = Int32.Parse(sr["iFocus"].ToString());
                    item.iDiscuss = Int32.Parse(sr["iDiscuss"].ToString());
                    item.iNotes = Int32.Parse(sr["iNotes"].ToString());
                    item.iFace = Int32.Parse(sr["iFace"].ToString());
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

    }
}
