<%@ WebHandler Language="C#" Class="equip" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;
public class equip : IHttpHandler,IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        if (context.Request["m"] != null)
        {
            string command = context.Request["m"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    /// <summary>
    /// 取消关注博客
    /// </summary>
    /// <param name="context"></param>
    public void qxgz(HttpContext context)
    {
        int idBlog = TypeChangeDefault.NullToInt(context.Request["b"], 0);//当前用户id
       
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new FocusLand().AttentionState(model.uId, idBlog, 0, 2));
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}