
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class RaceClubInfo
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
        // �û�ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // ��¼��
        private string _cLoginName = String.Empty;
        public string cLoginName
        {
            get { return _cLoginName; }
            set { _cLoginName = XString.SqlSafe((string)value); }
        }
        // ����ID
        private int _idCity = 0;
        public int idCity
        {
            get { return _idCity; }
            set { _idCity = (int)value; }
        }
        // ���ڳ���
        private string _cCityname = String.Empty;
        public string cCityname
        {
            get { return _cCityname; }
            set { _cCityname = XString.SqlSafe((string)value); }
        }
        // ���ֲ�����
        private string _cTitle = String.Empty;
        public string cTitle
        {
            get { return _cTitle; }
            set { _cTitle = XString.SqlSafe((string)value); }
        }
        // ���ֲ����
        private string _cDescription = String.Empty;
        public string cDescription
        {
            get { return _cDescription; }
            set { _cDescription = XString.SqlSafe((string)value); }
        }
        // ��Ա��������
        private int _iMemberLimit = 0;
        public int iMemberLimit
        {
            get { return _iMemberLimit; }
            set { _iMemberLimit = (int)value; }
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

    public class RaceClub : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_4].[dbo].[tblRACE_CLUB]";

        public RaceClub() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">RaceClubInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(RaceClubInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("DECLARE @last_index int;");
            // @@@@@@@@@@@@@@@@@@@@@@
            // ÿ���û���������һ�����ֲ�
            sql.AppendLine("if exists(SELECT * FROM " + Database + " WHERE idUser=" + item.idUser + ")");
            sql.AppendLine("begin");
            sql.AppendLine("SELECT @last_index = -1;");
            sql.AppendLine("SELECT @last_index;");
            sql.AppendLine("return;");
            sql.AppendLine("end");
            // @@@@@@@@@@@@@@@@@@@@@@
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idBlog,idUser,cLoginName,idCity,cCityname,cTitle,cDescription,iMemberLimit) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idBlog.ToString() + "',");
            _s.Append("'" + item.idUser.ToString() + "',");
            _s.Append("'" + item.cLoginName.ToString() + "',");
            _s.Append("'" + item.idCity.ToString() + "',");
            _s.Append("'" + item.cCityname.ToString() + "',");
            _s.Append("'" + item.cTitle.ToString() + "',");
            _s.Append("'" + item.cDescription.ToString() + "',");
            _s.Append("'" + item.iMemberLimit.ToString() + "',");
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
        /// <param name="item">RaceClubInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(RaceClubInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("cLoginName='" + item.cLoginName.ToString() + "',");
            _s.Append("idCity='" + item.idCity.ToString() + "',");
            _s.Append("cCityname='" + item.cCityname.ToString() + "',");
            _s.Append("cTitle='" + item.cTitle.ToString() + "',");
            _s.Append("cDescription='" + item.cDescription.ToString() + "',");
            _s.Append("iMemberLimit='" + item.iMemberLimit.ToString() + "',");
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
        /// <param name="item">RaceClubInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(RaceClubInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">RaceClubInfo</param>
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
        /// <return>RaceClubInfo</return>
        public RaceClubInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            RaceClubInfo item = null;
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
                    item = new RaceClubInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.cTitle = sr["cTitle"].ToString();
                    item.cDescription = sr["cDescription"].ToString();
                    item.iMemberLimit = Int32.Parse(sr["iMemberLimit"].ToString());
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
        /// <return>RaceClubInfo List</return>
        public List<RaceClubInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<RaceClubInfo> list = new List<RaceClubInfo>();
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
                    RaceClubInfo item = new RaceClubInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idBlog = Int32.Parse(sr["idBlog"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.cTitle = sr["cTitle"].ToString();
                    item.cDescription = sr["cDescription"].ToString();
                    item.iMemberLimit = Int32.Parse(sr["iMemberLimit"].ToString());
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
