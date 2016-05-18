<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common.DEncrypt;
using Erun360.Common;
using System.Text.RegularExpressions;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using Erun360.Model;
public class LoginHandler : IHttpHandler, IRequiresSessionState
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
    public void msgcode(HttpContext context)
    {
        string result = string.Empty;
        string mobile = TypeChangeDefault.NullToString(context.Request["mobile"], "");//验证码

        if (mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写短信验证码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB5.tblUserCode bll = new DB5.tblUserCode();
        DBM5.tblUserCode Codemodel = bll.GetModel(mobile.Trim(), "register", "n");
        if (Codemodel == null)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string smscode = TypeChangeDefault.NullToString(context.Request["code"], "");//验证码
        //object code = Erun360.Common.DataCache.GetCache(mobile);
        string code = Codemodel.cCode;
        if (smscode != code)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        context.Response.Write("{ \"msg\":\"验证码通过\", \"status\":\"1\" }");
        return;
    }
    public void loginCode(HttpContext context)
    {
        string result = string.Empty;
        string loginCode = TypeChangeDefault.NullToString(context.Request["code"], "");//验证码
        if (loginCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (context.Session["loginCode"] == null)
        {
            result = "{\"msg\":\"验证码已过期！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (loginCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        context.Response.Write("{ \"msg\":\"验证码通过\", \"status\":\"1\" }");
        return;
    }
    public void loginname(HttpContext context)
    {
        string type = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["type"], "")));
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        string cLoginname = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["code"], "")));
        if (cLoginname.Trim().Length == 0)
        {
            context.Response.Write("{ \"msg\":\"手机号不可为空\", \"status\":\"0\" }");
            return;
        }
        if (type == "forgot")
        {
            if (!BLL.Exists(cLoginname))
            {
                context.Response.Write("{ \"msg\":\"该用户不存在，请更换！\", \"status\":\"0\" }");
                return;
            }
            else
            {
                context.Response.Write("{ \"msg\":\"该名称可使用\", \"status\":\"1\" }");
                return;
            }
        }
        else if (type == "register")
        {
            if (!(IsPhone(cLoginname) || IsEmail(cLoginname)))
            {
                context.Response.Write("{ \"msg\":\"请检查手机号的格式！\", \"status\":\"0\" }");
                return;
            }
            if (BLL.Exists(cLoginname))
            {
                context.Response.Write("{ \"msg\":\"该手机号已被注册!\", \"status\":\"0\" }");
                return;
            }
            if (BLL.MobileIsBind(cLoginname))
            {
                context.Response.Write("{ \"msg\":\"该手机号已被绑定!\", \"status\":\"0\" }");
                return;
            }
            context.Response.Write("{ \"msg\":\"手机号可使用\", \"status\":\"1\" }");
            return;
        }

        context.Response.Write("{ \"msg\":\"该用户不存在\", \"status\":\"0\" }");
        return;

    }
    public void loginnick(HttpContext context)
    {
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        string NickName = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["code"], "")));

        if (NickName.Trim().Length == 0)
        {
            context.Response.Write("{ \"msg\":\"昵称不可为空\", \"status\":\"0\" }");
            return;
        }
        if (BLL.ExistNick(NickName))
        {
            context.Response.Write("{ \"msg\":\"该昵称已被占用，请更换！\", \"status\":\"0\" }");
            return;
        }
        context.Response.Write("{ \"msg\":\"该昵称可使用\", \"status\":\"1\" }");
        return;
    }
    public void register(HttpContext context)
    {
        if (!Me.HostRequired)
        {
            context.Response.Write("{ \"msg\":\"非法来源！\", \"status\":\"0\" }");
            return;
        }
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        int m_idUser = TypeChangeDefault.NullToInt(context.Request["u"], 0);//邀请者
        string result = string.Empty;
        string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["mobile"]), "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cLoginname = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["loginCode"], "")));
        if (cLoginname.Length == 0)
        {
            result = "{\"msg\":\"请填写登陆名称\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (!PageValidate.IsPhone(mobile))
        {
            result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (BLL.Exists(mobile))
        {
            result = "{\"msg\":\"该账号已存在，请重新输入！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        model.cLoginname = mobile.Trim();
        model.cNickName = mobile.Trim();
        string loginCode = HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["txtCode"], ""));//验证码
        if (loginCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string PassWord = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["txtPassWord"], ""));//密码

        if (PassWord.Length < 6)
        {
            result = "{\"msg\":\"请填写密码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (PassWord.Length > 64)
        {
            result = "{\"msg\":\"密码超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string RePassWord = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["txtPassWord2"], ""));//密码

        if (RePassWord != PassWord)
        {
            result = "{\"msg\":\"两次密码不一致，请重新输入！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        model.cPassword = XString.MD5(PassWord.ToLower());
        string agree = TypeChangeDefault.NullToString(context.Request["agree"], "");//请选择接受益跑协议
        if (agree != "on")
        {
            result = "{\"msg\":\"请选择接受益跑协议！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;

        }
        model.iChecksum = BLL.GetCheckSum(mobile);
        //后台附加字段
        model.idCity = 0;
        model.idBlood = 0;
        model.idEducation = 0;
        model.idQuestion = 0;
        model.idOccupation = 0;
        model.cAvatar = @"/Html/images/iscardr.png";
        int idUser = BLL.Add(model);
        if (idUser > 0)
        {
            //插入积分数据，并更新积分200            
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            if (!uMember_History.Exists(200810005, idUser))
            {
                new DB1.tblIntegral().InsertScore(idUser, 200810005, 1, 0, 1);
                //uMember_History.Insert(idUser, 1, 200810005, 0);
                DBM1.tblMEMBER_SUMMARY mSummary = new DB1.tblMEMBER_SUMMARY().GetModel(idUser);// new DBM1.tblMEMBER_SUMMARY();
                mSummary.idUser = idUser;
                mSummary.iLoginTimes = mSummary.iLoginTimes + 1;
                new DB1.tblMEMBER_SUMMARY().Update(mSummary);
                //uMember_History.Insert(idUser, 100800100, 10);
            }
            //插入身体数据
            DBM1.tblMEMBER_SIZE mSize = new DBM1.tblMEMBER_SIZE();
            mSize.idUser = idUser;
            new DB1.tblMEMBER_SIZE().Add(mSize);
            //插入博客分类
            DBM2.tblBLOG_GROUP mGroup = new DBM2.tblBLOG_GROUP();
            mGroup.idUser = idUser;
            mGroup.iChecksum = 603286181;//未分类
            mGroup.cTitle = "未分类";
            new DB2.tblBLOG_GROUP().Add(mGroup);
            context.Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(idUser);
            //邀请者送积分
            if (m_idUser != 0)
            {
                new DB1.tblIntegral().InsertScore(m_idUser, 200810002, 1, 0, idUser.ToString());
            }
            UserInfoModel CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
            result = "{\"msg\":\"账号创建成功！\",\"status\":\"1\",\"uid\":\"" + CurrentUser.uId + "\",\"loginame\":\"" + CurrentUser.cLoginname + "\",\"avator\":\"" + CurrentUser.cAvatar + "\",\"memebertype\":\""+ CurrentUser.idMemberStyle + "\",\"nickname\":\""+ CurrentUser.cNickName + "\",\"mobile\":\""+ CurrentUser.cMobile +"\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"账号创建失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    private static Regex RegPhone = new Regex("^1\\d{10}$");
    private static Regex RegEmail = new Regex(@"^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$");
    private static bool IsPhone(string inputData)
    {
        Match m = RegPhone.Match(inputData);
        return m.Success;
    }
    private static bool IsEmail(string inputData)
    {
        Match m = RegEmail.Match(inputData);
        return m.Success;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}