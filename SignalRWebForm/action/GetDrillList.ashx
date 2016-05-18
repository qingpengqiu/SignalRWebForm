<%@ WebHandler Language="C#" Class="GetDrillList" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB4 = Erun360.BLL.DB4;
using DB2 = Erun360.BLL.DB2;

public class GetDrillList : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        if (context.Request["command"] != null)
        {
            string command = context.Request["command"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
        //context.Response.Write("Hello World");
    }
    /// <summary>
    /// 提交训练成绩
    /// </summary>
    /// <param name="context"></param>
    public void AddDrill(HttpContext context)
    {
        int uId = 0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        int id = 0;
        if (context.Request["id"] != null)
        {
            id = int.Parse(context.Request["id"].ToString());
        }
        context.Response.Write("ok");
        //DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        //if (uRace_History.Delete(uId, id))
        //{
        //    context.Response.Write("ok");
        //}
        //else
        //{
        //    context.Response.Write("呀，没删掉！稍后在试试呗！！");
        //}
    }
    /// <summary>
    /// 删除训练成绩
    /// </summary>
    /// <param name="context"></param>
    public void delDrill(HttpContext context)
    {
        int uId = 0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        int id = 0;
        if (context.Request["id"] != null)
        {
            id = int.Parse(context.Request["id"].ToString());
        }
        DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        if (uRace_History.Delete(uId, id))
        {
            new DB2.tblActivity().DeleteByidBlog(id, uId);
            context.Response.Write("ok");
        }
        else
        {
            context.Response.Write("呀，没删掉！稍后在试试呗！！");
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}