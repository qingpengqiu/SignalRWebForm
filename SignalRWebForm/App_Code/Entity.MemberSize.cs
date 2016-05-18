
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region 基本实体类

    public class MemberSizeInfo
    {
        // 用户ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // 脚长CM
        private int _iFootLength = 0;
        public int iFootLength
        {
            get { return _iFootLength; }
            set { _iFootLength = (int)value; }
        }
        // 脚宽CM
        private int _iFootWidth = 0;
        public int iFootWidth
        {
            get { return _iFootWidth; }
            set { _iFootWidth = (int)value; }
        }
        // 脚高CM
        private int _iFootHeight = 0;
        public int iFootHeight
        {
            get { return _iFootHeight; }
            set { _iFootHeight = (int)value; }
        }
        // 身高CM
        private int _iBodyHeight = 0;
        public int iBodyHeight
        {
            get { return _iBodyHeight; }
            set { _iBodyHeight = (int)value; }
        }
        // 体重KG
        private int _iBodyWeight = 0;
        public int iBodyWeight
        {
            get { return _iBodyWeight; }
            set { _iBodyWeight = (int)value; }
        }
        // 胸围CM
        private int _iChestSize = 0;
        public int iChestSize
        {
            get { return _iChestSize; }
            set { _iChestSize = (int)value; }
        }
        // 腰围CM
        private int _iWaistSize = 0;
        public int iWaistSize
        {
            get { return _iWaistSize; }
            set { _iWaistSize = (int)value; }
        }
        // 臀围CM
        private int _iHipSize = 0;
        public int iHipSize
        {
            get { return _iHipSize; }
            set { _iHipSize = (int)value; }
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

    public class MemberSize : SQLHelper
    {
        // 错误信息
        public string _err = String.Empty;
        // 错误信息
        public string _sql = String.Empty;
        // 分页查询最大页数
        public int _MAX_PAGE_NUMBER = 200;
        // 数据库.表.名称
        private static string Database = "[YP_DB_1].[dbo].[tblMEMBER_SIZE]";

        public MemberSize() { }

        #region 数据操作系列函数
        
        /// <summary>
        /// 修改记录(NORMAL)
        /// </summary>
        /// <param name="item">MemberSizeInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool Update(MemberSizeInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.idUser <= 0) { _err = "item.idUser <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // 构建赋值语句组合
            StringBuilder _s = new StringBuilder();
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("iFootLength='" + item.iFootLength.ToString() + "',");
            _s.Append("iFootWidth='" + item.iFootWidth.ToString() + "',");
            _s.Append("iFootHeight='" + item.iFootHeight.ToString() + "',");
            _s.Append("iBodyHeight='" + item.iBodyHeight.ToString() + "',");
            _s.Append("iBodyWeight='" + item.iBodyWeight.ToString() + "',");
            _s.Append("iChestSize='" + item.iChestSize.ToString() + "',");
            _s.Append("iWaistSize='" + item.iWaistSize.ToString() + "',");
            _s.Append("iHipSize='" + item.iHipSize.ToString() + "',");
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
        /// <param name="item">MemberSizeInfo</param>
        /// <return>成功返回true，失败返回false</return>
        public bool UpdateBy(MemberSizeInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">MemberSizeInfo</param>
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
        /// <return>MemberSizeInfo</return>
        public MemberSizeInfo Load(int local_iduser, string fieldName, string fieldValue)
        {
            if (local_iduser <= 0) { _err = "local_iduser <= 0"; return null; }
            MemberSizeInfo item = null;
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
                    item = new MemberSizeInfo();
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.iFootLength = Int32.Parse(sr["iFootLength"].ToString());
                    item.iFootWidth = Int32.Parse(sr["iFootWidth"].ToString());
                    item.iFootHeight = Int32.Parse(sr["iFootHeight"].ToString());
                    item.iBodyHeight = Int32.Parse(sr["iBodyHeight"].ToString());
                    item.iBodyWeight = Int32.Parse(sr["iBodyWeight"].ToString());
                    item.iChestSize = Int32.Parse(sr["iChestSize"].ToString());
                    item.iWaistSize = Int32.Parse(sr["iWaistSize"].ToString());
                    item.iHipSize = Int32.Parse(sr["iHipSize"].ToString());
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
        /// <return>MemberSizeInfo List</return>
        public List<MemberSizeInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<MemberSizeInfo> list = new List<MemberSizeInfo>();
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
                    MemberSizeInfo item = new MemberSizeInfo();
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.iFootLength = Int32.Parse(sr["iFootLength"].ToString());
                    item.iFootWidth = Int32.Parse(sr["iFootWidth"].ToString());
                    item.iFootHeight = Int32.Parse(sr["iFootHeight"].ToString());
                    item.iBodyHeight = Int32.Parse(sr["iBodyHeight"].ToString());
                    item.iBodyWeight = Int32.Parse(sr["iBodyWeight"].ToString());
                    item.iChestSize = Int32.Parse(sr["iChestSize"].ToString());
                    item.iWaistSize = Int32.Parse(sr["iWaistSize"].ToString());
                    item.iHipSize = Int32.Parse(sr["iHipSize"].ToString());
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
