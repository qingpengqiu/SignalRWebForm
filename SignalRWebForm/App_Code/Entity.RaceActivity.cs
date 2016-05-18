
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class RaceActivityInfo
    {
        // ���
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ����ID
        private int _idBlog = 0;
        public int idBlog
        {
            get { return _idBlog; }
            set { _idBlog = (int)value; }
        }
        // ����
        private int _idRoadStyle = 0;
        public int idRoadStyle
        {
            get { return _idRoadStyle; }
            set { _idRoadStyle = (int)value; }
        }
        // ����ID
        private int _idCity = 0;
        public int idCity
        {
            get { return _idCity; }
            set { _idCity = (int)value; }
        }
        // ����
        private string _cCityname = String.Empty;
        public string cCityname
        {
            get { return _cCityname; }
            set { _cCityname = XString.SqlSafe((string)value); }
        }
        // �ʱ��
        private DateTime _dOpen = System.DateTime.Now;
        public DateTime dOpen
        {
            get { return _dOpen; }
            set { _dOpen = (DateTime)value; }
        }
        // ������ʼʱ��
        private DateTime _dJoinBegin = System.DateTime.Now;
        public DateTime dJoinBegin
        {
            get { return _dJoinBegin; }
            set { _dJoinBegin = (DateTime)value; }
        }
        // ������ֹʱ��
        private DateTime _dJoinEnd = System.DateTime.Now;
        public DateTime dJoinEnd
        {
            get { return _dJoinEnd; }
            set { _dJoinEnd = (DateTime)value; }
        }
        // ����KM
        private int _iDistance = 0;
        public int iDistance
        {
            get { return _iDistance; }
            set { _iDistance = (int)value; }
        }
        // ����
        private int _iFee = 0;
        public int iFee
        {
            get { return _iFee; }
            set { _iFee = (int)value; }
        }
        // ����
        private int _iWinner = 0;
        public int iWinner
        {
            get { return _iWinner; }
            set { _iWinner = (int)value; }
        }
        // ״̬
        private int _iStatus = 0;
        public int iStatus
        {
            get { return _iStatus; }
            set { _iStatus = (int)value; }
        }
        // ��������
        private int _iLimit = 0;
        public int iLimit
        {
            get { return _iLimit; }
            set { _iLimit = (int)value; }
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

    public class RaceActivity : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_4].[dbo].[tblRACE_ACTIVITY]";

        public RaceActivity() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">RaceActivityInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(RaceActivityInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("DECLARE @last_index int;");
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idBlog,idRoadStyle,idCity,cCityname,dOpen,dJoinBegin,dJoinEnd,iDistance,iFee,iWinner,iStatus,iLimit) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idBlog.ToString() + "',");
            _s.Append("'" + item.idRoadStyle.ToString() + "',");
            _s.Append("'" + item.idCity.ToString() + "',");
            _s.Append("'" + item.cCityname.ToString() + "',");
            _s.Append("'" + item.dOpen.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("'" + item.dJoinBegin.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("'" + item.dJoinEnd.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("'" + item.iDistance.ToString() + "',");
            _s.Append("'" + item.iFee.ToString() + "',");
            _s.Append("'" + item.iWinner.ToString() + "',");
            _s.Append("'" + item.iStatus.ToString() + "',");
            _s.Append("'" + item.iLimit.ToString() + "',");
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
        /// <param name="item">RaceActivityInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(RaceActivityInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idBlog='" + item.idBlog.ToString() + "',");
            _s.Append("idRoadStyle='" + item.idRoadStyle.ToString() + "',");
            _s.Append("idCity='" + item.idCity.ToString() + "',");
            _s.Append("dOpen='" + item.dOpen.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("dJoinBegin='" + item.dJoinBegin.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("dJoinEnd='" + item.dJoinEnd.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("iDistance='" + item.iDistance.ToString() + "',");
            _s.Append("iFee='" + item.iFee.ToString() + "',");
            _s.Append("iWinner='" + item.iWinner.ToString() + "',");
            _s.Append("iStatus='" + item.iStatus.ToString() + "',");
            _s.Append("iLimit='" + item.iLimit.ToString() + "',");
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
        /// <param name="item">RaceActivityInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(RaceActivityInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">RaceActivityInfo</param>
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
        /// <return>RaceActivityInfo</return>
        public RaceActivityInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            RaceActivityInfo item = null;
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
                    item = new RaceActivityInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.idRoadStyle = Int32.Parse(sr["idRoadStyle"].ToString());
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.dOpen = DateTime.Parse(sr["dOpen"].ToString());
                    item.dJoinBegin = DateTime.Parse(sr["dJoinBegin"].ToString());
                    item.dJoinEnd = DateTime.Parse(sr["dJoinEnd"].ToString());
                    item.iDistance = Int32.Parse(sr["iDistance"].ToString());
                    item.iFee =Int32.Parse(sr["iFee"].ToString());
                    item.iWinner =Int32.Parse(sr["iWinner"].ToString());
                    item.iStatus =Int32.Parse(sr["iStatus"].ToString());
                    item.iLimit = Int32.Parse(sr["iLimit"].ToString());
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
        /// <return>RaceActivityInfo List</return>
        public List<RaceActivityInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<RaceActivityInfo> list = new List<RaceActivityInfo>();
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
                    RaceActivityInfo item = new RaceActivityInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.idRoadStyle = Int32.Parse(sr["idRoadStyle"].ToString());
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.dOpen = DateTime.Parse(sr["dOpen"].ToString());
                    item.dJoinBegin = DateTime.Parse(sr["dJoinBegin"].ToString());
                    item.dJoinEnd = DateTime.Parse(sr["dJoinEnd"].ToString());
                    item.iDistance = Int32.Parse(sr["iDistance"].ToString());
                    item.iFee =Int32.Parse(sr["iFee"].ToString());
                    item.iWinner =Int32.Parse(sr["iWinner"].ToString());
                    item.iStatus =Int32.Parse(sr["iStatus"].ToString());
                    item.iLimit = Int32.Parse(sr["iLimit"].ToString());
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
