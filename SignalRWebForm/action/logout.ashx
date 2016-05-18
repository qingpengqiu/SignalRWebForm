<%@ WebHandler Language="C#" Class="logout" %>

using System;
using System.Web;
using System.Web.SessionState;
using ERUN360.Entity;

public class logout : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string result = string.Empty;
        try
        {
            if (context.Request.Cookies["erunuser"] != null)
            {
                HttpCookie myCookie = new HttpCookie("erunuser");
                myCookie.Expires = DateTime.Now.AddDays(-1d);
                myCookie.Domain = "erun360.com";
                context.Response.Cookies.Add(myCookie);
            }
            
            Member m = new Member();
            m.Logout();
            //context.Session.Abandon();
            
            context.Session["CurrentUser"] = "";            
            context.Session.Remove("CurrentUser");
          
            result = "{\"msg\":\"退出成功\",\"status\":\"1\"}";
        }
        catch (Exception ex)
        {
            result = "{\"msg\":\"退出失败！\",\"status\":\"0\"}";
        }
        finally
        {
            context.Response.Write(result);
            context.Response.End();
        }
    }
    public void ClearClientPageCache(HttpContext context)
    {
        //清除浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
        context.Response.Expires = 0;
        context.Response.CacheControl = "no-cache";
        context.Response.Cache.SetNoStore();

    } 
    public bool IsReusable {
        get {
            return false;
        }
    }

}