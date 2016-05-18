
using System;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Generic;

namespace ERUN360.Entity
{
    public class AdminInfo
    {
        public int id = 0;
        public int idMemberStyle = 0;
        /// <summary>
        /// �༭
        /// </summary>
        public bool IsEditor
        {
            get { return (idMemberStyle == 11); }
        }
        /// <summary>
        /// �ܱ�
        /// </summary>
        public bool IsChief
        {
            get { return (idMemberStyle == 12); }
        }
        /// <summary>
        /// ��Ϣ����Ա
        /// </summary>
        public bool IsAdmin
        {
            get { return (idMemberStyle >= 13); }
        }
        /// <summary>
        /// ��������Ա
        /// </summary>
        public bool IsSuper
        {
            get { return (idMemberStyle == 99); }
        }
    }

    public static class Admin
    {
        private static Hashtable hash = null;
        private static string cacheName = "CACHE_OF_ADMIN_USER";

        /// <summary>
        /// ��ϣ��ʽ���ٲ��������û�
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static AdminInfo Find()
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
            }

            Member m = new Member();
            if (m.Default == null) return null;
            int id = m.Default.id;

            if (hash[id.ToString()] != null)
            {
                return (AdminInfo)hash[id.ToString()];
            }
            else
            {
                MemberInfo n = m.Load(id, "", "");
                if (n != null)
                {
                    if (n.idMemberStyle > 10 && n.idMemberStyle <100)
                    {
                        AdminInfo u = new AdminInfo();
                        u.id = n.id;
                        u.idMemberStyle = n.idMemberStyle;
                        hash.Add(id.ToString(), u);
                        TCache.Save(cacheName, hash);
                        return u;
                    }
                }
            }
            return null;
        }

        public static void Modify(int id)
        {
            hash = (Hashtable)TCache.Load(cacheName);
            if (hash == null)
            {
                hash = new Hashtable();
            }

            hash.Remove(id.ToString());
        }

        public static bool IsAdmin()
        {
            AdminInfo u = Find();
            if (u == null) return false;
            return u.IsAdmin;
        }

        public static bool IsSuper()
        {
            AdminInfo u = Find();
            if (u == null) return false;
            return u.IsSuper;
        }
    }
}
