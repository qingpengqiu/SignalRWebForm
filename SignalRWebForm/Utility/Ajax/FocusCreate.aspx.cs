using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Utility_Ajax_FocusCreate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.ContentType = "text/html;charset=GB2312";

        #region ���ȷ��
        Member m = new Member();
        if (m.Default == null)
        {
            Response.Write("ERROR:������ע���û�!");
            return;
        }
        #endregion

        if (Prison.Find(m.Default.id))
        {
            Response.Redirect("/Member/Logout.aspx");
        }

        int id = 0;
        if (Request.QueryString["id"] != null)
        {
            id = Int32.Parse(Request.QueryString["id"].ToString());
        }
        if (id < 100000000)
        {
            Response.Write("ERROR");
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
            Response.Write("ERROR");
            return;
        }
        if (String.Compare(checksum, XString.MD5(id.ToString()), true) != 0)
        {
            Response.Write("ERROR");
            return;
        }

        Attention at = new Attention();
        AttentionInfo ad = new AttentionInfo();
        ad.idInfo = id;
        ad.idUser = m.Default.id;
        ad.cLoginName = m.Default.cLoginName;

        int result = 0;
        if (at.Insert(ad, out result))
        {
            #region ����:��ע
            MemberHistory history = new MemberHistory();
            // ��ע�߻���
            history.Insert(m.Default.id, 100800121, 1);
            // ��ע���͵��ٴμӷ�
            //if (id.ToString().Substring(0, 1) != "1")
            //{
            //    history.Insert(m.Default.id, 100800123, 1);
            //}
            #endregion

            if (id.ToString().Substring(0, 1) == "1")
            {
                #region ����:��ע
                // ����ע�߻���
                history.Insert(id, 100800122, 1);
                #endregion

                #region ժҪ:��ע����
                MemberSummary ms = new MemberSummary();
                ms.UpdateByCommand(id, "iFans=iFans+1");
                Users.Fans(id, 1);
                ms.UpdateByCommand(m.Default.id, "iFocus=iFocus+1");
                Users.Focus(m.Default.id, 1);
                #endregion

                Response.Write("OK");
            }
            else
            {
                #region ժҪ:��ע����
                BlogSummary bs = new BlogSummary();
                bs.UpdateByCommand(id, "iFocus=iFocus+1");
                #endregion

                Response.Write("OK");
            }
        }
        else
        {
            Response.Write("ERROR:ϵͳ����!");
        }
    }
}
