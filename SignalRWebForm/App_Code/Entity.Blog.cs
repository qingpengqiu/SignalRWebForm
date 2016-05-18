
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class BlogInfo
    {
        // ����
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ���˷���
        private int _idPersonGroup = 0;
        public int idPersonGroup
        {
            get { return _idPersonGroup; }
            set { _idPersonGroup = (int)value; }
        }
        // ������ϢID
        private int _idHref = 0;
        public int idHref
        {
            get { return _idHref; }
            set { _idHref = (int)value; }
        }
        // �û�ID
        private int _idUser = 0;
        public int idUser
        {
            get { return _idUser; }
            set { _idUser = (int)value; }
        }
        // �û�����
        private string _cLoginName = String.Empty;
        public string cLoginName
        {
            get { return _cLoginName; }
            set { _cLoginName = XString.SqlSafe((string)value); }
        }
        // ����
        private string _cTitle = String.Empty;
        public string cTitle
        {
            get { return _cTitle; }
            set { _cTitle = XString.SqlSafe((string)value); }
        }
        // ����
        private string _cContent = String.Empty;
        public string cContent
        {
            get { return _cContent; }
            set { _cContent = XString.SqlSafe((string)value); }
        }
        // ����ʱ��
        private DateTime _dCreate = System.DateTime.Now;
        public DateTime dCreate
        {
            get { return _dCreate; }
            set { _dCreate = (DateTime)value; }
        }

        public int iShowTimes = 0;
    }

    #endregion

    public partial class Blog : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_2].[dbo].[tblBLOG]";

        public Blog() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">BlogInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(BlogInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("DECLARE @last_index int;");
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idPersonGroup,idHref,idUser,cLoginName,cTitle,cContent) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idPersonGroup.ToString() + "',");
            _s.Append("'" + item.idHref.ToString() + "',");
            _s.Append("'" + item.idUser.ToString() + "',");
            _s.Append("'" + item.cLoginName.ToString() + "',");
            _s.Append("'" + item.cTitle.ToString() + "',");
            _s.Append("'" + item.cContent.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(");");
            sql.Append("SELECT @last_index = @@IDENTITY;");
            sql.Append("INSERT INTO [YP_DB_2].[dbo].[tblBLOG_SUMMARY] (idBlog,idUserLast) VALUES(@last_index," + item.idUser.ToString() + ");");
            if (item.idPersonGroup > 0)
            {
                sql.Append("UPDATE [YP_DB_2].[dbo].[tblBLOG_GROUP] SET iNumber=iNumber+1 WHERE id=" + item.idPersonGroup + ";");
            }
            sql.Append("UPDATE [YP_DB_1].[dbo].[tblMEMBER_SUMMARY] SET iBlogCount=iBlogCount+1 WHERE idUser=" + item.idUser + ";");
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
        /// <param name="item">BlogInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(BlogInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idPersonGroup='" + item.idPersonGroup.ToString() + "',");
            _s.Append("idHref='" + item.idHref.ToString() + "',");
            _s.Append("idUser='" + item.idUser.ToString() + "',");
            _s.Append("cLoginName='" + item.cLoginName.ToString() + "',");
            _s.Append("cTitle='" + item.cTitle.ToString() + "',");
            _s.Append("cContent='" + item.cContent.ToString() + "',");
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
        /// <param name="item">BlogInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(BlogInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">BlogInfo</param>
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
            StringBuilder sql = new StringBuilder();
            sql.Append("DELETE FROM " + Database + " WHERE id=" + local_id + ";");
            sql.Append("DELETE FROM [YP_DB_4].[dbo].[tblRACE_COMPETETION] WHERE idBlog=" + local_id + ";");
            sql.Append("DELETE FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY] WHERE idBlog=" + local_id + ";");
            sql.Append("DELETE FROM [YP_DB_4].[dbo].[tblRACE_CLUB] WHERE idBlog=" + local_id + ";");
            sql.Append("DELETE FROM [YP_DB_5].[dbo].[tblPRODUCTS] WHERE idBlog=" + local_id + ";");
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
        public bool DeleteOfUser(int local_iduser)
        {
            if (local_iduser <= 0) { _err = "local_iduser<= 0"; return false; }
            string sql = "";
            sql += "DELETE FROM " + Database + " ";
            sql += "WHERE idUser=" + local_iduser;
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
        /// <return>BlogInfo</return>
        public BlogInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            BlogInfo item = null;
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
                    item = new BlogInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idPersonGroup = Int32.Parse(sr["idPersonGroup"].ToString());
                    item.idHref = Int32.Parse(sr["idHref"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cTitle = sr["cTitle"].ToString();
                    item.cContent = sr["cContent"].ToString();
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
        /// <return>BlogInfo List</return>
        public List<BlogInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<BlogInfo> list = new List<BlogInfo>();
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
                    BlogInfo item = new BlogInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idPersonGroup = Int32.Parse(sr["idPersonGroup"].ToString());
                    item.idHref = Int32.Parse(sr["idHref"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cTitle = sr["cTitle"].ToString();
                    item.cContent = sr["cContent"].ToString();
                    item.dCreate = DateTime.Parse(sr["dCreate"].ToString());
                    list.Add(item);
                }
                sr.Close();
            }
            catch (Exception ex) { _err = ex.Message; return null; }
            return list;
        }
        /*
        public List<BlogInfo> ListOf()
        {
            int pc;
            BlogSummary bs = new BlogSummary();
            List<BlogSummaryInfo> slist = bs.PageList(1, 100, "", "ORDER BY iShowTimes DESC", out pc);
            if (slist == null) return null;
            StringBuilder sx = new StringBuilder();
            Hashtable hash = new Hashtable();
            foreach (BlogSummaryInfo su in slist)
            {
                sx.Append(su.idBlog + ",");
                hash.Add(su.idBlog, su.iShowTimes.ToString());
            }

            List<BlogInfo> list = new List<BlogInfo>();
            string sql = "SELECT TOP 20 a.* FROM [YP_DB_2].[dbo].[tblBLOG] AS a, [YP_DB_2].[dbo].[tblBLOG_SUMMARY] AS b WHERE b.idBlog=a.id"; // AND a.id IN (SELECT idBlog FROM [YP_DB_2].[dbo].[tblBLOG_PUBLISH]) ORDER BY b.iShowTimes DESC";
            _sql = sql;
            try
            {
                SqlDataReader sr = SQLHelper.ExecuteReader(sql);
                while (sr.Read())
                {
                    BlogInfo item = new BlogInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idPersonGroup = Int32.Parse(sr["idPersonGroup"].ToString());
                    item.idHref = Int32.Parse(sr["idHref"].ToString());
                    item.idUser = Int32.Parse(sr["idUser"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cTitle = sr["cTitle"].ToString();
                    item.cContent = sr["cContent"].ToString();
                    item.dCreate = DateTime.Parse(sr["dCreate"].ToString());
                    list.Add(item);
                }
                sr.Close();
            }
            catch (Exception ex) { _err = ex.Message; return null; }
            return list;
        }
        */
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
