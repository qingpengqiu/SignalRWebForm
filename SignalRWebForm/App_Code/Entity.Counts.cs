
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class CountsInfo
    {
        // ���
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ����
        private int _iDayIndex = 0;
        public int iDayIndex
        {
            get { return _iDayIndex; }
            set { _iDayIndex = (int)value; }
        }
        // ���ݱ�ID
        private int _idTable = 0;
        public int idTable
        {
            get { return _idTable; }
            set { _idTable = (int)value; }
        }
        // TABLE����
        private string _cTablename = String.Empty;
        public string cTablename
        {
            get { return _cTablename; }
            set { _cTablename = XString.SqlSafe((string)value); }
        }
        // ��¼��
        private int _iRecordCount = 0;
        public int iRecordCount
        {
            get { return _iRecordCount; }
            set { _iRecordCount = (int)value; }
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

    public class Counts : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_5].[dbo].[tblCOUNTS]";

        public Counts() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">CountsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(CountsInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("DECLARE @last_index int;");
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(iDayIndex,idTable,cTablename,iRecordCount) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.iDayIndex.ToString() + "',");
            _s.Append("'" + item.idTable.ToString() + "',");
            _s.Append("'" + item.cTablename.ToString() + "',");
            _s.Append("'" + item.iRecordCount.ToString() + "',");
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
            return true;
        }
		
        /// <summary>
        /// �޸ļ�¼(NORMAL)
        /// </summary>
        /// <param name="item">CountsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(CountsInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("iDayIndex='" + item.iDayIndex.ToString() + "',");
            _s.Append("idTable='" + item.idTable.ToString() + "',");
            _s.Append("cTablename='" + item.cTablename.ToString() + "',");
            _s.Append("iRecordCount='" + item.iRecordCount.ToString() + "',");
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
        /// <param name="item">CountsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(CountsInfo item, string fieldName, string fieldValue)
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
            return true;
        }

        /// <summary>
        /// �޸ļ�¼(BY COMMAND)
        /// </summary>
        /// <param name="item">CountsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
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
            return true;
        }

        /// <summary>
        /// ɾ����¼
        /// </summary>
        /// <param name="id"></param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
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
            return true;
        }
		
        /// <summary>
        /// ��ȡ��¼
        /// </summary>
        /// <param name="id"></param>
        /// <return>CountsInfo</return>
        public CountsInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            CountsInfo item = null;
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
                    item = new CountsInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.iDayIndex = Int32.Parse(sr["iDayIndex"].ToString());
                    item.idTable = Int32.Parse(sr["idTable"].ToString());
                    item.cTablename = sr["cTablename"].ToString();
                    item.iRecordCount = Int32.Parse(sr["iRecordCount"].ToString());
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
        /// <return>CountsInfo List</return>
        public List<CountsInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<CountsInfo> list = new List<CountsInfo>();
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
                    CountsInfo item = new CountsInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.iDayIndex = Int32.Parse(sr["iDayIndex"].ToString());
                    item.idTable = Int32.Parse(sr["idTable"].ToString());
                    item.cTablename = sr["cTablename"].ToString();
                    item.iRecordCount = Int32.Parse(sr["iRecordCount"].ToString());
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
