<%@ WebHandler Language="C#" Class="GetFansList" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;

public class GetFansList : IHttpHandler, IReadOnlySessionState
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
    }
    /// <summary>
    /// 粉丝列表
    /// </summary>
    /// <param name="context"></param>
    public void List(HttpContext context)
    {
        //具体的页面数
        int pageIndex;
        int.TryParse(context.Request["pageIndex"], out pageIndex);

        //页面显示条数
        int Pagesize = Convert.ToInt32(context.Request["pageSize"]);

        if (pageIndex == 0)
        {
            pageIndex = 1;
        }

        int uId = 0;
        string FansList = string.Empty;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            FansInfo uFans = new FansInfo();
            FansList = uFans.Fanslist(model.uId, uId, Pagesize, pageIndex);
        }
        context.Response.Write(FansList);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}