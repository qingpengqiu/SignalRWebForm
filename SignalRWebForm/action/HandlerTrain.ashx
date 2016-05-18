<%@ WebHandler Language="C#" Class="HandlerTrain" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.SessionState;
using Bll_DB4 = Erun360.BLL.DB4;
using DAL_DB4 = Erun360.DAL.DB4;
using MODEL_DB4 = Erun360.Model.DB4;
using Erun360.Model;
using ERUN360.Entity;

public class HandlerTrain : IHttpHandler, IReadOnlySessionState
{
    public UserInfoModel CurrentUser;
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
    public void GetTrainById(HttpContext context)
    {
        int Id = TypeChangeDefault.NullToInt(context.Request["id"], 0);//记录id
        string returnvalue = "[]";
        MODEL_DB4.tblRunning_Record AppRunningRecord = new Bll_DB4.tblRunning_Record().GetModel(Id);
        if (AppRunningRecord != null)
        {
            returnvalue = string.Format("{{\"recordId\":\"{0}\",\"uId\":\"{1}\",\"nickname\":\"{2}\",\"eventId\":\"{3}\",\"eventname\":\"{4}\",\"eventurl\":\"{5}\",\"starttime\":\"{6}\",\"distance\":\"{7}\",\"time\":\"{8}\",\"avgspeed\":\"{9}\",\"calorie\":\"{10}\",\"type\":\"{11}\",\"items\":{12}}}", AppRunningRecord.recordId, AppRunningRecord.uId, AppRunningRecord.nickname, AppRunningRecord.eventId, AppRunningRecord.eventname, AppRunningRecord.eventurl, AppRunningRecord.starttime, AppRunningRecord.distance, AppRunningRecord.time, AppRunningRecord.avgspeed, AppRunningRecord.calorie, AppRunningRecord.type, AppRunningRecord.items.Replace(" ", "").Replace("\r\n", ""));
        }
        context.Response.Write(returnvalue);
    }
    public void GetPageData(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int p = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        int pageIndex = 1;
        if (p == 0)
        {
            pageIndex = 1;
        }
        else
        {
            pageIndex = p;
        }
        int pageSize = 20;
        int recoredCount = 0;
        string wherecondition = "1=1";
        if (CurrentUser != null)
        {
            wherecondition += " And uid=" + CurrentUser.uId;
        }
        string orderfield = "recordId desc";
        DataSet pageData = new Bll_DB4.tblRunning_Record().GetListByPage(wherecondition, orderfield, pageIndex, pageSize, out recoredCount);
        StringBuilder jsonItems = new StringBuilder();
        jsonItems.Append("[");
        if (pageData != null && pageData.Tables.Count > 0 && pageData.Tables[0].Rows.Count > 0)
        {
            StringBuilder temp = new StringBuilder();
            foreach (DataRow item in pageData.Tables[0].Rows)
            {
                temp.AppendFormat("{{\"eventname\":\"{0}\",\"starttime\":\"{1}\",\"distance\":\"{2}\",\"time\":\"{3}\",\"avgspeed\":\"{4}\",\"calorie\":\"{5}\",\"recordId\":\"{6}\",\"eventurl\":\"{7}\",\"type\":\"{8}\"}},", item["eventname"].ToString(), item["starttime"].ToString(), item["distance"].ToString(), item["time"].ToString(), item["avgspeed"].ToString(), item["calorie"].ToString(), item["recordId"].ToString(), item["eventurl"].ToString(), item["type"].ToString());
            }
            if (temp.Length > 0)
            {
                jsonItems.Append(temp.ToString().Substring(0, temp.Length - 1));
            }
        }
        jsonItems.Append("]");
        DAL_DB4.tblRunning_Record DAL_RunningRecord = new DAL_DB4.tblRunning_Record();
        int totalNum = 0;
        int competitionNum = 0;
        int totalSecs = 0; ;
        double totalDistance = 0.00;
        double avgDistance = 0.00;
        wherecondition = " uid=" + CurrentUser.uId;
        totalNum = DAL_RunningRecord.GetRecordCount(wherecondition);
        wherecondition = " uid=" + CurrentUser.uId + " AND type=1";
        competitionNum = DAL_RunningRecord.GetRecordCount(wherecondition);
        wherecondition = " uid=" + CurrentUser.uId;
        totalSecs = new Bll_DB4.tblRunning_Record().GetTotalTime(wherecondition);
        totalDistance = DAL_RunningRecord.GetTotalDistance(wherecondition);
        avgDistance = DAL_RunningRecord.GetTotalDistance(wherecondition);
        string jsonresult = string.Format("{{\"totalNum\":\"{0}\",\"competitionNum\":\"{1}\",\"totalSecs\":\"{2}\",\"totalDistance\":\"{3}\",\"avgDistance\":\"{4}\",\"Count\":\"{5}\",\"items\":{6}}}", totalNum, competitionNum, totalSecs, totalDistance, avgDistance, recoredCount, jsonItems);
        jsonresult = "{\"msg\":" + jsonresult + ",\"status\":\"1\"}";
        context.Response.Write(jsonresult);
    }
    public void UpdateImage(HttpContext context)
    {
        string result = string.Empty;
        string imgPath = TypeChangeDefault.NullToString(context.Request["imgpath"], "");
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (id == 0)
        {
            result = "{\"msg\":\"非法访问！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (imgPath == "")
        {
            result = "{\"msg\":\"图片必填！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        MODEL_DB4.tblRACE_HISTORY modelOfRaceHistory = new MODEL_DB4.tblRACE_HISTORY();
        modelOfRaceHistory.id = id;
        modelOfRaceHistory.cImageUrl = imgPath;
        modelOfRaceHistory.idUser = CurrentUser.uId;
        new Bll_DB4.tblRACE_HISTORY().Update(modelOfRaceHistory);
        result = "{\"msg\":\"修改成功！\",\"status\":\"1\"}";
        context.Response.Write(result);
    }
    public void UpdateEquip(HttpContext context)
    {
        string result = string.Empty;
        string EquipIds = TypeChangeDefault.NullToString(context.Request["equipids"], "");
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result = "{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (id == 0)
        {
            result = "{\"msg\":\"非法访问！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (EquipIds == "")
        {
            result = "{\"msg\":\"请选择装备！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string cEquipment = string.Empty;
        string cEquipmentValue = string.Empty;
        string[] ca = EquipIds.Split(',');
        for (int i = 0; i < ca.Length; i++)
        {
            string[] zb = ca[i].Split('|');
            if (zb.Length > 0)
            {
                cEquipment += zb[0] + "|";
                cEquipmentValue += zb[1] + "|";
            }
        }
        MODEL_DB4.tblRACE_HISTORY modelOfRaceHistory = new Bll_DB4.tblRACE_HISTORY().GetModel(id);
        modelOfRaceHistory.idProduct = cEquipment;
        modelOfRaceHistory.cEquipment = cEquipmentValue;
        modelOfRaceHistory.idUser = CurrentUser.uId;
        new Bll_DB4.tblRACE_HISTORY().Update(modelOfRaceHistory);
        result = "{\"msg\":\"修改成功！\",\"status\":\"1\"}";
        context.Response.Write(result);
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}