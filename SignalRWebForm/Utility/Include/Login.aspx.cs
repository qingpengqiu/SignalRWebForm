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
            #region 来源判别
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
                        PageResult = "(登录名)数据长度超出允许范围！请检查！";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(登录名)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(登录名)！";
            }

            if (Request.Form["cPassword"] != null)
            {
                try
                {
                    cPassword = XString.SqlSafe(Request.Form["cPassword"].ToString());
                    if (cPassword.Length < 6 || cPassword.Length > 32)
                    {
                        PageResult = "(密码)数据长度超出允许范围！请检查！"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(密码)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(登录名)！";
            }

            // 数据检查完成！添加记录！
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                Member m = new Member();
                m.Login(cLoginName, cPassword);
                if (m.Default != null)
                {
                    

                    #region 积分:登录:24小时之内仅给一次

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

                    PageResult = "已经登录成功，请关闭窗口！";
                }
                else
                {
                    PageResult = "登录名、密码错误" + m._err;
                }
            }
        }
    }
}
