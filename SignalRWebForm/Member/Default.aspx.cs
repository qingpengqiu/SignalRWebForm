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
        #region 身份确认
        Member m = new Member();
        if (m.Default != null)
        {
            //Response.Redirect("/member/success.aspx");
            Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(m.Default.id);
            Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
            return;
        }
        #endregion

        // 接收数据并处理（保存）
        MemberInfo record = new MemberInfo();
        if (Request.Form.Count > 0)
        {
            #region 来源判别
            if (!Me.HostRequired)
            {
                Response.Redirect("/");
            }
            #endregion

            #region 输入数据判别

            int finishedFieldCount = 0;
            if (Request.Form["cLoginName"] != null)
            {
                try
                {
                    record.cLoginName = XString.NickSafe(Request.Form["cLoginName"].ToString());
                    if (record.cLoginName.Length < 2 || record.cLoginName.Length > 32)
                    {
                        PageResult = "(登录名)数据长度超出允许范围！请检查！"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(登录名)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }

                if (GCommon.BadLoginname(record.cLoginName))
                {
                    PageResult = "非法登录名！";
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
                    record.cPassword = XString.SqlSafe(Request.Form["cPassword"].ToString());
                    if (record.cPassword.Length < 6 || record.cPassword.Length > 32)
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

            if (Request.Form["idGender"] != null)
            {
                try
                {
                    record.idGender = Int32.Parse(XString.PureNumber(Request.Form["idGender"].ToString()));
                }
                catch (Exception ex)
                {
                    PageResult = "数据(性别)格式错误[" + ex.Message + "]！请检查！";
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
                    PageResult = "数据(出生日期)格式错误[" + ex.Message + "]！请检查！";
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
                        PageResult = "(姓名)数据长度超出允许范围！请检查！"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(姓名)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(姓名)！";
            }

            if (Request.Form["idQuestion"] != null)
            {
                try
                {
                    record.idQuestion = Int32.Parse(XString.PureNumber(Request.Form["idQuestion"].ToString()));
                }
                catch (Exception ex)
                {
                    PageResult = "数据(密码问题)格式错误[" + ex.Message + "]！请检查！";
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
                        PageResult = "(密码答案)数据长度超出允许范围！请检查！"; return;
                    }
                }
                catch (Exception ex)
                {
                    PageResult = "数据(密码答案)格式错误[" + ex.Message + "]！请检查！";
                    return;
                }
                finishedFieldCount++;
            }
            else
            {
                PageResult = "必须输入数据(密码答案)！";
            }

            #endregion

            // 数据检查完成！添加记录！
            if (finishedFieldCount >= 2 && PageResult.Length == 0)
            {
                int recordIndex = 0;
                if (m.Insert(record, out recordIndex))
                {
                    if (recordIndex > 0)
                    {
                        m.Login(recordIndex, record.cLoginName);
                        Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(recordIndex);
                        #region 积分:注册
                        MemberHistory history = new MemberHistory();
                        history.Insert(recordIndex, 100800100, 1);
                        #endregion

                        //Response.Redirect("/member/success.aspx");
                        Response.Redirect(UrlHelper.MemberUrl(m.Default.id));
                    }
                    PageResult = "注册失败";
                }
                else
                {
                    PageResult = "系统错误：" + m._err;
                }
            }
        }
    }
}
