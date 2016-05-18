using System;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Admin_BlogPublish_Delete : System.Web.UI.Page
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
        BlogPublish table = new BlogPublish();
        BlogPublishInfo record = table.Load(recordIndex, "", "");
        if (record == null)
        {
            Response.Write("���ݴ���(Index error)��");
            return;
        }

        if (table.Delete(recordIndex))
        {
            TCache.Clear("CACHE_OF_PAGE_" + record.idPosition);
            TCache.Clear("CACHE_PAGE_TOPICS_" + record.idPosition);

            #region ����:��������ҳ������ҳ��

            Blog b = new Blog();
            BlogInfo blog_record = b.Load(recordIndex, "", "");
            if(blog_record!=null)
            {
                MemberHistory history = new MemberHistory();
                if (record.idPosition < 301000000)
                {
                    // ��ҳ                    
                    //history.Insert(blog_record.idUser, 100800112, -1);
                }
                else
                {
                    // ����ҳ��
                    //history.Insert(blog_record.idUser, 100800111, -1);
                }
            }            
            #endregion

            Response.Write("OK");
        }
        else
        {
            Response.Write("ϵͳ����" + table._err);
        }
    }
}
/* Powered by ������������������޹�˾ Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */
