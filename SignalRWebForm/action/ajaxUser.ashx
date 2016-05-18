<%@ WebHandler Language="C#" Class="ajaxUser" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using Newtonsoft.Json;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Collections;
using Erun360.BLL;
public class ajaxUser : IHttpHandler, IReadOnlySessionState
{
    
    public void ProcessRequest (HttpContext context) {
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
    /// <summary>
    /// 添加关注用户
    /// </summary>
    /// <param name="context"></param>
    public void getuser(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        result = "{\"msg\":\"" + model.uId +"\",\"status\":\"1\",\"uid\":\"" + model.uId + "\",\"loginame\":\"" + model.cLoginname + "\",\"avator\":\"" + model.cAvatar + "\",\"memebertype\":\""+ model.idMemberStyle + "\",\"nickname\":\""+ model.cNickName + "\",\"mobile\":\""+ model.cMobile +"\"}";
        context.Response.Write(result);
        return;
        
    }
    /// <summary>
    /// 添加关注用户
    /// </summary>
    /// <param name="context"></param>
    public void addFoucs(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int uId = TypeChangeDefault.NullToInt(context.Request["uId"], 0);//博客id
        
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        result = new FocusLand().AttentionState(model.uId, uId, 1, 1);
        if (result == "1")
        {
            result = "{\"msg\":\"关注成功\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else if (result == "您已关注过！！！")
        {
            result = "{\"msg\":\"您已关注！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"关注失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 获取用户左侧导航
    /// </summary>
    /// <param name="context"></param>
    public void uleft(HttpContext context)
    {
        string result = string.Empty;
        int cId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            cId = user.uId;
        }    
        int uid = TypeChangeDefault.NullToInt(context.Request["uid"], 0);     
        int status = 0;
        if (uid == cId)
        {
            status = 1;
        }
        Hashtable mInfo =new Hashtable ();
        DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(uid);
        if (model != null)
        {
            mInfo.Add("id", model.id);
            mInfo.Add("cNickName", model.cNickName);
            mInfo.Add("cAvatar", model.cAvatar);
            mInfo.Add("cBio", model.cBio);
            mInfo.Add("status", status);
        }
        context.Response.Write(JsonConvert.SerializeObject(mInfo));
       
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}