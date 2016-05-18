using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Admin_Discuss_Delete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Admin.IsAdmin())
        {
            Response.Write("û�в���Ȩ�ޣ�");
            return;
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

        // �ֿ������ֶ�
        int _idinfo = 0;
        if (Request.QueryString["idinfo"] != null)
        {
            try
            {
                _idinfo = Int32.Parse(XString.PureNumber(Request.QueryString["idinfo"].ToString()));
            }
            catch (Exception ex)
            {
                Response.Write("����(idinfo)����[" + ex.Message + "]��");
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
        Discuss table = new Discuss();
        DiscussInfo record = table.Load(_idinfo, recordIndex, "", "");
        if (record == null)
        {
            Response.Write("���ݴ���(Index error)��");
            return;
        }

        if (table.Delete(_idinfo, recordIndex))
        {
            #region �޸Ļ���
            MemberHistory history = new MemberHistory();
            history.Insert(record.idUser, 100800110, 1);
            #endregion

            #region �޸�ͳ����
            MemberSummary ms = new MemberSummary();
            ms.UpdateByCommand(record.idUser, "iDiscuss=iDiscuss-1");
            Users.Discuss(record.idUser, -1);
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
/* This file formatted by WizForm 2.1 at 09-14 16:40 */
