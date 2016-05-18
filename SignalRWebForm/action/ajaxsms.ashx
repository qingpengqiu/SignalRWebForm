<%@ WebHandler Language="C#" Class="ajaxsms" %>

using System;
using System.Web;
using System.Xml;
using Erun360.Common;
using System.Text;
using System.Collections.Specialized;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common.DEncrypt;
using System.Web.SessionState;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Data;
using Erun360.Model;
using System.Collections.Generic;
public class ajaxsms : IHttpHandler, IRequiresSessionState
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
    public void Register(HttpContext context)
    {
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        int m_idUser = TypeChangeDefault.NullToInt(context.Request["u"], 0);//邀请者
        string result = string.Empty;
        string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["loginCode"]), "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
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
        string smsCode = TypeChangeDefault.NullToString(context.Request["txtCode"], "");//验证码
        if (smsCode.Trim().Length == 0)
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
        if (smsCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string txtNick = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["txtNick"]), "");
        if (txtNick.Trim().Length > 64 || txtNick.Trim().Length == 0)
        {
            result = "{\"msg\":\"昵称为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (BLL.ExistNick(txtNick))
        {
            result = "{\"msg\":\"该昵称已存在，请重新输入！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        model.cNickName = txtNick;
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
        model.cPassword = XString.MD5(PassWord.ToLower());
        string msgCode = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["msgCode"], ""));//密码
        DBM5.tblUserCode Codemodel = new DB5.tblUserCode().GetModel(mobile.Trim(), "register", "n");
        if (Codemodel == null)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string code = Codemodel.cCode;
        if (msgCode != code)
        {
            result = "{\"msg\":\"短信验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        string agree = TypeChangeDefault.NullToString(context.Request["agree"], "");//请选择接受益跑协议
        if (agree != "on")
        {
            result = "{\"msg\":\"请选择接受益跑协议！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;

        }
        model.cMobile = mobile.Trim();
        model.cMobile = mobile.Trim();
        model.iChecksum = BLL.GetCheckSum(mobile);
        //后台附加字段
        model.idMemberStyle = 3;
        model.idCity = 0;
        model.idBlood = 0;
        model.idEducation = 0;
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
            DB5.tblUserCode bllCode = new DB5.tblUserCode();
            DBM5.tblUserCode modelCode = new DBM5.tblUserCode();
            modelCode.id = Codemodel.id;
            modelCode.iStatus = 1;
            bllCode.Update(modelCode);
            UserInfoModel CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
            result = "{\"msg\":\"账号创建成功！\",\"status\":\"1\",\"uid\":\"" + CurrentUser.uId + "\",\"loginame\":\"" + CurrentUser.cLoginname + "\",\"avator\":\"" + CurrentUser.cAvatar + "\",\"memebertype\":\"" + CurrentUser.idMemberStyle + "\",\"nickname\":\"" + CurrentUser.cNickName + "\",\"mobile\":\"" + CurrentUser.cMobile + "\"}";
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
    public void sendsms(HttpContext context)
    {
        string result = string.Empty;
        //qiuqp 2015-01-12 添加类型参数type：register-注册；bindmobile--绑定手机；changemobile-修改手机；forgetpwd-忘记密码
        string msgtype = TypeChangeDefault.NullToString(context.Request["type"], "");

        string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["mobile"]), "");
        if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
        {
            result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (!PageValidate.IsPhone(mobile.Trim()))
        {
            result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

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
        DB5.tblUserCode bll = new DB5.tblUserCode();
        int count = bll.GetRecordCount("cLoginname='" + mobile.Trim() + "' and cType='" + msgtype + "' and DateDiff(dd,dCreate,getdate())=0");//and cType='register'
        if (count > 5)
        {
            result = "{\"msg\":\"每天只能发送5次验证码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string code = RandNum(4);
        DBM5.tblUserCode Codemodel = bll.GetModel(mobile.Trim(), msgtype, "n");//register
        if (Codemodel == null)
        {
            DBM5.tblUserCode model = new DBM5.tblUserCode();
            model.idUser = 0;
            model.cLoginname = mobile.Trim();
            model.cType = msgtype;//register
            model.cCode = code;
            model.iStatus = 0;
            model.cIp = GetHostAddress();
            model.dExpire = DateTime.Now.AddMinutes(3);
            model.dCreate = DateTime.Now;
            bll.Add(model);
        }
        else
        {
            code = Codemodel.cCode;
        }
        string msg = string.Empty;
        //qiuqp 2015-01-12 
        switch (msgtype)
        {
            case "register":
                msg = "您正在注册，验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                break;
            case "changemobile":
                msg = "您正在修改手机，验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                break;
            case "bindmobile":
                msg = "您正在绑定手机，验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                break;
            case "forgetpwd":
                msg = "验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                break;
            default:
                break;
        }
        //string msg = "您的验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(context.Server.MapPath("/XML/SMS.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("sms/send[id='SendSms']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        string un = xmlNode["userid"].InnerText;
        string pwd = xmlNode["psd"].InnerText;
        string url = xmlNode["url"].InnerText;
        string m_result = SMS.HttpGet(url, "mobile=" + mobile + "&msg=" + HttpUtility.UrlEncode(msg, Encoding.GetEncoding("GB2312")) + "&un=" + un + "&pwd=" + pwd);
        if (m_result.Contains("result=1"))//result=x
        {
            result = "{\"msg\":\"短信发送成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"短信发送失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 益跑app短信验证码接口,短息类型参数type：register-注册；forgetpwd-忘记密码
    /// </summary>
    /// <param name="context"></param>
    public void appsms(HttpContext context)
    {
        try
        {
            DB1.tblMEMBER BLL = new DB1.tblMEMBER();
            string result = string.Empty;
            string msgtype = TypeChangeDefault.NullToString(context.Request["type"], "");
            string loginname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(HttpUtility.UrlDecode(context.Request["loginname"])), "");
            string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["mobile"]), "");
            if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
            {
                result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (!PageValidate.IsPhone(mobile.Trim()))
            {
                result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (msgtype == "register" && BLL.Exists(mobile))
            {
                result = "{\"msg\":\"该手机号已经在益跑网注册过账号，请更改手机号！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string strwhere = string.Format(" cLoginname='{0}' ", loginname);
            List<DBM1.tblMEMBER> ListOfMember = BLL.GetModelList(strwhere);
            if (ListOfMember.Count > 0 && msgtype == "forgetpwd")
            {
                DBM1.tblMEMBER membermodel = ListOfMember[0];
                if (mobile.Trim() != membermodel.cMobile)
                {
                    result = "{\"msg\":\"手机号不可用！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
            }
            DB5.tblUserCode bll = new DB5.tblUserCode();
            int count = bll.GetRecordCount("cLoginname='" + mobile.Trim() + "' and cType='" + msgtype + "' and DateDiff(dd,dCreate,getdate())=0");
            if (count > 5)
            {
                result = "{\"msg\":\"每天只能发送5次验证码！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            string code = RandNum(4);
            DBM5.tblUserCode Codemodel = bll.GetModel(mobile.Trim(), msgtype, "n");
            if (Codemodel == null)
            {
                DBM5.tblUserCode model = new DBM5.tblUserCode();
                model.idUser = 0;
                model.cLoginname = mobile.Trim();
                model.cType = msgtype;//register
                model.cCode = code;
                model.iStatus = 0;
                model.cIp = GetHostAddress();
                model.dExpire = DateTime.Now.AddMinutes(3);
                model.dCreate = DateTime.Now;
                bll.Add(model);
            }
            else
            {
                code = Codemodel.cCode;
            }
            string msg = string.Empty;
            switch (msgtype)
            {
                case "register":
                    msg = "您正在注册，验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                    break;
                case "forgetpwd":
                    msg = "验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
                    break;
                default:
                    break;
            }
            //string msg = "您的验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
            //操作二：获得单个节点的值
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(context.Server.MapPath("/XML/SMS.xml"));
            XmlNodeList xmlNodeList = xmlDoc.SelectNodes("sms/send[id='SendSms']");//查找
            XmlNode xmlNode = xmlNodeList.Item(0);
            string un = xmlNode["userid"].InnerText;
            string pwd = xmlNode["psd"].InnerText;
            string url = xmlNode["url"].InnerText;
            string m_result = SMS.HttpGet(url, "mobile=" + mobile + "&msg=" + HttpUtility.UrlEncode(msg, Encoding.GetEncoding("GB2312")) + "&un=" + un + "&pwd=" + pwd);
            if (m_result.Contains("result=1"))//result=x
            {
                result = "{\"msg\":\"短信发送成功！\",\"status\":\"1\"}";
                context.Response.Write(result);
                return;
            }
            else
            {
                result = "{\"msg\":\"短信发送失败！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }
        catch (Exception ex)
        {

            context.Response.Write(ex.Message);
        }

    }
    public static string RandNum(int n)
    {
        char[] arrChar = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };
        StringBuilder num = new StringBuilder();
        Random rnd = new Random(DateTime.Now.Millisecond);
        for (int i = 0; i < n; i++)
        {
            num.Append(arrChar[rnd.Next(0, 9)].ToString());
        }
        return num.ToString();
    }
    /// <summary>
    /// 获取客户端IP地址（无视代理）
    /// </summary>
    /// <returns>若失败则返回回送地址</returns>
    public static string GetHostAddress()
    {
        string userHostAddress = HttpContext.Current.Request.UserHostAddress;
        if (string.IsNullOrEmpty(userHostAddress))
        {
            userHostAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        //最后判断获取是否成功，并检查IP地址的格式（检查其格式非常重要） 
        if (!string.IsNullOrEmpty(userHostAddress) && IsIP(userHostAddress))
        {
            return userHostAddress;
        }
        return "127.0.0.1";
    }
    /// <summary>
    /// 检查IP地址格式
    /// </summary>
    /// <param name="ip"></param>
    /// <returns></returns>
    public static bool IsIP(string ip)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
    }
    public void sendsmsgroup(HttpContext context)
    {
        string result = string.Empty;
        string mobile = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["mobile"]), "");
        NameValueCollection FieldVars = new NameValueCollection();
        string[] phones = mobile.Split(',');
        foreach (string right in phones)
        {
            if (mobile.Trim().Length > 11 || mobile.Trim().Length == 0)
            {
                result = "{\"msg\":\"手机号为空或超过限制！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            if (!PageValidate.IsPhone(mobile))
            {
                result = "{\"msg\":\"手机号格式错误！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
        }

        string msg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (msg.Trim().Length > 64 || msg.Trim().Length == 0)
        {
            result = "{\"msg\":\"短信内容为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(context.Server.MapPath("/XML/SMS.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("sms/send[id='SendSms']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        string un = xmlNode["userid"].InnerText;
        string pwd = xmlNode["psd"].InnerText;
        string url = xmlNode["url"].InnerText;
        string m_result = SMS.HttpGet(url, "mobile=" + mobile + "&msg=" + HttpUtility.UrlEncode(msg, Encoding.GetEncoding("GB2312")) + "&un=" + un + "&pwd=" + pwd);

        //        <?xml version="1.0" encoding="gb2312"?>
        //<Root>
        //<Result>1</Result>
        //<MobileNum>3</MobileNum>
        //<SendNum>3</SendNum>
        //</Root>
        XmlDocument xmlsms = new XmlDocument();
        xmlsms.LoadXml(m_result);
        string ResultCode = xmlsms.SelectSingleNode("/Root/Result").InnerText;
        if (ResultCode == "1")//result=x
        {
            result = "{\"msg\":\"短信发送成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"短信发送成功！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}