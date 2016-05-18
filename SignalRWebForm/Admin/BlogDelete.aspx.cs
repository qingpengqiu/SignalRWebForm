using System;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Admin_Blog_Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Redirect("/admin/");
        }

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
       
        if (table.Delete(recordIndex))
        {
            #region �޸Ļ���

            string classify = record.idHref.ToString().Substring(0, 1);
            if (classify == "0")
            {
                new DB1.tblIntegral().InsertScore(record.idUser, 200810021, 1, 0);//"����";
                MemberSummary ms = new MemberSummary();
                ms.UpdateByCommand(record.idUser, "iBlogCount=iBlogCount-1");
            }
            else if (classify == "5")
            {
                new DB1.tblIntegral().InsertScore(record.idUser, 200810026, 1, 0);//"װ��";
            }
            else if (classify == "3")
            {

                //m_nav += "����";

            }
            else if (classify == "4")
            {
                new DB1.tblIntegral().InsertScore(record.idUser, 200810024, 1, 0); //"Լ��";
            }
            //MemberHistory history = new MemberHistory();
            //history.Insert(record.idUser, 100800108, 1);
            
            //MemberSummary ms = new MemberSummary();
            //ms.UpdateByCommand(record.idUser, "iBlogCount=iBlogCount-1");
            //Users.Blog(record.idUser, -1);
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
