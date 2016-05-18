
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class MemberHistoryInfo
    {
        // ����
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // �û�ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // ��������
        private int _idGroup = 0;
        public int idGroup
        {
            get { return _idGroup; }
            set { _idGroup = (int)value; }
        }
        // �����빦��
        private int _iScore = 0;
        public int iScore
        {
            get { return _iScore; }
            set { _iScore = (int)value; }
        }
        // ������ID
        private int _idCreator = 0;
        public int idCreator
        {
            get { return _idCreator; }
            set { _idCreator = (int)value; }
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

    public class MemberHistory : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private int _table_index_of_idUser = 0;
        private string Database
        {
            get
            {
                return String.Format(@"[YP_DB_1].[dbo].[tblMEMBER_HISTORY_{0:D1}]", _table_index_of_idUser % 10);
            }
        }

        public MemberHistory() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="user"></param>
        /// <param name="group"></param>
        /// <return></return>
        public void Insert(int iduser, int group, int flag)
        {
            // �ֿ����
            _table_index_of_idUser = iduser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return; }

            #region ��һ�����޸��û�����

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

            #region �ڶ��������������ʷ

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
        /// �޸ļ�¼(NORMAL)
        /// </summary>
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(MemberHistoryInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            // �ֿ����
            _table_index_of_idUser = item.idUser % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return false; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return false; }

            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
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
        /// �޸ļ�¼(BY FIELD)
        /// </summary>
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(MemberHistoryInfo item, string fieldName, string fieldValue)
        {
            // �ֿ����
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
        /// �޸ļ�¼(BY COMMAND)
        /// </summary>
        /// <param name="item">MemberHistoryInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateByCommand(int tableIndex, int local_id, string command)
        {
            if (local_id <= 0) { _err = "local_id  <= 0"; return false; }
            if (command.Length < 1) { _err = "no command"; return false; }
            // �ֿ����
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
        /// ɾ����¼
        /// </summary>
        /// <param name="id"></param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Delete(int tabIndex, int local_id)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return false; }
            // �ֿ����
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
            // �ֿ����
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
        /// ��ȡ��¼
        /// </summary>
        /// <param name="id"></param>
        /// <return>MemberHistoryInfo</return>
        public MemberHistoryInfo Load(int tabIndex, int local_id, string fieldName, string fieldValue)
        {
            // �ֿ����
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
        /// <return>MemberHistoryInfo List</return>
        public List<MemberHistoryInfo> PageList(int tabIndex, int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
        {
            // Ԥ�ȸ�ֵ
            pageCount = 0;
            // �ֿ����
            if (tabIndex < 0) { _err = "table index < 0"; return null; }
            _table_index_of_idUser = tabIndex % 10;
            if (_table_index_of_idUser < 0) { _err = "table index < 0"; return null; }
            if (_table_index_of_idUser > 9) { _err = "table index > 9"; return null; }

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

            List<MemberHistoryInfo> list = new List<MemberHistoryInfo>();
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
        /// ͳ��
        /// </summary>
        /// <return></return>
        public int Count(int tabIndex)
        {
            // �ֿ����
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
