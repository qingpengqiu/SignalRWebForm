<%@ WebHandler Language="C#" Class="ajaxrecord" %>

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
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;

public class ajaxrecord : IHttpHandler, IReadOnlySessionState
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
    /// 拼团记录
    /// </summary>
    /// <param name="context"></param>
    public void tour(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DB1.tblShopping Bll = new DB1.tblShopping();
        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", Bll.GetRecordCount("iState>0 and iType =2 and idUser=" + user.uId));
        Info.Add("num", Bll.GetRecordCount("iState=1 and iType =2 and idUser=" + user.uId));
        DataTable dt = Bll.GetList(0, "iState>0 and iType =2 and idUser=" + user.uId, "id desc").Tables[0];
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("idGood", dt.Rows[i]["idGood"].ToString());
            item.Add("cImage", dt.Rows[i]["cImage"].ToString());
            item.Add("idOrder", dt.Rows[i]["idOrder"].ToString());
            item.Add("cGoodName", dt.Rows[i]["cGoodName"].ToString());
            item.Add("iBuyNum", dt.Rows[i]["iBuyNum"].ToString());
            item.Add("iCost", dt.Rows[i]["iCost"].ToString());
            item.Add("iState", dt.Rows[i]["iState"].ToString());
            item.Add("code", dt.Rows[i]["cMark4"].ToString());
            item.Add("codeState", GetCodeState(dt.Rows[i]["cMark4"].ToString()));
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    /// <summary>
    /// 兑换记录
    /// </summary>
    /// <param name="context"></param>
    public void cash(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DB1.tblShopping Bll = new DB1.tblShopping();

        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", Bll.GetRecordCount("iState>0 and iType =1 and idUser=" + user.uId));
        Info.Add("num", Bll.GetRecordCount("iState=1 and iType =1 and idUser=" + user.uId));
        DataTable dt = Bll.GetList(0, "iState>0 and iType =1 and idUser=" + user.uId, "id desc").Tables[0];
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("idUser", dt.Rows[i]["idUser"].ToString());
            item.Add("cImage", dt.Rows[i]["cImage"].ToString());
            item.Add("idGood", dt.Rows[i]["idGood"].ToString());            
            item.Add("idOrder", dt.Rows[i]["idOrder"].ToString());
            item.Add("cGoodName", dt.Rows[i]["cGoodName"].ToString());
            item.Add("iBuyNum", dt.Rows[i]["iBuyNum"].ToString());
            item.Add("iCost", dt.Rows[i]["iCost"].ToString() == "0.00" ? "" : dt.Rows[i]["iCost"].ToString());
            item.Add("cScore", dt.Rows[i]["cScore"].ToString());
            item.Add("iState", dt.Rows[i]["iState"].ToString());
            item.Add("code", dt.Rows[i]["cMark4"].ToString());
            item.Add("codeState", GetCodeState(dt.Rows[i]["cMark4"].ToString()));
            items.Add(item);
        }
        Info.Add("list", items);

        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    /// <summary>
    /// 机票购买记录
    /// </summary>
    /// <param name="context"></param>
    public void flight(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        DB6.tblOrder Bll = new DB6.tblOrder();
        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", Bll.GetRecordCount("iFromTpye=3 and  iStatus>0  and idUser=" + user.uId));
        Info.Add("num", Bll.GetRecordCount("iFromTpye=3 and iStatus=1  and idUser=" + user.uId));
        DataTable dt = Bll.GetList(0, "iFromTpye=3 and iStatus>-1 and idUser=" + user.uId, "dConfirmTime desc").Tables[0];
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["ID"].ToString());
            item.Add("cOrder_no", dt.Rows[i]["cOrder_no"].ToString());
            item.Add("cItemName", dt.Rows[i]["cItemName"].ToString());
            item.Add("FlightDate", dt.Rows[i]["FlightDate"].ToString());
            item.Add("iCost", dt.Rows[i]["iCost"].ToString());
            item.Add("iStatus", dt.Rows[i]["iStatus"].ToString());
            item.Add("dConfirmTime", Convert.ToDateTime(dt.Rows[i]["dConfirmTime"].ToString()).ToString("yyyy-MM-dd"));
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    public string GetCodeState(string code)
    {
        DataTable dt = new DB5.tblCode().GetList("idCode='" + code + "'").Tables[0];
        if (dt.Rows.Count > 0)
        {
            string isUse = dt.Rows[0]["isUse"].ToString();
            if (isUse == "0")
            {
                return "未使用";
            }
            else if (isUse == "1")
            {
                return "已使用";
            }
            else
            {
                return "未使用";
            }
        }
        else
            return "";
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}