<%@ WebHandler Language="C#" Class="Validate" %>

using System;
using System.Web;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public class Validate : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["name"] != null)
        {
            string command = context.Request["name"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    public void loginCode(HttpContext context)
    {
        string result = string.Empty;
        string loginCode = TypeChangeDefault.NullToString(context.Request["txtCode"], "");//验证码
        if (loginCode.Trim().Length == 0)
        {
            result = "{\"msg\":\"请填写验证码！\",\"status\":\"n\"}";
            context.Response.Write(result);
            return;
        }

        if (loginCode.ToLower() != context.Session["loginCode"].ToString().ToLower())
        {
            result = "{\"msg\":\"验证码输入错误！\",\"status\":\"n\"}";
            context.Response.Write(result);
            return;
        }
        context.Response.Write("{ \"info\":\"验证码通过\", \"status\":\"y\" }");
        return;
    }
    public void txtLogin(HttpContext context)
    {
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        string cLoginname = TypeChangeDefault.NullToString(context.Request["param"], "");
        if (cLoginname.Trim().Length == 0)
        {
            context.Response.Write("{ \"info\":\"名称不可为空\", \"status\":\"n\" }");
            return;
        }
        if (BLL.Exists(cLoginname))
        {
            context.Response.Write("{ \"info\":\"该名称已被占用，请更换！\", \"status\":\"n\" }");
            return;
        }
        context.Response.Write("{ \"info\":\"该名称可使用\", \"status\":\"y\" }");
        return;
    }
    public void txtNick(HttpContext context)
    {
        DB1.tblMEMBER BLL = new DB1.tblMEMBER();
        string NickName = TypeChangeDefault.NullToString(context.Request["param"], "");

        if (NickName.Trim().Length == 0)
        {
            context.Response.Write("{ \"info\":\"昵称不可为空\", \"status\":\"n\" }");
            return;
        }
        if (BLL.ExistNick(NickName))
        {
            context.Response.Write("{ \"info\":\"该昵称已被占用，请更换！\", \"status\":\"n\" }");
            return;
        }
        context.Response.Write("{ \"info\":\"该昵称可使用\", \"status\":\"y\" }");
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