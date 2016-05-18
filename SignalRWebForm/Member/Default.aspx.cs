using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;

using ERUN360.Entity;

public partial class _Member_Default : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        #region ���ȷ��
        Member m = new Member();
        if (m.Default != null)
        {
            //Response.Redirect("/member/success.aspx");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
            return;
        }
        #endregion

        // �������ݲ��������棩
        MemberInfo record = new MemberInfo();
        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            #region ���������б�

            int finishedFieldCount = 0;
            if (Request.Form["cLoginName"] != null)
            {
                try
                {
                    record.cLoginName = XString.NickSafe(Request.Form["cLoginName"].ToString());
                    if (record.cLoginName.Length < 2 || record.cLoginName.Length > 32)
                    {
                        PageResult = "(��¼��)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(��¼��)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }

                if (GCommon.BadLoginname(record.cLoginName))
                {
                    PageResult = "�Ƿ���¼����";
                    return;
                }

                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(��¼��)��";
            }

            if (Request.Form["cPassword"] != null)
            {
                try
                {
                    record.cPassword = XString.SqlSafe(Request.Form["cPassword"].ToString());
                    if (record.cPassword.Length < 6 || record.cPassword.Length > 32)
                    {
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(��¼��)��";
            }

            if (Request.Form["idGender"] != null)
            {
                try
                {
                    record.idGender = Int32.Parse(XString.PureNumber(Request.Form["idGender"].ToString()));
                }
                catch (Exception ex)
                {
                    PageResult = "����(�Ա�)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }

            if (Request.Form["dBirthday"] != null)
            {
                try
                {
                    record.dBirthday = DateTime.Parse(Request.Form["dBirthday"].ToString());
                }
                catch (Exception ex)
                {
                    PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }

            if (Request.Form["cName"] != null)
            {
                try
                {
                    record.cName = XString.SqlSafe(Request.Form["cName"].ToString());
                    if (record.cName.Length < 2 || record.cName.Length > 16)
                    {
                        PageResult = "(����)���ݳ��ȳ�������Χ�����飡"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(����)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "������������(����)��";
            }

            if (Request.Form["idQuestion"] != null)
            {
                try
                {
                    record.idQuestion = Int32.Parse(XString.PureNumber(Request.Form["idQuestion"].ToString()));
                }
                catch (Exception ex)
                {
                    PageResult = "����(��������)��ʽ����[" + ex.Message + "]�����飡";
                    return;
                }
                finishedFieldCount++;
            }

            if (Request.Form["cAnswer"] != null)
            {
                try
                {
                    record.cAnswer = XString.SqlSafe(Request.Form["cAnswer"].ToString());
                    if (record.cAnswer.Length < 3 || record.cAnswer.Length > 32)
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

            #endregion

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                int recordIndex = 0;
                if (m.Insert(record, out recordIndex))
                {
                    if (recordIndex > 0)
                    {
                        m.Login(recordIndex, record.cLoginName);
                        Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(recordIndex);
                        #region ����:ע��
                        MemberHistory history = new MemberHistory();
                        history.Insert(recordIndex, 100800100, 1);
                        #endregion

                        //Response.Redirect("/member/success.aspx");
                        Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
                    }
                    PageResult = "ע��ʧ��";
                }
                else
                {
                    PageResult = "ϵͳ����" + m._err;
                }
            }
        }
    }
}
