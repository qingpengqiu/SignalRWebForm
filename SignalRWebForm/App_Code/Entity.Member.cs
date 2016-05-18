
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    #region ����ʵ����

    public class MemberInfo
    {
        // ���
        private int _id = 0;
        public int id
        {
            get { return _id; }
            set { _id = (int)value; }
        }
        // ��Ա����
        private int _idMemberStyle = 0;
        public int idMemberStyle
        {
            get { return _idMemberStyle; }
            set { _idMemberStyle = (int)value; }
        }
        // ��¼��
        private string _cLoginName = String.Empty;
        public string cLoginName
        {
            get { return _cLoginName; }
            set { _cLoginName = XString.SqlSafe((string)value); }
        }
        // ����
        private string _cPassword = String.Empty;
        public string cPassword
        {
            //get { return XString.MD5(_cPassword.ToString().ToLower()); }
            get { return _cPassword.ToLower(); }
            set { _cPassword = XString.SqlSafe((string)value).ToLower(); }
        }
        //public string cPasswordOrig
        //{
        //   get { return _cPassword.ToString().ToLower(); }
        //}
        // �Ա�
        private int _idGender = 0;
        public int idGender
        {
            get { return _idGender; }
            set { _idGender = (int)value; }
        }
        // ��������
        private DateTime _dBirthday = System.DateTime.Now;
        public DateTime dBirthday
        {
            get { return _dBirthday; }
            set { _dBirthday = (DateTime)value; }
        }
        // ͷ��URL
        private string _cAvatar = "/images/noname.gif";
        public string cAvatar
        {
            get { return _cAvatar; }
            set { _cAvatar = XString.SqlSafe((string)value); }
        }
        // ���
        private string _cBio = String.Empty;
        public string cBio
        {
            get { return _cBio; }
            set { _cBio = XString.SqlSafe((string)value); }
        }
        // ����
        private string _cName = String.Empty;
        public string cName
        {
            get { return _cName; }
            set { _cName = XString.SqlSafe((string)value); }
        }
        // ֤������
        private int _idNationIdType = 0;
        public int idNationIdType
        {
            get { return _idNationIdType; }
            set { _idNationIdType = (int)value; }
        }
        // ֤������
        private string _cNationID = String.Empty;
        public string cNationID
        {
            get { return _cNationID; }
            set { _cNationID = XString.SqlSafe((string)value); }
        }
        // �ֻ�
        private string _cMobile = String.Empty;
        public string cMobile
        {
            get { return _cMobile; }
            set { _cMobile = XString.SqlSafe((string)value); }
        }
        // ����
        private string _cMail = String.Empty;
        public string cMail
        {
            get { return _cMail; }
            set { _cMail = XString.SqlSafe((string)value); }
        }
        // �ʱ�
        private string _cZipcode = String.Empty;
        public string cZipcode
        {
            get { return _cZipcode; }
            set { _cZipcode = XString.SqlSafe((string)value); }
        }
        // ��ַ
        private string _cAddress = String.Empty;
        public string cAddress
        {
            get { return _cAddress; }
            set { _cAddress = XString.SqlSafe((string)value); }
        }
        // ���б���
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
        // Ѫ��
        private int _idBlood = 0;
        public int idBlood
        {
            get { return _idBlood; }
            set { _idBlood = (int)value; }
        }
        // ְҵ
        private int _idOccupation = 0;
        public int idOccupation
        {
            get { return _idOccupation; }
            set { _idOccupation = (int)value; }
        }
        // ���ѧ��
        private int _idEducation = 0;
        public int idEducation
        {
            get { return _idEducation; }
            set { _idEducation = (int)value; }
        }
        // ��Ȥ����
        private string _cInterests = String.Empty;
        public string cInterests
        {
            get { return _cInterests; }
            set { _cInterests = XString.SqlSafe((string)value); }
        }
        // ������ϵ��ʽ
        private string _cEmergerContact = String.Empty;
        public string cEmergerContact
        {
            get { return _cEmergerContact; }
            set { _cEmergerContact = XString.SqlSafe((string)value); }
        }
        // ��������
        private int _idQuestion = 0;
        public int idQuestion
        {
            get { return _idQuestion; }
            set { _idQuestion = (int)value; }
        }
        // ���������
        private string _cAnswer = String.Empty;
        public string cAnswer
        {
            get { return _cAnswer.ToLower(); }
            set { _cAnswer = XString.SqlSafe((string)value).ToLower(); }
        }
        //public string cAnswerOrig
        //{
        //   get { return _cAnswer.ToString().ToLower(); }
        //}
        // ����ʱ��
        private DateTime _dCreate = System.DateTime.Now;
        public DateTime dCreate
        {
            get { return _dCreate; }
            set { _dCreate = (DateTime)value; }
        }

        // ����
        private string _cNickName = String.Empty;
        public string cNickName
        {
            get { return _cNickName; }
            set { _cNickName = XString.SqlSafe((string)value); }
        }
    }

    #endregion

    public partial class Member : SQLHelper
    {
        // ������Ϣ
        public string _err = String.Empty;
        // ������Ϣ
        public string _sql = String.Empty;
        // ��ҳ��ѯ���ҳ��
        public int _MAX_PAGE_NUMBER = 200;
        // ���ݿ�.��.����
        private static string Database = "[YP_DB_1].[dbo].[tblMEMBER]";

        //public Member() { }

        #region ���ݲ���ϵ�к���

        /// <summary>
        /// ������¼
        /// </summary>
        /// <param name="item">MemberInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Insert(MemberInfo item, out int index)
        {
            index = 0;
            StringBuilder sql = new StringBuilder();
            sql.Append("DECLARE @last_index int;");
            sql.Append("INSERT INTO " + Database + " ");
            sql.Append("(idMemberStyle,cLoginName,iChecksum,cPassword,idGender,dBirthday,cAvatar,cBio,cName,idNationIdType,cNationID,cMobile,cMail,cZipcode,cAddress,idCity,cCityname,idBlood,idOccupation,idEducation,cInterests,cEmergerContact,idQuestion,cAnswer,cNickName) ");
            sql.Append("VALUES (");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("'" + item.idMemberStyle.ToString() + "',");
            _s.Append("'" + item.cLoginName.ToString() + "',");
            _s.Append("CHECKSUM('" + item.cLoginName.ToString().ToLower() + "'),");
            _s.Append("'" + XString.MD5(item.cPassword) + "',");
            _s.Append("'" + item.idGender.ToString() + "',");
            _s.Append("'" + item.dBirthday.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("'" + item.cAvatar.ToString() + "',");
            _s.Append("'" + item.cBio.ToString() + "',");
            _s.Append("'" + item.cName.ToString() + "',");
            _s.Append("'" + item.idNationIdType.ToString() + "',");
            _s.Append("'" + item.cNationID.ToString() + "',");
            _s.Append("'" + item.cMobile.ToString() + "',");
            _s.Append("'" + item.cMail.ToString() + "',");
            _s.Append("'" + item.cZipcode.ToString() + "',");
            _s.Append("'" + item.cAddress.ToString() + "',");
            _s.Append("'" + item.idCity.ToString() + "',");
            _s.Append("'" + item.cCityname.ToString() + "',");
            _s.Append("'" + item.idBlood.ToString() + "',");
            _s.Append("'" + item.idOccupation.ToString() + "',");
            _s.Append("'" + item.idEducation.ToString() + "',");
            _s.Append("'" + item.cInterests.ToString() + "',");
            _s.Append("'" + item.cEmergerContact.ToString() + "',");
            _s.Append("'" + item.idQuestion.ToString() + "',");
            _s.Append("'" + XString.MD5(item.cAnswer) + "',");
            _s.Append("'" + item.cName.ToString() + "',");
            sql.Append(XString.UnTail(_s.ToString()));
            sql.Append(");");
            sql.Append("SELECT @last_index = @@IDENTITY;");
            sql.Append("INSERT INTO [YP_DB_1].[dbo].[tblMEMBER_SIZE] (idUser) VALUES(@last_index);");
            sql.Append("INSERT INTO [YP_DB_1].[dbo].[tblMEMBER_SUMMARY] (idUser) VALUES(@last_index);");
            sql.Append("INSERT INTO [YP_DB_2].[dbo].[tblBLOG_GROUP] (idUser,cTitle,iChecksum) VALUES(@last_index,'δ����',CHECKSUM('δ����'));");
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
        /// <param name="item">MemberInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool Update(MemberInfo item)
        {
            if (item == null) { _err = "item is null"; return false; }
            if (item.id <= 0) { _err = "item.id <= 0"; return false; }
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE " + Database + " SET ");
            // ������ֵ������
            StringBuilder _s = new StringBuilder();
            _s.Append("idMemberStyle='" + item.idMemberStyle.ToString() + "',");
            _s.Append("cLoginName='" + item.cLoginName.ToString() + "',");
            _s.Append("iChecksum=CHECKSUM('" + item.cLoginName.ToString().ToLower() + "'),");
            _s.Append("cPassword='" + item.cPassword.ToString() + "',");
            _s.Append("idGender='" + item.idGender.ToString() + "',");
            _s.Append("dBirthday='" + item.dBirthday.ToString("yyyy-MM-dd HH:mm:ss") + "',");
            _s.Append("cAvatar='" + item.cAvatar.ToString() + "',");
            _s.Append("cBio='" + item.cBio.ToString() + "',");
            _s.Append("cName='" + item.cName.ToString() + "',");
            _s.Append("idNationIdType='" + item.idNationIdType.ToString() + "',");
            _s.Append("cNationID='" + item.cNationID.ToString() + "',");
            _s.Append("cMobile='" + item.cMobile.ToString() + "',");
            _s.Append("cMail='" + item.cMail.ToString() + "',");
            _s.Append("cZipcode='" + item.cZipcode.ToString() + "',");
            _s.Append("cAddress='" + item.cAddress.ToString() + "',");
            _s.Append("idCity='" + item.idCity.ToString() + "',");
            _s.Append("cCityname='" + item.cCityname.ToString() + "',");
            _s.Append("idBlood='" + item.idBlood.ToString() + "',");
            _s.Append("idOccupation='" + item.idOccupation.ToString() + "',");
            _s.Append("idEducation='" + item.idEducation.ToString() + "',");
            _s.Append("cInterests='" + item.cInterests.ToString() + "',");
            _s.Append("cEmergerContact='" + item.cEmergerContact.ToString() + "',");
            _s.Append("idQuestion='" + item.idQuestion.ToString() + "',");
            _s.Append("cAnswer='" + item.cAnswer.ToString() + "',");
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
        /// <param name="item">MemberInfo</param>
        /// <return>�ɹ�����true��ʧ�ܷ���false</return>
        public bool UpdateBy(MemberInfo item, string fieldName, string fieldValue)
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
        /// <param name="item">MemberInfo</param>
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
        /// ��ȡ��¼
        /// </summary>
        /// <param name="id"></param>
        /// <return>MemberInfo</return>
        public MemberInfo Load(int local_id, string fieldName, string fieldValue)
        {
            if (local_id <= 0) { _err = "local_id <= 0"; return null; }
            MemberInfo item = null;
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
                    item = new MemberInfo();
                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idMemberStyle = Int32.Parse(sr["idMemberStyle"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cPassword = sr["cPassword"].ToString();
                    item.idGender = Int32.Parse(sr["idGender"].ToString());
                    item.dBirthday = DateTime.Parse(sr["dBirthday"].ToString());
                    item.cAvatar = sr["cAvatar"].ToString();
                    item.cBio = sr["cBio"].ToString();
                    item.cName = sr["cName"].ToString();
                    item.idNationIdType = Int32.Parse(sr["idNationIdType"].ToString());
                    item.cNationID = sr["cNationID"].ToString();
                    item.cMobile = sr["cMobile"].ToString();
                    item.cMail = sr["cMail"].ToString();
                    item.cZipcode = sr["cZipcode"].ToString();
                    item.cAddress = sr["cAddress"].ToString();
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.idBlood = Int32.Parse(sr["idBlood"].ToString());
                    item.idOccupation = Int32.Parse(sr["idOccupation"].ToString());
                    item.idEducation = Int32.Parse(sr["idEducation"].ToString());
                    item.cInterests = sr["cInterests"].ToString();
                    item.cEmergerContact = sr["cEmergerContact"].ToString();
                    item.idQuestion = Int32.Parse(sr["idQuestion"].ToString());
                    item.cAnswer = sr["cAnswer"].ToString();
                    item.dCreate = DateTime.Parse(sr["dCreate"].ToString());
                    item.cNickName = sr["cNickName"].ToString();
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
        /// <return>MemberInfo List</return>
        public List<MemberInfo> PageList(int pageIndex, int pageSize, string conditionString, string orderString, out int pageCount)
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

            List<MemberInfo> list = new List<MemberInfo>();
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
                    MemberInfo item = new MemberInfo();

                    item.id = Int32.Parse(sr["id"].ToString());
                    item.idMemberStyle = Int32.Parse(sr["idMemberStyle"].ToString());
                    item.cLoginName = sr["cLoginName"].ToString();
                    item.cPassword = sr["cPassword"].ToString();
                    item.idGender = Int32.Parse(sr["idGender"].ToString());
                    item.dBirthday = DateTime.Parse(sr["dBirthday"].ToString());
                    item.cAvatar = sr["cAvatar"].ToString();
                    item.cBio = sr["cBio"].ToString();
                    item.cName = sr["cName"].ToString();
                    item.idNationIdType = Int32.Parse(sr["idNationIdType"].ToString());
                    item.cNationID = sr["cNationID"].ToString();
                    item.cMobile = sr["cMobile"].ToString();
                    item.cMail = sr["cMail"].ToString();
                    item.cZipcode = sr["cZipcode"].ToString();
                    item.cAddress = sr["cAddress"].ToString();
                    item.idCity = Int32.Parse(sr["idCity"].ToString());
                    item.cCityname = sr["cCityname"].ToString();
                    item.idBlood = Int32.Parse(sr["idBlood"].ToString());
                    item.idOccupation = Int32.Parse(sr["idOccupation"].ToString());
                    item.idEducation = Int32.Parse(sr["idEducation"].ToString());
                    item.cInterests = sr["cInterests"].ToString();
                    item.cEmergerContact = sr["cEmergerContact"].ToString();
                    if (sr["idQuestion"].ToString() != "")
                    {
                        item.idQuestion = Convert.ToInt32(sr["idQuestion"].ToString());
                    }
                    else
                    {
                        item.idQuestion = 0;
                    }
                    item.cAnswer = sr["cAnswer"].ToString();
                    item.dCreate = DateTime.Parse(sr["dCreate"].ToString());

                    list.Add(item);
                }
                sr.Close();
            }
            catch (Exception ex) { _err += ex.Message; return null; }
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
