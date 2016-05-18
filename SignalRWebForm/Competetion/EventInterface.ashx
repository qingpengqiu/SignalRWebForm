<%@ WebHandler Language="C#" Class="EventInterface" %>

using System;
using System.Web;
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
using System.Web.SessionState;
public class EventInterface : IHttpHandler, IReadOnlySessionState
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

    public void Insert(HttpContext context)
    {//关注
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int uId = TypeChangeDefault.NullToInt(context.Request["uid"], 0);
        int cid = TypeChangeDefault.NullToInt(context.Request["cid"], 0);
        //DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(bId);
        DBM6.tblRace_Competition mBlog = new DB6.tblRace_Competition().GetModel(cid);
        UserInfoModel mClient = new UserInfoBll().Find(uId);
        DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
        DBM4.tblRACE_JOIN mRace_Join = new DBM4.tblRACE_JOIN();
        int cout = new DB4.tblRACE_JOIN().GetRecordCount("idActivity ="+ cid +" and idUser="+uId);
        mRace_Join.idOnwer = mBlog.idUser;
        mRace_Join.idActivity = cid;
        mRace_Join.idUser = mClient.uId;
        mRace_Join.cLoginname = mClient.cNickName;
        if (cout < 1)
        {
            if (uRace_Join.Add(mRace_Join) > 0)
            {
                //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                //// 发布者积分
                //uMember_History.Insert(mBlog.idUser, 200810016, 1);
                //// 参与者积分                
                //uMember_History.Insert(uId, 200810015, 1);
                //被关注
                //new DB1.tblIntegral().InsertScore(mBlog.idUser, 200810016, 1, 0);
                //关注
                new DB1.tblIntegral().InsertScore(uId, 200810015, 1, 0);
                //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布21博文/22赛事/23装备/24训练，3评论31留言/32博文/33赛事/34/装备
                DBM2.tblActivity mActivity = new DBM2.tblActivity();
                mActivity.idUser = uId;
                mActivity.cNickName = mClient.cNickName;
                mActivity.cAvatar = mClient.cAvatar;
                mActivity.idBlog = cid;
                mActivity.idGroup = "13";
                mActivity.cTitle = mBlog.cTitle;
                new DB2.tblActivity().Add(mActivity);
                result = "{\"msg\":\"关注成功\",\"status\":\"1\"}";
                context.Response.Write(result);
            }
            else
            {
                result = "{\"msg\":\"关注失败\",\"status\":\"2\"}";
                context.Response.Write(result);
            }
        }
        else
        {
            if (uRace_Join.Delete(cid, uId))
            {
                result = "{\"msg\":\"取消关注成功\",\"status\":\"3\"}";
                context.Response.Write(result);
            }
            else
            {
                result = "{\"msg\":\"取消关注失败\",\"status\":\"4\"}";
                context.Response.Write(result);
            }
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}