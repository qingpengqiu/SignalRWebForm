using System;
using System.IO;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using ERUN360.Entity;

public partial class _Utility_Include_Login : System.Web.UI.Page
{
    public string PageResult = "";

    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!Me.HostRequired)
        {
            Response.Redirect("/");
        }
        if (Request.Form.Count > 0)
        {
            #region ��Դ�б�
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            string cLoginName = "";
            string cPassword = "";

            int finishedFieldCount = 0;
            if (Request.Form["cLoginName"] != null)
            {
                try
                {
                    cLoginName = XString.NickSafe(Request.Form["cLoginName"].ToString());
                    if (cLoginName.Length < 2 || cLoginName.Length > 32)
                    {
                        PageResult = "(��¼��)���ݳ��ȳ�������Χ�����飡";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "����(��¼��)��ʽ����[" + ex.Message + "]�����飡";
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
                    cPassword = XString.SqlSafe(Request.Form["cPassword"].ToString());
                    if (cPassword.Length < 6 || cPassword.Length > 32)
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

            // ���ݼ����ɣ���Ӽ�¼��
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                Member m = new Member();
                m.Login(cLoginName, cPassword);
                if (m.Default != null)
                {
                    

                    #region ����:��¼:24Сʱ֮�ڽ���һ��

                    //MemberHistory history = new MemberHistory();
                    //if (history.Duplicate(m.Default.id, 100800103, " AND dCreate>'" + DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd HH:mm:ss") + "'") == false)
                    //{
                    //    history.Insert(m.Default.id, 100800103, 1);
                    //}
                    //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                    //if (!uMember_History.LoginExists(200810001, m.Default.id))
                    //{
                    //    new DB1.tblIntegral().InsertScore(m.Default.id, 200810001, 1, 0);
                    //    //uMember_History.Insert(m.Default.id, 1, 200800101, 0);
                    //}
                    new DB1.tblIntegral().InsertScore(m.Default.id, 200810001, 1, 0);
                    MemberSummary ms = new MemberSummary();
                    ms.UpdateByCommand(m.Default.id, "iLoginTimes=iLoginTimes+1");
                    Users.LoginTimes(m.Default.id, 1);

                    #endregion
                    Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
                    Session["LOGIN_STATUS"] = "OK";

                    if (Request.Form["goto"] != null)
                    {
                        if (Request.Form["goto"].ToString() == "1")
                        {
                            Session["LOGIN_STATUS"] = m.Default.id.ToString();
                        }
                    }

                    PageResult = "�Ѿ���¼�ɹ�����رմ��ڣ�";
                }
                else
                {
                    PageResult = "��¼�����������" + m._err;
                }
            }
        }
    }
}
