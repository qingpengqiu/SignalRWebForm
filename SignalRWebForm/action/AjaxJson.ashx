<%@ WebHandler Language="C#" Class="AjaxJson" %>

using System;
using System.Web;
using Erun360.Model;
using System.Web.SessionState;
using Erun360.BLL;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Data;
using System.Text;

public class AjaxJson : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["command"] != null)
        {
            string command = context.Request["command"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    public void HomeList(HttpContext context)
    {
        //具体的页面数
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["pageIndex"], 0);
        //页面显示条数
        int Pagesize = TypeChangeDefault.NullToInt(context.Request["pageSize"], 0);
        int uId = TypeChangeDefault.NullToInt(context.Request["uId"], 0);
        string idGroup = TypeChangeDefault.NullToString(context.Request["group"], "0");
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (uId == model.uId)
            {
                context.Response.Write(new Homeland().ToJson(model.uId, uId, idGroup, Pagesize, pageIndex));
            }
            else
            {
                context.Response.Write(new Homeland().ToJson(model.uId, uId, idGroup, Pagesize, pageIndex));
            }
        }
        else
        {
            context.Response.Write(new Homeland().ToJson(0, uId, idGroup, Pagesize, pageIndex));
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