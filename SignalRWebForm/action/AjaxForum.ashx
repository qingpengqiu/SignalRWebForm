<%@ WebHandler Language="C#" Class="AjaxForum" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using Newtonsoft.Json;
using Erun360.Model;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
public class AjaxForum : IHttpHandler, IReadOnlySessionState
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
    /// 回复评论，只给回复人留言
    /// </summary>
    /// <param name="context"></param>
    public void replyforum(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int iMood = TypeChangeDefault.NullToInt(context.Request["pt"], 0);//讨论组类型//0赛事咨询，1参赛者讨论组，2同城讨论组  
        int idUser = TypeChangeDefault.NullToInt(context.Request["user"], 0);//被回复人id
        int idRace = TypeChangeDefault.NullToInt(context.Request["idrace"], 0);//被评论编码（赛事id）
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (strMsg.Trim().Length > 256 || strMsg.Trim().Length == 0)
        {
            result = "{\"msg\":\"内容为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(idRace);
        if (modelrace == null)
        {
            result = "{\"msg\":\"赛事不存在，不允许评论！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);
        if (user == null)
        {
            result = "{\"msg\":\"提交失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
        disModel.cLoginname = model.cNickName;
        disModel.cContent = "回复  <a target=\"_blank\" href=\"/user/" + user.id + ".aspx\">" + user.cNickName + "</a>:" + strMsg;
        disModel.idUser = model.uId;
        disModel.idInfo = idRace;
        DB6.tblRace_Detail race = new DB6.tblRace_Detail();
        if (iMood == 1)
        {
            if (modelrace.idUser == model.uId || model.idMemberStyle == 99)
            {
                disModel.iMood = 2;
            }
            else
            {
                int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + model.uId);
                if (count == 0)
                {
                    result = "{\"msg\":\"您未报名赛事,提交失败！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                disModel.iMood = 2;
            }
        }
        else if (iMood == 2)
        {
            int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + model.uId);
            if (count == 0)
            {
                result = "{\"msg\":\"您未报名赛事,提交失败！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            disModel.iMood = model.idCity;
        }
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            if (model.uId != idUser)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                //插入回复 新版赛事回复评论41
                mMessage.cId = model.uId;
                mMessage.uId = idUser;
                mMessage.itype = 41;//评论回复 类型为39
                mMessage.idcode = imessage;
                mMessage.bId = idRace;
                new DB3.tblMessage().Add(mMessage);
            }
            result = "{\"msg\":\"提交成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"提交失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }


    }
    //添加留言
    public void addforums(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int iMood = TypeChangeDefault.NullToInt(context.Request["pt"], 0);//讨论组类型//0赛事咨询，1参赛者讨论组，2同城讨论组  
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (strMsg.Trim().Length > 256 || strMsg.Trim().Length == 0)
        {
            result = "{\"msg\":\"内容超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idRace = TypeChangeDefault.NullToInt(context.Request["idrace"], 0);//被评论编码（赛事id）
        DB6.tblRace_Competition bll = new DB6.tblRace_Competition();
        DBM6.tblRace_Competition modelrace = bll.GetModel(idRace);
        if (modelrace == null)
        {
            result = "{\"msg\":\"赛事不存在，不允许评论！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        DB6.tblRace_Detail race = new DB6.tblRace_Detail();

        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
        disModel.cLoginname = model.cNickName;
        disModel.cContent = strMsg.Trim();
        disModel.idInfo = idRace;
        disModel.idUser = model.uId;
        if (iMood == 1)
        {
            if (modelrace.idUser == model.uId || model.idMemberStyle == 99)
            {
                disModel.iMood = 2;
            }
            else
            {
                int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + model.uId);
                if (count == 0)
                {
                    result = "{\"msg\":\"您未报名赛事,提交失败！\",\"status\":\"0\"}";
                    context.Response.Write(result);
                    return;
                }
                disModel.iMood = 2;
            }
        }
        else if (iMood == 2)
        {
            int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + model.uId);
            if (count == 0)
            {
                result = "{\"msg\":\"您未报名赛事,提交失败！\",\"status\":\"0\"}";
                context.Response.Write(result);
                return;
            }
            disModel.iMood = model.idCity;
        }
        // disModel.dCreate = DateTime.Now;
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            if (model.uId != modelrace.idUser)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                //新版赛事咨询40
                mMessage.cId = model.uId;
                mMessage.uId = modelrace.idUser;
                mMessage.itype = 40;//评论回复 类型为37
                mMessage.idcode = imessage;
                mMessage.bId = idRace;
                new DB3.tblMessage().Add(mMessage);
            }
            result = "{\"msg\":\"提交成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;

        }
        else
        {
            result = "{\"msg\":\"提交失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    //显示评论信息
    public void forums(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idrace"], 0);//被评论编码（赛事id）
        int iMood = TypeChangeDefault.NullToInt(context.Request["pt"], 0);//讨论组类型//0赛事咨询，1参赛者讨论组，2同城讨论组       
        DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(idRace);
        if (model == null)
        {
            context.Response.Write("{\"msg\":\"小伙伴迷失了！\",\"status\":\"-2\"}");
            return;
        }
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);//当前页数        
        int Pagesize = 20;//显示条数

        DB3.tblDISCUSS bll = new DB3.tblDISCUSS();
        DataTable dt = new DataTable();
        if (iMood != 0)
        {
            int idUser = 0;
            int idCity = 0;
            int isadmin = 0;
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
                idUser = user.uId;
                idCity = user.idCity ?? 0;
                isadmin = user.idMemberStyle ?? 0;
            }
            DB6.tblRace_Detail race = new DB6.tblRace_Detail();

            if (iMood == 1)//参赛者
            {
                if (model.idUser == idUser || isadmin == 99)
                {
                    dt = bll.GetListByPage(" idInfo='" + idRace + "' and iMood=2", " dCreate desc ", pageIndex, Pagesize, idRace).Tables[0];
                }
                else
                {

                    int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + idUser);
                    if (count > 0)
                    {
                        dt = bll.GetListByPage(" idInfo='" + idRace + "' and iMood=2", " dCreate desc ", pageIndex, Pagesize, idRace).Tables[0];
                    }
                    else
                    {
                        context.Response.Write("{\"msg\":\"您未报名该赛事！\",\"status\":\"0\"}");
                        return;
                    }
                }
            }
            else if (iMood == 2)//同城
            {
                int count = race.GetRecordCount("idCompete=" + idRace + " and idUser=" + idUser + " and idCity=" + idCity);
                if (count > 0)
                {
                    if (TypeChangeDefault.NullToString(idCity, "0").Length == 3)
                    {
                        dt = bll.GetListByPage(" idInfo='" + idRace + "' and LEN(iMood)=3  and LEFT(iMood,1)=" + TypeChangeDefault.NullToString(idCity, "0").Trim().Substring(0, 1), " dCreate desc ", pageIndex, Pagesize, idRace).Tables[0];
                        //iCity = TypeChangeDefault.NullToString(idCity, "0").Trim().Substring(0, 1);
                        //iArea = TypeChangeDefault.NullToString(idCity, "0").Substring(1, 2);
                    }
                    else if (TypeChangeDefault.NullToString(idCity, "0").Length == 4)
                    {
                        dt = bll.GetListByPage(" idInfo='" + idRace + "' and LEN(iMood)=4 and LEFT(iMood,2)=" + TypeChangeDefault.NullToString(idCity, "0").Trim().Substring(0, 2), " dCreate desc ", pageIndex, Pagesize, idRace).Tables[0];
                        //iCity = TypeChangeDefault.NullToString(idCity, "0").Trim().Substring(0, 2);
                        //iArea = TypeChangeDefault.NullToString(idCity, "0").Substring(2, 2);
                    }
                }
                else
                {
                    context.Response.Write("{\"msg\":\"您未报名该赛事！\",\"status\":\"0\"}");
                    return;
                }
            }
        }
        else
        {
            dt = bll.GetListByPage(" idInfo='" + idRace + "' and iMood=" + iMood, " dCreate desc ", pageIndex, Pagesize, idRace).Tables[0];
        }

        Hashtable RaceInfo = null;
        List<Hashtable> RaceInfoList = new List<Hashtable>();
        if (dt.Rows.Count > 0)
        {
            DB1.tblMEMBER userbll = new DB1.tblMEMBER();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                RaceInfo = new Hashtable();
                RaceInfo.Add("User", userbll.GetPerson(TypeChangeDefault.NullToInt(dt.Rows[i]["idUser"].ToString(), 0)).Tables[0]);
                RaceInfo.Add("cContent", dt.Rows[i]["cContent"].ToString());
                RaceInfo.Add("dCreate", dt.Rows[i]["dCreate"].ToString());
                RaceInfoList.Add(RaceInfo);
            }
        }
        else
        {
            context.Response.Write("{\"msg\":\"暂无评论内容！\",\"status\":\"1\"}");
            return;
        }
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(RaceInfoList, iso));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}