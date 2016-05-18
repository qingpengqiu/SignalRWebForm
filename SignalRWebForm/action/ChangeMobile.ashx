<%@ WebHandler Language="C#" Class="ChangeMobile" %>
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
using System.Collections.Generic;
using ERUN360.Entity;

public class ChangeMobile : CommonHandler, IHttpHandler, IRequiresSessionState
{

    public UserInfoModel CurrentUser;
    public DB1.tblMEMBER MemberBll = new DB1.tblMEMBER();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        string operation = string.Empty;
        if (!string.IsNullOrEmpty(context.Request["op"]))
        {
            operation = context.Request["op"].Trim().ToLower();
        }
        switch (operation)
        {
            case "verifyloginpass"://验证登录密码
                verifyloginpass(context);
                break;
            case "msgcode"://验证短信码
                msgcode(context);
                break;
            case "verificationmobile"://验证输入手机
                verificationmobile(context);
                break;
            case "verificationcode"://验证码
                verificationcode(context);
                break;
            case "changemobile"://修改绑定手机方法
                changemobile(context, "changemobile");
                break;
            case "bindmobile"://绑定手机方法
                changemobile(context, "bindmobile");
                break;
            case "verifynewpass"://验证新密码
                verifynewpass(context);
                break;
            //case "verifynewpassagain"://验证重新输入的新密码
            //    verifynewpassagain(context);
            //    break;
            case "forgetpass"://忘记密码接口
                forgetpass(context);
                break;
            case "verifyloginname"://验证用户登录名
                verifyloginname(context);
                break;
            case "checkmember"://判断用户是否为绑定用户
                checkmember(context);
                break;
            case "verifymobile"://忘记密码时，判断输入的手机号是否正确
                verifymobile(context);
                break;
            default:
                break;
        }
    }
    public void verifyloginpass(HttpContext context)
    {
        string loginpass = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["code"], "")));//登录密码
        string result = string.Empty;
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (String.Compare(CurrentUser.cPassword, XString.MD5(loginpass.ToLower())) != 0)
        {
            result = "{\"msg\":\"登录密码不正确，请重新输入！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        result = "{ \"msg\":\"密码正确\", \"status\":\"1\" }";
        ResponseEnd(context, result);
    }
    //验证短信码
    public void msgcode(HttpContext context)
    {
        string result = string.Empty;
        string mobile = TypeChangeDefault.NullToString(context.Request["mobile"], "");
        string msgtype = TypeChangeDefault.NullToString(context.Request["msgtype"], "");
        if (mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写手机号！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DB5.tblUserCode bll = new DB5.tblUserCode();
        DBM5.tblUserCode Codemodel = bll.GetModel(mobile.Trim(), msgtype, "n");
        if (Codemodel == null)
        {
            result = "{\"msg\":\"短信验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string smscode = TypeChangeDefault.NullToString(context.Request["code"], "");//短信验证码
        string code = Codemodel.cCode;
        if (smscode != code)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        result = "{ \"msg\":\"验证码通过\", \"status\":\"1\" }";
        ResponseEnd(context, result);
    }
    //验证手机号
    protected void verificationmobile(HttpContext context)
    {
        string result = string.Empty;
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        string cLoginname = XString.SqlSafe(HttpUtility.UrlDecode(TypeChangeDefault.NullToString(context.Request["code"], "")));//手机号
        if (!(PageValidate.IsPhone(cLoginname)))
        {
            result = "{ \"msg\":\"请检查手机号的格式！\", \"status\":\"0\" }";
            ResponseEnd(context, result);
        }
        result = "{ \"msg\":\"手机号可使用\", \"status\":\"1\" }";
        ResponseEnd(context, result);
    }
    //验证码
    protected void verificationcode(HttpContext context)
    {
        string result = string.Empty;
        string loginCode = TypeChangeDefault.NullToString(context.Request["code"], "");//验证码
        if (loginCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (context.Session["loginCode"] == null)
        {
            result = "{\"msg\":\"验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (loginCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        result = "{ \"msg\":\"验证码通过\", \"status\":\"1\" }";
        ResponseEnd(context, result);
    }
    protected void changemobile(HttpContext context, string strtype)
    {
        DBM1.tblMEMBER Membermodel = new DBM1.tblMEMBER();
        string result = string.Empty;
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if ((CurrentUser.idMemberStyle == 3 || CurrentUser.idMemberStyle == 4) && strtype == "bindmobile")
        {
            result = "{\"msg\":\"您已经绑定过手机！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if ((CurrentUser.idMemberStyle == 0 || CurrentUser.idMemberStyle == 2) && strtype == "changemobile")
        {
            result = "{\"msg\":\"请先绑定手机！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string loginpass = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["loginpass"]), "");
        if (!CheckPassword(CurrentUser.uId, loginpass))
        {
            result = "{\"msg\":\"您输入的账户密码错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["mobile"]), "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!PageValidate.IsPhone(mobile))
        {
            result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string verifyCode = TypeChangeDefault.NullToString(context.Request["txtCode"], "");//验证码
        if (verifyCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (context.Session["loginCode"] == null)
        {
            result = "{\"msg\":\"验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (verifyCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string msgCode = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["msgCode"], ""));
        DBM5.tblUserCode Codemodel = new DB5.tblUserCode().GetModel(mobile.Trim(), strtype, "n");
        if (Codemodel == null)
        {
            result = "{\"msg\":\"短信验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string code = Codemodel.cCode;
        if (msgCode != code)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        //当前有其他账号的登录名与输入手机号相同，是否继续进行绑定手机操作标识
        string iscontinue = "0";
        if (!string.IsNullOrEmpty(context.Request["iscontinue"]))
        {
            iscontinue = context.Request["iscontinue"].ToString().Trim();
        }
        //除了当前用户是否还有人绑定过次手机
        if (MemberBll.ExistsUserByMobile(CurrentUser.uId, mobile))
        {
            result = "{\"msg\":\"该手机已被其他用户绑定，请您尝试其他手机！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else
        {
            //判断除了当前用户之外，是否存在登录名=输入手机号的账号
            string strwhere = string.Format(" cLoginname='{0}' and id<>{1} ", mobile, CurrentUser.uId);
            List<DBM1.tblMEMBER> ListOfMember = MemberBll.GetModelList(strwhere);
            if (ListOfMember.Count > 0 && iscontinue == "0")
            {
                result = "{\"msg\":\"存在登录名与输入手机号相同的用户，是否继续操作！\",\"status\":\"-1\"}";
                ResponseEnd(context, result);
            }
            else if (ListOfMember.Count > 0 && iscontinue == "1")
            {
                foreach (DBM1.tblMEMBER ExistMemeber in ListOfMember)
                {
                    DBM1.tblMEMBER updatemember = new DBM1.tblMEMBER();
                    updatemember.id = ExistMemeber.id;
                    updatemember.cLoginname = mobile + "_modify";//强制修改已有账号的用户名
                    updatemember.iChecksum = MemberBll.GetCheckSum(mobile + "_modify");
                    MemberBll.Update(updatemember);
                }
            }
            string strmsg = string.Empty;
            if (strtype == "changemobile")
            {
                strmsg = "修改绑定手机";
            }
            else if (strtype == "bindmobile")
            {
                strmsg = "绑定手机";
            }
            if (PageValidate.IsPhone(CurrentUser.cLoginname))
            {
                DBM1.tblMEMBER updatemember = new DBM1.tblMEMBER();
                updatemember.id = CurrentUser.uId;
                if (CurrentUser.idMemberStyle == 0)
                {
                    updatemember.idMemberStyle = 3;
                }
                else if (CurrentUser.idMemberStyle == 2)
                {
                    updatemember.idMemberStyle = 4;
                }
                updatemember.cMobile = mobile;
                updatemember.cLoginname = mobile;
                updatemember.iChecksum = MemberBll.GetCheckSum(mobile);
                if (MemberBll.Update(updatemember))
                {
                    result = "{\"msg\":\"" + strmsg + "成功！\",\"status\":\"1\"}";
                    ResponseEnd(context, result);
                }
                else
                {
                    result = "{\"msg\":\"" + strmsg + "失败！\",\"status\":\"0\"}";
                    ResponseEnd(context, result);
                }
            }
            else
            {
                DBM1.tblMEMBER updatemember = new DBM1.tblMEMBER();
                updatemember.id = CurrentUser.uId;
                if (CurrentUser.idMemberStyle == 0)
                {
                    updatemember.idMemberStyle = 3;
                }
                else if (CurrentUser.idMemberStyle == 2)
                {
                    updatemember.idMemberStyle = 4;
                }
                updatemember.cMobile = mobile;
                if (MemberBll.Update(updatemember))
                {
                    result = "{\"msg\":\"" + strmsg + "成功！\",\"status\":\"1\"}";
                    ResponseEnd(context, result);
                }
                else
                {
                    result = "{\"msg\":\"" + strmsg + "失败！\",\"status\":\"0\"}";
                    ResponseEnd(context, result);
                }
            }
        }
    }
    protected void verifynewpass(HttpContext context)
    {
        string result = string.Empty;
        string newPass = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["newpass"], ""));
        if (string.IsNullOrEmpty(newPass.Trim()))
        {
            result = "{\"msg\":\"密码不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (newPass.Trim().Length < 6)
        {
            result = "{\"msg\":\"密码少于6位字符！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (newPass.Trim().Length > 64)
        {
            result = "{\"msg\":\"密码超过限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else
        {
            result = "{\"msg\":\"密码可用！\",\"status\":\"1\"}";
            ResponseEnd(context, result);
        }
    }
    //protected void verifynewpassagain(HttpContext context)
    //{
    //    string result = string.Empty;
    //    string newPass = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["newpass"], ""));
    //    string newPassagain = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["newpassagain"], ""));
    //    if (string.IsNullOrEmpty(newPassagain.Trim()))
    //    {
    //        result = "{\"msg\":\"密码不能为空！\",\"status\":\"0\"}";
    //        ResponseEnd(context, result);
    //    }
    //    else if (newPassagain.Trim().Length < 6)
    //    {
    //        result = "{\"msg\":\"密码少于6位字符！\",\"status\":\"0\"}";
    //        ResponseEnd(context, result);
    //    }
    //    else if (newPassagain.Trim().Length > 64)
    //    {
    //        result = "{\"msg\":\"密码超过限制！\",\"status\":\"0\"}";
    //        ResponseEnd(context, result);
    //    }
    //    if (newPass.Trim() != newPassagain.Trim())
    //    {
    //        result = "{\"msg\":\"两次密码不一致，请重新输入！\",\"status\":\"0\"}";
    //        ResponseEnd(context, result);
    //    }
    //}
    protected void forgetpass(HttpContext context)
    {
        string result = string.Empty;
        string loginname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(HttpUtility.UrlDecode(context.Request["loginname"])), "");
        string mobile = TypeChangeDefault.NullToString(context.Request["mobile"], "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!PageValidate.IsPhone(mobile))
        {
            result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!MemberBll.Exists(loginname))
        {
            result = "{\"msg\":\"账号不存在！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string strwhere = string.Format(" cLoginname='{0}' ", loginname);
        List<DBM1.tblMEMBER> ListOfMember = MemberBll.GetModelList(strwhere);
        if (ListOfMember.Count > 0)
        {
            DBM1.tblMEMBER membermodel = ListOfMember[0];
            if (mobile.Trim() != membermodel.cMobile)
            {
                result = "{\"msg\":\"手机号不可用！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
        string verifyCode = TypeChangeDefault.NullToString(context.Request["txtCode"], "");//验证码
        if (verifyCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (context.Session["loginCode"] == null)
        {
            result = "{\"msg\":\"验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (verifyCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string msgCode = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["msgCode"], ""));
        DBM5.tblUserCode Codemodel = new DB5.tblUserCode().GetModel(mobile.Trim(), "forgetpwd", "n");
        if (Codemodel == null)
        {
            result = "{\"msg\":\"短信验证码已过期！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string code = Codemodel.cCode;
        if (msgCode != code)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string newPass = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["newpass"], ""));
        //string newPassagain = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["newpassagain"], ""));
        if (string.IsNullOrEmpty(newPass.Trim()))
        {
            result = "{\"msg\":\"密码不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (newPass.Trim().Length < 6)
        {
            result = "{\"msg\":\"密码少于6位字符！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (newPass.Trim().Length > 64)
        {
            result = "{\"msg\":\"密码超过限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        //if (newPass.Trim() != newPassagain.Trim())
        //{
        //    result = "{\"msg\":\"两次密码不一致，请重新输入！\",\"status\":\"0\"}";
        //    ResponseEnd(context, result);
        //}
        DBM1.tblMEMBER updatemember = new DBM1.tblMEMBER();
        strwhere = string.Format(" cLoginname='{0}' ", loginname);
        ListOfMember = MemberBll.GetModelList(strwhere);
        if (ListOfMember.Count > 0)
        {
            DBM1.tblMEMBER membermodel = ListOfMember[0];
            updatemember.id = membermodel.id;
            updatemember.cPassword = XString.MD5(newPass.Trim().ToLower());
            MemberBll.Update(updatemember);
            result = "{\"msg\":\"修改密码成功！！\",\"status\":\"1\"}";
            new DB1.tblIntegral().InsertScore(updatemember.id, 200810001, 1, 0);
            context.Session["CurrentUser"] = new Erun360.BLL.UserInfoBll().GetUserModel(updatemember.id);
            Member m = new Member();
            m.Login(membermodel.cLoginname, newPass.Trim());
            ResponseEnd(context, result);
        }
        else
        {
            result = "{\"msg\":\"该用户不存在，请更换！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
    }
    protected void verifyloginname(HttpContext context)
    {
        string result = string.Empty;
        string loginname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["loginname"]), "");
        if (string.IsNullOrEmpty(loginname))
        {
            result = "{\"msg\":\"请先输入登录名！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!MemberBll.Exists(loginname))
        {
            result = "{\"msg\":\"该用户不存在，请您检查！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
    }
    protected void checkmember(HttpContext context)
    {
        string result = string.Empty;
        string loginname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["loginname"]), "");
        if (string.IsNullOrEmpty(loginname))
        {
            result = "{\"msg\":\"请先输入登录名！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!MemberBll.Exists(loginname))
        {
            result = "{\"msg\":\"该用户不存在，请您检查！！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string strwhere = string.Format(" cLoginname='{0}' ", loginname);
        List<DBM1.tblMEMBER> ListOfMember = MemberBll.GetModelList(strwhere);
        if (ListOfMember.Count > 0)
        {
            DBM1.tblMEMBER membermodel = ListOfMember[0];
            if (membermodel.idMemberStyle == 0 || membermodel.idMemberStyle == 2)
            {
                result = "{\"msg\":\"0\",\"status\":\"1\"}";//未绑定用户
            }
            else if (membermodel.idMemberStyle == 4 || membermodel.idMemberStyle == 3)
            {
                result = "{\"msg\":\"1\",\"status\":\"1\"}";//已绑定用户
            }
            ResponseEnd(context, result);
        }
    }
    protected void verifymobile(HttpContext context)
    {
        string result = string.Empty;
        string loginname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["loginname"]), "");
        string mobile = TypeChangeDefault.NullToString(context.Request["mobile"], "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (!PageValidate.IsPhone(mobile))
        {
            result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        string strwhere = string.Format(" cLoginname='{0}' ", loginname);
        List<DBM1.tblMEMBER> ListOfMember = MemberBll.GetModelList(strwhere);
        if (ListOfMember.Count > 0)
        {
            DBM1.tblMEMBER membermodel = ListOfMember[0];
            if (mobile.Trim() == membermodel.cMobile)
            {
                result = "{\"msg\":\"手机号可用！\",\"status\":\"1\"}";
                ResponseEnd(context, result);
            }
            else
            {
                result = "{\"msg\":\"手机号不可用！\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
    }
    protected void ResponseEnd(HttpContext context, string result)
    {
        context.Response.Write(result);
        context.Response.End();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}