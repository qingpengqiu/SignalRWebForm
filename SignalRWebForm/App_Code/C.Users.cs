
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    /// <summary>
    /// 内存数据库－在线用户信息
    /// </summary>
    public class UserInfo
    {
        public int id = 0;
        public int idMemberStyle = 0;
        public string cLoginName = "";
        public string cPassword = "";
        public int idGender = 0;
        public string cAvatar = HostInfo.imgName+@"/images/noname.gif";
        public string cBio = "";
        public string cNickName = "";

        public int iLoginTimes = 0;
        public int iBlogCount = 0;
        public int iBlogLevel = 0;
        public int iScore = 0;
        public int iWorks = 0;
        public int iFans = 0;
        public double fMoney = 0.0;

        public int iFocus = 0;
        public int iDiscuss = 0;
        public int iNotes = 0;
        public int iFace = 0;

        public string cMail = "";
        public string cMobile = "";
        public string cCityname = "";

        //public DateTime dLastLogin = DateTime.Now;
        public DateTime dCreate = DateTime.Now;
    }

    public static class Users
    {
        private static Hashtable hash = null;
        private static string cacheName = "CACHE_OF_ONLINE_USER";

        //private static Hashtable nick = null;
        //private static string cacheNick = "CACHE_OF_ONLINE_NICK";

        /// <summary>
        /// 哈希方式快速查找在线用户
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static UserInfo Find(int id)
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
            }

            //nick = (Hashtable)TCache.Load(cacheNick);
            //if (nick == null)
            //{
            //    nick = new Hashtable();
            //}

            if (hash[id.ToString()] != null)
            {
                return (UserInfo)hash[id.ToString()];
            }
            else
            {
                UserInfo u = new UserInfo();

                Member m = new Member();
                MemberInfo n = m.Load(id, "", "");
                if (n != null)
                {
                    u.id = n.id;
                    u.idMemberStyle = n.idMemberStyle;
                    u.cLoginName = n.cLoginName;
                    u.cPassword = n.cPassword;
                    u.idGender = n.idGender;
                    u.cAvatar = n.cAvatar;
                    u.cBio = n.cBio;

                    u.cNickName = n.cNickName;

                    u.cMail = n.cMail;
                    u.cMobile = n.cMobile;
                    u.cCityname = n.cCityname;

                    u.dCreate = n.dCreate;
                }

                MemberSummary summary = new MemberSummary();
                MemberSummaryInfo s = summary.Load(id, "", "");
                if (s != null)
                {
                    u.iLoginTimes = s.iLoginTimes;
                    u.iBlogCount = s.iBlogCount;
                    u.iBlogLevel = s.iBlogLevel;
                    u.iScore = s.iScore;
                    u.iWorks = s.iWorks;
                    u.iFans = s.iFans;
                    u.fMoney = s.fMoney;
                    u.iFocus = s.iFocus;
                    u.iDiscuss = s.iDiscuss;
                    u.iNotes = s.iNotes;
                    u.iFace = s.iFace;
                }

                hash.Add(id.ToString(), u);
                TCache.Save(cacheName, hash);

                // 会有重复
                //if (nick[u.cLoginName.ToLower()] != null)
                //{
                //    nick.Remove(u.cLoginName.ToLower());
                //}
                //nick.Add(u.cLoginName.ToLower(), u);
                //TCache.Save(cacheNick, nick);

                return u;
            }
        }
        /*
        public static UserInfo QuickLogin(string cLoginName, string cPassword)
        {
            if (nick == null)
            {
                nick = new Hashtable();
            }
            if (nick[cLoginName.ToLower()] != null)
            {
                UserInfo u = (UserInfo)nick[cLoginName.ToLower()];
                if (u.cPassword == XString.MD5(cPassword.ToLower()))
                {
                    return u;
                }
            }
            return null;
        }
        */
        public static void Modify(int id)
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
            }
            if (hash[id.ToString()] != null)
            {
                hash.Remove(id.ToString());
                Find(id);
            }
        }

        public static int FindByName(string login)
        {
            List<UserInfo> list = new List<UserInfo>();
            IDictionaryEnumerator en = hash.GetEnumerator();
            while (en.MoveNext())
            {
                UserInfo wc = (UserInfo)en.Value;
                list.Add(wc);
            }

            foreach (UserInfo au in list)
            {
                if (au.cLoginName.ToLower() == login.ToLower())
                {
                    return au.id;
                }
            }
            return 0;
        }

        public static void Password(int id, string p)
        {
            UserInfo u = Find(id);
            if (u != null) u.cPassword = p;
        }

        public static void Avatar(int id, string img)
        {
            UserInfo u = Find(id);
            if (u != null) u.cAvatar = img;
        }

        public static void LoginTimes(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iLoginTimes += v;
        }

        public static void Score(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iScore += v;
        }

        public static void Fans(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iFans += v;
        }

        public static void Blogs(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iBlogCount += v;
        }

        public static void Focus(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iFocus += v;
        }

        public static void Discuss(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iDiscuss += v;
        }

        public static void Notes(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iNotes += v;
        }

        public static void Face(int id, int v)
        {
            UserInfo u = Find(id);
            if (u != null) u.iFace = v;
        }
    }

    public static class Prison
    {
        private static Hashtable hash = null;
        private static string cacheName = "CACHE_OF_PRISON_USER";

        public static bool Find(int id)
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
                int page_count = 0;
                Member m = new Member();
                List<MemberInfo> list = m.PageList(1, 1000, "WHERE idMemberStyle<0", "ORDER BY id DESC", out page_count);
                foreach (MemberInfo u in list)
                {
                    hash.Add(u.id.ToString(), u.id.ToString());
                }

                TCache.Save(cacheName, hash);
            }

            if (hash[id.ToString()] != null)
            {
                return true;
            }

            return false;
        }

        public static void Modify(int id)
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
            }
            if (hash[id.ToString()] != null)
            {
                hash.Remove(id.ToString());
            }
        }
    }
}
