using System;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Utility_Include_DiscussUser : System.Web.UI.Page
{
    // ҳ�淴����Ϣ
    public string PageResult = "";
    public string id = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u == null)
        {
            Response.Redirect("/member/");
            return;
        }
        #endregion

        if (Prison.Find(u.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        if (Request.QueryString["id"] != null)
        {
            id = Request.QueryString["id"].ToString();
        }

        // �������ݲ��������棩
        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            int idBlog = 0;
            if (Request.Form["idBlog"] != null)
            {
                idBlog = Int32.Parse(Request.Form["idBlog"].ToString());
            }
            
            DiscussInfo record = new DiscussInfo();
            record.idInfo = idBlog;
            record.idUser = u.id;
            record.cLoginName = u.cLoginName;

            int finishedFieldCount = 0;
            if (Request.Form["cContent"] != null)
            {
                try
                {
                    record.cContent = XString.SqlSafe(Request.Form["cContent"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }

            if (GCommon.BadContent(record.cContent))
            {
                    PageResult = "�Ƿ����ۣ�";
                    return;
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount > 0 && PageResult.Length == 0 && record.cContent.Length > 0)
            {
                Discuss table = new Discuss();
                int recordIndex = 0;
                if (table.Insert(record, out recordIndex))
                {
                    #region ͳ������
                    MemberSummary ms = new MemberSummary();
                    ms.UpdateByCommand(m.Default.id, "iNotes=iNotes+1");
                    Users.Notes(m.Default.id, 1);
                    ms.UpdateByCommand(record.idInfo, "iNotes=iNotes+1");
                    Users.Notes(record.idInfo, 1);
                    #endregion

                    PageResult = "���Գɹ�";
                }
                else
                {
                    PageResult = "���Գ���";
                }
            }
        }
    }
}
/* Powered by Beijing Legalsoft Ltd. */
/* This file formatted by WizForm 2.1 at 09-17 09:18 */

