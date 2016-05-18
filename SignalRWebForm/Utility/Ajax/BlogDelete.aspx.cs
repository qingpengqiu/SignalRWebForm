using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Ajax_BlogDelete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region ���ȷ��
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("��δע��");
            return;
        }
        #endregion

        int recordIndex = 0;
        if (Request.QueryString["id"] != null)
        {
            try
            {
                recordIndex = Int32.Parse(XString.PureNumber(Request.QueryString["id"].ToString()));
            }
            catch (Exception ex)
            {
                Response.Write("���(id)����[" + ex.Message + "]��");
                return;
            }
        }
        else
        {
            Response.Write("���ݴ���(Querystring is null)��");
            return;
        }

        // ��֤��У��
        string checksum = "";
        if (Request.QueryString["checksum"] != null)
        {
            checksum = Request.QueryString["checksum"].ToString().ToLower();
        }
        else
        {
            Response.Write("��֤�����(checksum is null)��");
            return;
        }
        if (String.Compare(checksum, XString.MD5(recordIndex.ToString()), true) != 0)
        {
            Response.Write("��֤�����(checksum is error)��");
            return;
        }

        if (recordIndex <= 0)
        {
            Response.Write("��Ŵ���(id error)��");
            return;
        }

        // ��ȡ����(id)
        Blog table = new Blog();
        BlogInfo record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            Response.Write("���ݴ���(Index error)��");
            return;
        }

        if (record.idUser != m.Default.id)
        {
            Response.Write("������Ĳ��ͣ�");
            return;
        }

        if (table.Delete(recordIndex))
        {
            #region �޸�ͳ������
            MemberSummary ms = new MemberSummary();
            ms.UpdateByCommand(m.Default.id, "iBlogCount=iBlogCount-1");
            Users.Blogs(m.Default.id, -1);
            #endregion

            #region �޸Ļ���
            MemberHistory history = new MemberHistory();
            history.Insert(m.Default.id, 100800107, -1);
            #endregion

            #region �����Ӧ�ڴ����ݿ���Ϣ
            TCache.Clear("CACHE_PAGE_MEMBER_" + record.idUser);
            TCache.Clear("CACHE_PAGE_MEMBER_ME_" + record.idUser);
            CacheHelper.Clear("CACHE_RECENT_BLOGS");
            #endregion

            Response.Write("OK");
        }
        else
        {
            Response.Write("ϵͳ����" + table._err);
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:17 */
