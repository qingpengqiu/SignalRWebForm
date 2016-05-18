<%@ WebHandler Language="C#" Class="ajaxlogin" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using Newtonsoft.Json;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Collections;
using Erun360.BLL;
using ERUN360.Entity;
public class ajaxlogin : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    public void login(HttpContext context)
    {
        string result = string.Empty;
        if (!Me.HostRequired)
        {
            result = "{\"msg\":\"非法请求！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        string Loginname = XString.SqlSafe(XString.NickSafe(TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["name"]), "")));//登录名
        if (Loginname.Trim().Length == 0 || Loginname.Trim().Length > 64)
        {
            result = "{\"msg\":\"登录名为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        string Password = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["psd"], ""));//登录名
        if (Password.Trim().Length == 0 || Password.Trim().Length > 64)
        {
            result = "{\"msg\":\"密码为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        int count = new DB1.tblMEMBER().GetRecordCount("cLoginname='" + Loginname.Trim() + "'");
        if (count == 0)
        {
            result = "{\"msg\":\"该用户不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetLogin(Loginname.Trim(), XString.MD5(Password.Trim().ToLower()));
        if (model == null)
        {
            result = "{\"msg\":\"密码不正确，请重新输入！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string auto = TypeChangeDefault.NullToString(context.Request["auto"], "");//是否自动登陆
        if (auto == "1")
        {
            CookiesHelper.AddCookie("Loginname", "COOKIES_OF_ERUN360", model.cLoginname);
            CookiesHelper.AddCookie("Password", "COOKIES_OF_ERUN360", model.cPassword);
        }
        //erun全站新cookie
        //用户积分
        string score = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + model.id.ToString(), model.id).ToString();
        CookiesHelper.LoginCookieSave(model.id.ToString(), model.cLoginname, model.cPassword, model.cAvatar, model.idMemberStyle.ToString(), model.cNickName, model.cMobile, score);

        new DB1.tblIntegral().InsertScore(model.id, 200810001, 1, 0);
        
        context.Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().UpdateUserModel(model.id);
        Member m = new Member();
        m.Login(Loginname, Password);

        UserInfoModel CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        result = "{\"msg\":\"登录成功！\",\"status\":\"1\",\"uid\":\"" + CurrentUser.uId + "\",\"loginame\":\"" + CurrentUser.cLoginname + "\",\"avator\":\"" + CurrentUser.cAvatar + "\",\"memebertype\":\""+ CurrentUser.idMemberStyle + "\",\"nickname\":\""+ CurrentUser.cNickName + "\",\"mobile\":\""+ CurrentUser.cMobile +"\"}";
        context.Response.Write(result);
        return;

    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}