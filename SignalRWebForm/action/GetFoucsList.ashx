<%@ WebHandler Language="C#" Class="GetFoucsList" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;
public class GetFoucsList : IHttpHandler, IReadOnlySessionState
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
    /// 取消关注用户
    /// </summary>
    /// <param name="context"></param>
    public void delFoucs(HttpContext context)
    {
        int uId=0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        //UserInfoBll uClient = new UserInfoBll();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new FocusLand().AttentionState(model.uId, uId, 0, 1));
        }
    }
    /// <summary>
    /// 添加关注用户
    /// </summary>
    /// <param name="context"></param>
    public void addFoucs(HttpContext context)
    {
        int uId = 0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        //UserInfoBll uClient = new UserInfoBll();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new FocusLand().AttentionState(model.uId, uId, 1, 1));
        }
        else
        {
            context.Response.Write("您未注册！");
        }
    }
    /// <summary>
    /// 添加关注用户
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
        string FocusList = string.Empty;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        FocusInfo uFocus = new FocusInfo();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            FocusList = uFocus.Focuslist(model.uId, uId, Pagesize, pageIndex);
        }   
        context.Response.Write(FocusList);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}