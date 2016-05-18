<%@ WebHandler Language="C#" Class="ajaxforgot" %>

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
public class ajaxforgot : IHttpHandler, IRequiresSessionState
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
    public void forgot(HttpContext context)
    {
        string result = string.Empty;
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

        string msgCode = XString.SqlSafe(TypeChangeDefault.NullToString(context.Request["msgCode"], ""));//短信码
        DBM5.tblUserCode Codemodel = new DB5.tblUserCode().GetModel(mobile.Trim(), "forgot", "n");
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
        DB1.tblMEMBER bll = new DB1.tblMEMBER();
        DataTable dt = bll.GetList(1, "cLoginname='" + mobile.Trim() + "'", "id").Tables[0];
        int count = dt.Rows.Count;
        if (count == 0)
        {
            result = "{\"msg\":\"该用户不存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["id"], 0);
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
        DBM1.tblMEMBER model = new DBM1.tblMEMBER();
        model.id = idUser;
        model.cPassword = XString.MD5(PassWord.ToLower());
        if (bll.Update(model))
        {
            DB5.tblUserCode bllCode = new DB5.tblUserCode();
            DBM5.tblUserCode modelCode = new DBM5.tblUserCode();
            modelCode.id = Codemodel.id;
            modelCode.iStatus = 1;
            bllCode.Update(modelCode);
            result = "{\"msg\":\"密码成功找回！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else {
            result = "{\"msg\":\"找回密码失败！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
    }
    public void sendsms(HttpContext context)
    {
        string result = string.Empty;
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

        string ForgotCode = TypeChangeDefault.NullToString(context.Request["code"], "");//验证码
        if (ForgotCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (context.Session["ForgotCode"] == null)
        {
            result = "{\"msg\":\"验证码已过期！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (ForgotCode.ToLower() != context.Session["ForgotCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DB5.tblUserCode bll = new DB5.tblUserCode();
        int count = bll.GetRecordCount("cLoginname='" + mobile.Trim() + "' and cType='forgot' and DateDiff(dd,dCreate,getdate())=0");
        if (count > 5)
        {
            result = "{\"msg\":\"每天只能发送5次验证码！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string code = RandNum(4);
        DBM5.tblUserCode Codemodel = bll.GetModel(mobile.Trim(), "register", "n");
        if (Codemodel == null)
        {
            DBM5.tblUserCode model = new DBM5.tblUserCode();
            model.idUser = 0;
            model.cLoginname = mobile.Trim();
            model.cType = "forgot";
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

        string msg = "您的验证码是：" + code + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}