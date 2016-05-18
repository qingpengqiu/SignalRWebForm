using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections;
using System.Collections.Generic;

using ERUN360.Entity;

public partial class _Member_Query : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        MemberInfo u = m.Default;
        if (u != null)
        {
            //Response.Redirect("/member/success.aspx");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Redirect(UrlHelper.MemberUrl(u.id));
            return;
        }
        #endregion

        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            int finishedFieldCount = 0;

            string idGender = "";
            if (Request.Form["idGender"] != null) idGender = XString.SqlSafe(Request.Form["idGender"].ToString());

            string dBirthday = "";
            if (Request.Form["dBirthday"] != null) dBirthday = XString.SqlSafe(Request.Form["dBirthday"].ToString());

            string cName = "";
            if (Request.Form["cName"] != null)
            {
                try
                {
                    cName = XString.SqlSafe(Request.Form["cName"].ToString());
                    if (cName.Length < 2 || cName.Length > 16)
                    {
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                    finishedFieldCount++;
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
            }
            else
            {
                PageResult = "������������(����)��";
            }

            string cAnswer = "";
            if (Request.Form["cAnswer"] != null)
            {
                try
                {
                    cAnswer = XString.SqlSafe(Request.Form["cAnswer"].ToString());
                    if (cAnswer.Length < 3 || cAnswer.Length > 32)
                    {
                        PageResult = "(�����)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(�����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(�����)��";
            }

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                int idx = m.Query(idGender, cName, dBirthday, cAnswer);

                if (idx > 0)
                {
                    Response.Redirect("/member/password.aspx");
                }
                else
                {
                    PageResult = "��Ϣ����";
                }
            }
        }
    }
}
