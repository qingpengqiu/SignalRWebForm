<%@ WebHandler Language="C#" Class="Event_Introduction" %>

using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB4 = Erun360.BLL.DB4;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM4 = Erun360.Model.DB4;
using DBM5 = Erun360.Model.DB5;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Utils;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
using System.Text;
using System.Web;
using System.Web.SessionState;

public class Event_Introduction : IHttpHandler, IReadOnlySessionState
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
    public  void Event(HttpContext context)
    {//赛事介绍
        StringBuilder stb = new StringBuilder();
        string result = string.Empty;
        int cid = 0;//赛事id
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        if (context.Request["cid"] != null)
        {
            cid = TypeChangeDefault.NullToInt(context.Request["cid"], 0);
        }

        DBM6.tblRace_Competition mCompetetion = new DB6.tblRace_Competition().GetModel(cid);
        Hashtable good = new Hashtable();
        List<Hashtable> goodInfo = new List<Hashtable>();
        if (mCompetetion != null && mCompetetion.iStatus==1)
        {
            good.Add("cTitle", mCompetetion.cTitle);//赛事名字
            good.Add("idCompeteStyle", mCompetetion.idCompeteStyle);//赛事类型
            //good.Add("idCity",mCompetetion.idCity);//城市号
            good.Add("cCityname", mCompetetion.cCityname);//城市名字                
            good.Add("dRaceBegin", mCompetetion.dRaceBegin);//赛事开始时间
            good.Add("dRaceEnd", mCompetetion.dRaceEnd);//赛事结束时间
            good.Add("dJoinBegin", mCompetetion.dJoinBegin);//报名开始时间
            good.Add("dJoinEnd", mCompetetion.dJoinEnd);//报名结束时间
            good.Add("cContent", mCompetetion.cContent);//赛事介绍
            good.Add("dCreate", mCompetetion.dCreate);//创建时间
            good.Add("iStatus", mCompetetion.iStatus);//状态
            good.Add("idUser", mCompetetion.idUser);//创建人
            good.Add("dSubmitCreate", mCompetetion.dSubmitCreate);//提交时间
            //DBM6.tblRace_Item mCion = new DB6.tblRace_Item().GetModel(cid);
            DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
            if (uRace_Join.Exists(mCompetetion.id, TypeChangeDefault.NullToInt(mCompetetion.idUser, 0)))
            {
                good.Add("gz", "已关注");
            }
            else
            {
                good.Add("gz", "立即关注");
            }
            goodInfo.Add(good);
            IsoDateTimeConverter iso = new IsoDateTimeConverter();
            iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
            result = JsonConvert.SerializeObject(goodInfo, iso);
            context.Response.Write(result);
        }
        else
        {
            result = "{\"msg\":\"赛事未发布\",\"status\":\"2\"}";
            context.Response.Write(result);
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}