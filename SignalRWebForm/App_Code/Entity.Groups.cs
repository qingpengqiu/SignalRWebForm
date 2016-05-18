
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class GroupsInfo
    {
        // ����
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ״̬
        private int _iStatus = 1;
        public int iStatus
        {
            get { return _iStatus; }
            set { _iStatus = (int)value; }
        }
        // ����
        private int _iScore = 0;
        public int iScore
        {
            get { return _iScore; }
            set { _iScore = (int)value; }
        }
        // ��������
        private string _cTitle = String.Empty;
        public string cTitle
        {
            get { return _cTitle; }
            set { _cTitle = XString.SqlSafe((string)value); }
        }
        // ��ע
        private string _cDescription = String.Empty;
        public string cDescription
        {
            get { return _cDescription; }
            set { _cDescription = XString.SqlSafe((string)value); }
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

    public partial class Groups : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_1].[dbo].[tblGROUPS]";
        // �б�.����
        private static string cacheList = "CACHE_OF_GROUPS";
        private List<GroupsInfo> Items = null;
        // ��ϣ.����
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

        #region ���ݲ���ϵ�к���

		/// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(GroupsInfo item)
        {
            //index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(id,iScore,cTitle,cDescription) ");
            sql.Append("VALUES (");
            // ������ֵ������
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

            // �������
            CacheClear();
            return true;
        }


        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        private string InsertSql(GroupsInfo item)
        {
            //index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(id,iScore,cTitle,cDescription) ");
            sql.Append("VALUES (");
            // ������ֵ������
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
        /// �޸ļ�¼(NORMAL)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(GroupsInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
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

            // �������
            CacheClear();
            return true;
        }
        
        /// <summary>
        /// �޸ļ�¼(BY FIELD)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
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

            // �������
            CacheClear();
            return true;
        }

        /// <summary>
        /// �޸ļ�¼(BY COMMAND)
        /// </summary>
        /// <param name="item">GroupsInfo</param>
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

            // �������
            CacheClear();
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

            // �������
            CacheClear();
            return true;
        }

        /// <summary>
        /// ��ȡ��¼
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
        /// <return>GroupsInfo List</return>
        public List<GroupsInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<GroupsInfo> list = new List<GroupsInfo>();
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

        /// <summary>
        /// ����Ų�ѯ
        /// </summary>
        /// <param name="recordIndex">���</param>
        /// <return>GroupsInfo result</return>
        public GroupsInfo Find(int id)
        {
            // ��ϣ��ѯ
            if (hash == null) CacheInitialize();
            if (hash == null) return null;
            return (GroupsInfo)hash[id.ToString()];
        }

        public string FindTitle(int id)
        {
            // ��ϣ��ѯ
            if (hash == null) CacheInitialize();
            if (hash == null) return "";
            GroupsInfo gp = (GroupsInfo)hash[id.ToString()];
            if (gp == null) return "";
            return gp.cTitle;
        }

    }
}
