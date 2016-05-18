
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Net;

namespace ERUN360.Entity
{
    public partial class Member : SQLHelper
    {
        private static string session_id = "SESSION_OF_ERUN360";

        private static string cookies_id = "COOKIES_OF_ERUN360";
        private static string cookies_id_p1 = "COOKIES_OF_ERUN360_ID";
        private static string cookies_id_p3 = "COOKIES_OF_ERUN360_ID_CERT";
        private static string cookies_domain = "ERUN360.COM";

        public MemberInfo Default = null;

        public Member()
        {
            if (SessionExist() == false)
            {
                CookiesLoad();
            }
            else
            {
                SessionLoad();
            }
        }

        /// <summary>   
        /// 用户登录  
        /// </summary>   
        /// <returns></returns> 
        public void Login(string cLoginName, string cPassword)
        {
            int page_count = 0;
            List<MemberInfo> finds = PageList(1, 10, "WHERE idMemberStyle>=0 and iChecksum=CHECKSUM('" + XString.SqlSafe(cLoginName.ToLower()) + "')", "ORDER BY id DESC", out page_count);
            if (page_count == 0)
            {
                _err = "no result";
                return;
            }
            foreach (MemberInfo m in finds)
            {
                if (String.Compare(m.cPassword, XString.MD5(cPassword.ToLower())) == 0)
                {
                    Default = new MemberInfo();
                    Default.id = m.id;
                    Default.cLoginName = m.cLoginName;

                    SessionSave();
                    CookiesSave();
                    return;
                }
            }
        }

        /// <summary>
        /// 按编号与登录名自动登录
        /// </summary>
        /// <param name="id"></param>
        /// <param name="cNickname"></param>
        public void Login(int id, string cNickname)
        {
            Default = new MemberInfo();
            Default.id = id;
            Default.cLoginName = cNickname;

            SessionSave();
            CookiesSave();
        }

        /// <summary>
        /// 退出登录
        /// </summary>
        public void Logout()
        {
            SessionClear();
            CookiesClear();
            Default = null;
        }

        /// <summary>
        /// 是否存在 Session
        /// </summary>
        /// <returns></returns>
        private bool SessionExist()
        {
            return (HttpContext.Current.Session[session_id] != null) ? true : false;
        }

        /// <summary>
        /// 保存Session信息(DES加密)
        /// </summary>
        private void SessionSave()
        {
            if (Default == null) return;
            HttpContext.Current.Session[session_id] = Default.id.ToString() + " " + Default.cLoginName.ToLower();
        }

        /// <summary>
        /// 读取加密的 Session 信息
        /// </summary>
        private void SessionLoad()
        {
            if (SessionExist())
            {
                try
                {
                    string sv = HttpContext.Current.Session[session_id].ToString();
                    string[] sa = sv.Split(' ');
                    if (sa.Length > 1)
                    {
                        Default = new MemberInfo();
                        Default.id = Int32.Parse(sa[0]);
                        Default.cLoginName = sa[1].ToLower();

                        CookiesSave();
                    }
                }
                catch (Exception ex)
                {
                    _err = ex.Message;
                }
            }
        }

        /// <summary>
        /// 清除 Session
        /// </summary>
        private void SessionClear()
        {
            HttpContext.Current.Session[session_id] = null;
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Session.Clear();
            Default = null;
        }

        /// <summary>   
        /// 设置用户登录的 Cookies 值  
        /// </summary>   
        /// <returns></returns> 
        private void CookiesSave()
        {
            if (Default == null) return;
            if (Default.id > 0)
            {
                HttpResponse Response = HttpContext.Current.Response;

                Response.Cookies[cookies_id][cookies_id_p1] = XString.DESEncrypt(Default.id.ToString() + " " + Default.cLoginName.ToLower());
                Response.Cookies[cookies_id][cookies_id_p3] = XString.MD5(Default.id.ToString() + " " + Default.cLoginName.ToLower());
                Response.Cookies[cookies_id].Expires = DateTime.Now.AddMonths(120);
                Response.Cookies[cookies_id].Domain = cookies_domain;
                Response.Cookies[cookies_id].Secure = false;
            }
        }

        /// <summary>
        /// 清除Cookies 信息
        /// </summary>
        private void CookiesClear()
        {
            HttpResponse Response = HttpContext.Current.Response;

            // 清除新的 Cookies 信息
            Response.Cookies[cookies_id][cookies_id_p1] = "0";
            Response.Cookies[cookies_id][cookies_id_p3] = "0";
            Response.Cookies[cookies_id].Expires = DateTime.Now.AddDays(-30);

            Default = null;
        }

        /// <summary>
        /// 读取COOKIES数值并进行MD5校验
        /// </summary>
        private void CookiesLoad()
        {
            int loc_id = 0;
            string loc_loginname = "";
            string loc_cert = "";
            HttpRequest Request = HttpContext.Current.Request;

            // 读取新的 Cookies 信息
            if (Request.Cookies[cookies_id] != null)
            {
                if (Request.Cookies[cookies_id][cookies_id_p1] != null)
                {
                    string cs = XString.DESDecrypt(Request.Cookies[cookies_id][cookies_id_p1].ToString());
                    string[] ca = cs.Split(' ');
                    if (ca.Length > 1)
                    {
                        loc_id = Int32.Parse("0" + XString.PureNumber(ca[0]));
                        loc_loginname = ca[1].ToLower();
                    }
                }
                if (Request.Cookies[cookies_id][cookies_id_p3] != null)
                {
                    loc_cert = Request.Cookies[cookies_id][cookies_id_p3];
                }
                if (loc_id > 0 && loc_cert.Length > 0)
                {
                    if (loc_cert == XString.MD5(loc_id.ToString() + " " + loc_loginname))
                    {
                        Default = new MemberInfo();
                        Default.id = loc_id;
                        Default.cLoginName = loc_loginname;

                        SessionSave();
                    }
                }
            }
        }

        /// <summary>
        /// 密码查询
        /// </summary>
        /// <param name="id"></param>
        /// <return>MemberInfo</return>
        public int Query(string idGender, string cName, string dBirthday, string cAnswer)
        {
            DateTime d1 = DateTime.Parse(dBirthday + " 00:00:00");
            d1 = d1.AddSeconds(-1);
            DateTime d2 = d1.AddDays(1);

            string sql = "SELECT id,cLoginName,cAnswer FROM " + Database + " WHERE ";
            sql += "idGender=" + idGender + " AND ";
            sql += "cName='" + cName + "' AND ";
            sql += "(dBirthday BETWEEN '" + d1.ToString("yyyy-MM-dd HH:mm:ss") + "' AND '" + d2.ToString("yyyy-MM-dd HH:mm:ss") + "')";
            _sql = sql.ToString();
            int index = 0;
            string cLoginName = "";
            try
            {
                SqlDataReader sr = SQLHelper.ExecuteReader(sql);
                while (sr.Read())
                {
                    if (XString.MD5(cAnswer) == sr["cAnswer"].ToString())
                    {
                        index = (int)sr["id"];
                        cLoginName = sr["cLoginName"].ToString();
                        break;
                    }
                    else
                    {
                        _err += "not matched ";
                    }
                }
                sr.Close();
            }
            catch (Exception ex) { _err = ex.Message; return 0; }

            if (index > 0)
            {
                Login(index, cLoginName);
            }

            return index;
        }
    }
}
