
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class BlogSummaryInfo
    {
        // ����ID
        private int _idBlog = 0;
        public int idBlog
        {
            get { return _idBlog; }
            set { _idBlog = (int)value; }
        }
        // �Ķ��˴�
        private int _iShowTimes = 0;
        public int iShowTimes
        {
            get { return _iShowTimes; }
            set { _iShowTimes = (int)value; }
        }
        // ������
        private int _iDiscuss = 0;
        public int iDiscuss
        {
            get { return _iDiscuss; }
            set { _iDiscuss = (int)value; }
        }
        // ��
        private int _iDing = 0;
        public int iDing
        {
            get { return _iDing; }
            set { _iDing = (int)value; }
        }
        // ��ע
        private int _iFocus = 0;
        public int iFocus
        {
            get { return _iFocus; }
            set { _iFocus = (int)value; }
        }
        // ����û�ID
        private int _idUserLast = 0;
        public int idUserLast
        {
            get { return _idUserLast; }
            set { _idUserLast = (int)value; }
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

    public class BlogSummary : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_2].[dbo].[tblBLOG_SUMMARY]";

        public BlogSummary() { }

        #region ���ݲ���ϵ�к���

        
        /// <summary>
        /// �޸ļ�¼(NORMAL)
        /// </summary>
        /// <param name="item">BlogSummaryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(BlogSummaryInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.idBlog <= 0) { _err = "item.idBlog <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idBlog='" + item.idBlog.ToString() + "',");
            _s.Append("iShowTimes='" + item.iShowTimes.ToString() + "',");
            _s.Append("iDiscuss='" + item.iDiscuss.ToString() + "',");
            _s.Append("iDing='" + item.iDing.ToString() + "',");
            _s.Append("iFocus='" + item.iFocus.ToString() + "',");
            _s.Append("idUserLast='" + item.idUserLast.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(" ");
            sql.Append("WHERE idBlog=" + item.idBlog.ToString());

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
        /// <param name="item">BlogSummaryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(BlogSummaryInfo item, string fieldName, string fieldValue)
        {
            if (item.idBlog < 1) { _err = "item.idBlog <= 0"; return false; }
            if (fieldName.Length < 1) { _err = "fieldName length = 0"; return false; }

            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.SqlSafe(fieldName) + "='" + XString.SqlSafe(fieldValue) + "' ");
            sql.Append("WHERE idBlog=" + item.idBlog.ToString());
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
        /// <param name="item">BlogSummaryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateByCommand(int local_idblog, string command)
        {
            if (local_idblog <= 0) { _err = "local_idblog  <= 0"; return false; }
            if (command.Length < 1) { _err = "no command"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            sql.Append(XString.UnTail(command) + " ");
            sql.Append("WHERE idBlog=" + local_idblog);
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
        /// <param name="idblog"></param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Delete(int local_idblog)
        {
            if (local_idblog <= 0) { _err = "local_idblog<= 0"; return false; }
            string sql = "";
            sql += "DELETE FROM " + Database + " ";
            sql += "WHERE idBlog=" + local_idblog;
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
        /// <param name="idblog"></param>
        /// <return>BlogSummaryInfo</return>
        public BlogSummaryInfo Load(int local_idblog, string fieldName, string fieldValue)
        {
            if (local_idblog <= 0) { _err = "local_idblog <= 0"; return null; }
            BlogSummaryInfo item = null;
            string sql = "";
            sql += "SELECT * FROM " + Database + " ";
            if (local_idblog > 0)
            {
                sql += "WHERE idBlog=" + local_idblog;
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
                    item = new BlogSummaryInfo();
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.iShowTimes = Int32.Parse(sr["iShowTimes"].ToString());
                    item.iDiscuss = Int32.Parse(sr["iDiscuss"].ToString());
                    item.iDing = Int32.Parse(sr["iDing"].ToString());
                    item.iFocus = Int32.Parse(sr["iFocus"].ToString());
                    item.idUserLast = Int32.Parse(sr["idUserLast"].ToString());
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
            sql += "SELECT TOP " + (pageSize * pageIndex) + " idBlog ";
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
        /// ��ҳ�б�
        /// </summary>
        /// <param name="pageIndex">ҳ�ţ�1��ʼ��</param>
        /// <param name="pageSize">ÿҳ��¼��</param>
        /// <param name="pageCount">��ҳ��</param>
        /// <param name="conditionString">��ѯ��������WHERE</param>
        /// <param name="orderString">������������ORDER BY</param>
        /// <return>BlogSummaryInfo List</return>
        public List<BlogSummaryInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<BlogSummaryInfo> list = new List<BlogSummaryInfo>();
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
                sql = "SELECT * FROM " + Database + " ORDER BY idBlog";
            }
            if (pageIndex == 1)
            {
                sql = "SELECT TOP " + pageSize + " * FROM " + Database + " " + conditionString + " " + orderString;
            }
            if (pageIndex > 1)
            {
                string ids = IndexOfPage(pageIndex, pageSize, conditionString, orderString);
                if (ids.Length == 0) { _err = "no records"; return null; }
                sql = "SELECT * FROM " + Database + " WHERE idBlog IN (" + ids + ") " + orderString;
            }

            _sql = sql.ToString();
            try
            {
                SqlDataReader sr = SQLHelper.ExecuteReader(sql);
                while (sr.Read())
                {
                    BlogSummaryInfo item = new BlogSummaryInfo();
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.iShowTimes = Int32.Parse(sr["iShowTimes"].ToString());
                    item.iDiscuss = Int32.Parse(sr["iDiscuss"].ToString());
                    item.iDing = Int32.Parse(sr["iDing"].ToString());
                    item.iFocus = Int32.Parse(sr["iFocus"].ToString());
                    item.idUserLast = Int32.Parse(sr["idUserLast"].ToString());
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
