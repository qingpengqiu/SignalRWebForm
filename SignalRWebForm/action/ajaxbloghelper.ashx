<%@ WebHandler Language="C#" Class="ajaxbloghelper" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Collections;
using System.Collections.Generic;
using Erun360.BLL;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Data;
using Newtonsoft.Json;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
public class ajaxbloghelper : IHttpHandler, IReadOnlySessionState
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
    /// <summary>
    /// 添加博客分组
    /// </summary>
    /// <param name="context"></param>
    public void DeleteBlogGroup(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DB2.tblBLOG_GROUP bll = new DB2.tblBLOG_GROUP();
      
        int idGroup = TypeChange.NullToInt(HttpUtility.UrlDecode(context.Request["id"]), 0);//归属

        DBM2.tblBLOG_GROUP mGroup = bll.GetModel(idGroup);

        if (mGroup == null)
        {
            result = "{\"msg\":\"该分类不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (model.uId != mGroup.idUser)
        {
            result = "{\"msg\":\"不允许删除TA的分类\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (mGroup.cTitle == "未分类")
        {
            result = "{\"msg\":\"默认分类不允许删除\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (mGroup.iNumber != 0)
        {
            result = "{\"msg\":\"该分类下有文章不允许删除\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (bll.Delete(idGroup))
        {
            result = "{\"msg\":\"删除成功\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"删除失败\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 添加博客分组
    /// </summary>
    /// <param name="context"></param>
    public void AddBlogGroup(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DB2.tblBLOG_GROUP bll = new DB2.tblBLOG_GROUP();
        DBM2.tblBLOG_GROUP mGroup = new DBM2.tblBLOG_GROUP();
        string cTitle = TypeChange.NullToString(HttpUtility.UrlDecode(context.Request["name"]), "");//归属
        if (cTitle.Trim().Length == 0 || cTitle.Trim().Length > 64)
        {
            result = "{\"msg\":\"请填写分类名称！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (bll.Exists(model.uId, cTitle.Trim()))
        {
            result = "{\"msg\":\"分类已存在！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        mGroup.cTitle = cTitle.Trim();
        mGroup.idUser = model.uId;
        mGroup.iNumber = 0;
        int finish = bll.Insert(mGroup);
        if (finish > 0)
        {
            result = "{\"msg\":\"添加成功\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"添加失败\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 获取博客分组
    /// </summary>
    /// <param name="context"></param>
    public void GetBlogGroup(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        Hashtable iteminfo = null;
        List<Hashtable> itemlist = new List<Hashtable>();
        DB2.tblBLOG_GROUP bGroup = new DB2.tblBLOG_GROUP();
        DataTable dt = bGroup.GetList(" idUser=" + model.uId).Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            iteminfo = new Hashtable();
            iteminfo.Add("id", dt.Rows[i]["id"].ToString());
            iteminfo.Add("Name", dt.Rows[i]["cTitle"].ToString());
            iteminfo.Add("Number", dt.Rows[i]["iNumber"].ToString());
            itemlist.Add(iteminfo);
        }
        context.Response.Write(JsonConvert.SerializeObject(itemlist));
    }
    /// <summary>
    /// 获取俱乐部
    /// </summary>
    /// <param name="context"></param>
    public void GetClub(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        DB4.tblRACE_CLUB_MEMBER bllClub = new DB4.tblRACE_CLUB_MEMBER();
        Hashtable iteminfo = null;
        List<Hashtable> itemlist = new List<Hashtable>();
        DataTable dt = bllClub.GetList(" iStates=2 and idUser=" + model.uId, " idClub desc ").Tables[0];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            iteminfo = new Hashtable();
            iteminfo.Add("id", dt.Rows[i]["idClub"].ToString());
            iteminfo.Add("Name", dt.Rows[i]["cClubName"].ToString());
            itemlist.Add(iteminfo);
        }
        context.Response.Write(JsonConvert.SerializeObject(itemlist));
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}