
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class RaceJoinInfo
    {
        // ���
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ������ID
        private int _idOnwer = 0;
        public int idOnwer
        {
            get { return _idOnwer; }
            set { _idOnwer = (int)value; }
        }
        // Լ�ܻID
        private int _idActivity = 0;
        public int idActivity
        {
            get { return _idActivity; }
            set { _idActivity = (int)value; }
        }
        // ������ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // �������ǳ�
        private string _cLoginName = String.Empty;
        public string cLoginName
        {
            get { return _cLoginName; }
            set { _cLoginName = XString.SqlSafe((string)value); }
        }
        // ����˵��
        private string _cMemo = String.Empty;
        public string cMemo
        {
            get { return _cMemo; }
            set { _cMemo = XString.SqlSafe((string)value); }
        }
        // ���
        private int _iMarking = 0;
        public int iMarking
        {
            get { return _iMarking; }
            set { _iMarking = (int)value; }
        }
        // ״̬
        private int _iStatus = 0;
        public int iStatus
        {
            get { return _iStatus; }
            set { _iStatus = (int)value; }
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

    public partial class RaceJoin : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_4].[dbo].[tblRACE_JOIN]";

        public RaceJoin() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">RaceJoinInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(RaceJoinInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("DECLARE @last_index int;");
            // @@@@@@@@@@@@@@@@@@@@@@
            // �����ظ�����
            sql.AppendLine("if exists(SELECT * FROM " + Database + " WHERE idActivity=" + item.idActivity + " AND idUser=" + item.idUser + ") ");
            sql.AppendLine("begin ");
            sql.AppendLine("SELECT @last_index = -1; ");
            sql.AppendLine("SELECT @last_index; ");
            sql.AppendLine("return; ");
            sql.AppendLine("end ");
            // @@@@@@@@@@@@@@@@@@@@@@
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idOnwer,idActivity,idUser,cLoginName,cMemo,iMarking,iStatus) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idOnwer.ToString() + "',");
            _s.Append("'" + item.idActivity.ToString() + "',");
            _s.Append("'" + item.idUser.ToString() + "',");
            _s.Append("'" + item.cLoginName.ToString() + "',");
            _s.Append("'" + item.cMemo.ToString() + "',");
            _s.Append("'" + item.iMarking.ToString() + "',");
            _s.Append("'" + item.iStatus.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.AppendLine(");");
            sql.AppendLine("SELECT @last_index = @@IDENTITY;");
            sql.AppendLine("SELECT @last_index;");

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
            // @@@@@@@@@@@@@@@@@@@@@@
            return (index > 0) ? true : false;
        }
		
        /// <summary>
        /// �޸ļ�¼(NORMAL)
        /// </summary>
        /// <param name="item">RaceJoinInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(RaceJoinInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idActivity='" + item.idActivity.ToString() + "',");
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("cLoginName='" + item.cLoginName.ToString() + "',");
            _s.Append("cMemo='" + item.cMemo.ToString() + "',");
            _s.Append("iMarking='" + item.iMarking.ToString() + "',");
            _s.Append("iStatus='" + item.iStatus.ToString() + "',");
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
        /// <param name="item">RaceJoinInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(RaceJoinInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">RaceJoinInfo</param>
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
        /// <return>RaceJoinInfo</return>
        public RaceJoinInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            RaceJoinInfo item = null;
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
                    item = new RaceJoinInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idOnwer = Int32.Parse(sr["idOnwer"].ToString());
                    item.idActivity = Int32.Parse(sr["idActivity"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cMemo = sr["cMemo"].ToString();
                    item.iMarking = Int32.Parse(sr["iMarking"].ToString());
                    item.iStatus = Int32.Parse(sr["iStatus"].ToString());
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
        /// <return>RaceJoinInfo List</return>
        public List<RaceJoinInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<RaceJoinInfo> list = new List<RaceJoinInfo>();
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
                    RaceJoinInfo item = new RaceJoinInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idOnwer = Int32.Parse(sr["idOnwer"].ToString());
                    item.idActivity = Int32.Parse(sr["idActivity"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cMemo = sr["cMemo"].ToString();
                    item.iMarking = Int32.Parse(sr["iMarking"].ToString());
                    item.iStatus =Int32.Parse(sr["iStatus"].ToString());
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