<%@ WebHandler Language="C#" Class="ClubList" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;

public class ClubList : IHttpHandler, IReadOnlySessionState
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
    /// 申请，审核，退出俱乐部
    /// </summary>
    /// <param name="context"></param>
    public void Join(HttpContext context)
    {
        int tag = -1;//-1未登录，0申请俱乐部，1审核通过，2退出俱乐部
        int idClub = 0;
        int state = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }
            if (context.Request["state"] != null)
            {
                state = Convert.ToInt32(context.Request["state"]);
            }
            
        }
        
        context.Response.Write(tag);

    }
    /// <summary>
    /// 俱乐部简介
    /// </summary>
    /// <param name="context"></param>
    public void Bio(HttpContext context)
    {

        int idClub = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }

        }

        context.Response.Write("");

    }
    /// <summary>
    /// 俱乐部公告
    /// </summary>
    /// <param name="context"></param>
    public void Notice(HttpContext context)
    {
  
        int idClub = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }
           
        }

        context.Response.Write("");

    }
    /// <summary>
    /// 置顶
    /// </summary>
    /// <param name="context"></param>
    public void ZDing(HttpContext context)
    {

        int idClub = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }

        }

        context.Response.Write("");
    }
    /// <summary>
    /// 删除博文
    /// </summary>
    /// <param name="context"></param>
    public void deleteBolg(HttpContext context)
    {

        int idClub = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }

        }

        context.Response.Write("");

    }
    /// <summary>
    /// 删除讨论
    /// </summary>
    /// <param name="context"></param>
    public void deldscs(HttpContext context)
    {

        int idClub = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (context.Request["idClub"] != null)
            {
                idClub = Convert.ToInt32(context.Request["idClub"]);
            }

        }

        context.Response.Write("");

    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}