<%@ WebHandler Language="C#" Class="ajaxevent" %>

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

public class ajaxevent : IHttpHandler, IReadOnlySessionState
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
    /// 全部赛事
    /// </summary>
    /// <param name="context"></param>
    public void allevent(HttpContext context)
    {
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数

        string strWhere = @"SELECT id, idBlog, idCompeteStyle, idCity, cCityname, cTitle, dRaceBegin, dRaceEnd, dJoinBegin, dJoinEnd, dCreate
                                FROM YP_DB_4.dbo.tblRACE_COMPETETION
                                union all
                                SELECT id, '0' idBlog,idCompeteStyle, idCity, cCityname, cTitle, dRaceBegin, dRaceEnd, dJoinBegin, dJoinEnd, dCreate
                                FROM YP_DB_6.dbo.tblRace_Competition
                                 where iStatus =1";
        DB4.tblRACE_COMPETETION bll = new DB4.tblRACE_COMPETETION();
        DB6.tblRace_Competition bllnew = new DB6.tblRace_Competition();
        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", bll.GetRecordCount("") + bllnew.GetRecordCount("iStatus =1"));
        DataTable dt = bll.QueryByPage(strWhere.ToString(), "", " dRaceBegin  desc", Pagesize, pageIndex).Tables[0];
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("idBlog", dt.Rows[i]["idBlog"].ToString());
            item.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
            item.Add("cCityname", dt.Rows[i]["cCityname"].ToString());
            item.Add("dRaceBegin", Convert.ToDateTime(dt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));

            if (DateTime.Now > Convert.ToDateTime(dt.Rows[i]["dJoinEnd"].ToString()))
            {
                item.Add("dJoinBegin", "报名截止");
            }
            else
            {
                item.Add("dJoinBegin", Convert.ToDateTime(dt.Rows[i]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm"));
            }
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    /// <summary>
    /// 关注赛事
    /// </summary>
    /// <param name="context"></param>
    public void foucsevent(HttpContext context)
    {
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        int uId = TypeChangeDefault.NullToInt(HttpUtility.UrlDecode(context.Request["uId"]), 0);

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            if (uId == 0)
                uId = user.uId;
        }
        DB4.tblRACE_COMPETETION uCompetetion = new DB4.tblRACE_COMPETETION();
        DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
        string ids = uRace_Join.GetFoucsCompetetionList(uId);

        string strWhere = @"SELECT id, idBlog, idCompeteStyle, idCity, cCityname, cTitle, dRaceBegin, dRaceEnd, dJoinBegin, dJoinEnd, dCreate
                                FROM YP_DB_4.dbo.tblRACE_COMPETETION
                                union all
                                SELECT id, '0' idBlog,idCompeteStyle, idCity, cCityname, cTitle, dRaceBegin, dRaceEnd, dJoinBegin, dJoinEnd, dCreate
                                FROM YP_DB_6.dbo.tblRace_Competition
                                 where iStatus =1";
        DataTable dt = uCompetetion.QueryByPage(strWhere, " id in( " + ids + ")", "dRaceEnd desc", Pagesize, pageIndex).Tables[0];

        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", uRace_Join.GetRecordCount("LEFT([idActivity],1)=3  and idUser=" + uId));
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("idBlog", dt.Rows[i]["idBlog"].ToString());
            item.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
            item.Add("cCityname", dt.Rows[i]["cCityname"].ToString());
            item.Add("dRaceBegin", Convert.ToDateTime(dt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));
            if (DateTime.Now > Convert.ToDateTime(dt.Rows[i]["dJoinEnd"].ToString()))
            {
                item.Add("dJoinBegin", "报名截止");
            }
            else
            {
                item.Add("dJoinBegin", Convert.ToDateTime(dt.Rows[i]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm"));
            }
            //item.Add("dJoinBegin", Convert.ToDateTime(dt.Rows[i]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm"));
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    /// <summary>
    /// 报名赛事
    /// </summary>
    /// <param name="context"></param>
    public void signupevent(HttpContext context)
    {
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        //int uId = TypeChangeDefault.NullToInt(HttpUtility.UrlDecode(context.Request["uId"]), 0);
        int uId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            uId = user.uId;
        }

        DB4.tblRACE_COMPETETION uCompetetion = new DB4.tblRACE_COMPETETION();

        string strWhere = @"SELECT     a.id, a.idBlog, a.cTitle, b.cType, c.iState, c.iCost, c.cMember, c.cScore ,a.dRaceBegin,c.idOrder,idSignUp as iItemID ,c.dCreate as dCreateTime 
                                FROM  tblRACE_COMPETETION AS a INNER JOIN tblRACE_SIGNUP AS b ON a.id = b.idCompete INNER JOIN
                                  tblRACE_SALES AS c ON b.id = c.idSignUp
                                WHERE     (c.idUser = " + uId + @") and c.iState>=0
                                union all
                                SELECT  iTypeID as id ,'0' as idBlog, iTypeName as cTitle,cItemName as cType,iStatus, iCost ,''as cMember,''as cScore,FlightDate,cOrder_no,iItemID ,dCreateTime 
                                FROM  YP_DB_6.dbo.tblOrder
                                WHERE (idUser = " + uId + ") AND (iFromTpye =2) and iStatus>=0";
        DataTable dt = uCompetetion.QueryByPage(strWhere, "", "dCreateTime desc", Pagesize, pageIndex).Tables[0];
        Hashtable Info = null;
        Info = new Hashtable();
        DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
        DB6.tblOrder bllnew = new DB6.tblOrder();
        Info.Add("count", bllsales.GetRecordCount("iState>=0 and idUser=" + uId) + bllnew.GetRecordCount("idUser=" + uId + " and  iFromTpye=2 and iStatus>=0"));
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());
            item.Add("idBlog", dt.Rows[i]["idBlog"].ToString());
            item.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
            item.Add("iCost", dt.Rows[i]["iCost"].ToString());
            //item.Add("iState", GetSignUpStatus(dt.Rows[i]["iState"].ToString()));
            item.Add("cMember", dt.Rows[i]["cMember"].ToString());
            item.Add("cScore", dt.Rows[i]["cScore"].ToString());
            item.Add("idOrder", dt.Rows[i]["idOrder"].ToString());
            item.Add("dRaceBegin", Convert.ToDateTime(dt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));
            string idblog = dt.Rows[i]["idBlog"].ToString().Trim();
            if (dt.Rows[i]["iState"].ToString() == "0")
            {
                item.Add("iState", "待审核");
                if (idblog == "0")
                {
                    item.Add("url", "/Competetion/OrderDetails.aspx?sid=" + dt.Rows[i]["id"].ToString() + "&nav=2&orderid=" + dt.Rows[i]["idOrder"].ToString());
                }
                else
                {
                    item.Add("url", "/Channels/Competetion/RaceProject.aspx?idcompete=" + dt.Rows[i]["id"].ToString());
                }
            }
            else if (dt.Rows[i]["iState"].ToString() == "1")
            {
                item.Add("iState", "去付款");
                if (idblog == "0")
                {
                    item.Add("url", "/Competetion/OrderDetails.aspx?sid=" + dt.Rows[i]["id"].ToString() + "&nav=2&orderid=" + dt.Rows[i]["idOrder"].ToString());
                }
                else
                {
                    item.Add("url", "/Channels/Competetion/RacePay.aspx?orderid=" + dt.Rows[i]["idOrder"].ToString());
                }
            }
            else if (dt.Rows[i]["iState"].ToString() == "2")
            {
                int idItem = TypeChangeDefault.NullToInt(dt.Rows[i]["iItemID"], 0);
                if (idblog == "0")
                {
                    DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(idItem);
                    if (modelItem != null)
                    {
                        if (modelItem.iType == 3)
                        {
                            item.Add("iState", "去组队");
                            item.Add("url", "/Competetion/Team.aspx?sid=" + modelItem.idCompete + "&p=" + idItem);
                        }
                        else
                        {
                            item.Add("iState", "已付款");
                            item.Add("url", "");
                        }
                    }
                    else
                    {
                        item.Add("iState", "已付款");
                        item.Add("url", "");
                    }
                }
                else
                {
                    DBM4.tblRACE_SIGNUP modelItem = new DB4.tblRACE_SIGNUP().GetModel(idItem);
                    if (modelItem != null)
                    {
                        if (modelItem.iType == 3)
                        {
                            item.Add("iState", "去组队");
                            item.Add("url", "/Channels/Competetion/Team.aspx?p=" + idItem);
                        }
                        else
                        {
                            item.Add("iState", "已付款");
                            item.Add("url", "");
                        }
                    }
                    else
                    {
                        item.Add("iState", "已付款");
                        item.Add("url", "");
                    }
                }
            }
            else if (dt.Rows[i]["iState"].ToString() == "3")
            {
                if (idblog == "0")
                {
                    item.Add("iState", "已组队");
                    item.Add("url", "/Competetion/Team.aspx?sid=" + dt.Rows[i]["id"].ToString() + "&p=" + dt.Rows[i]["iItemID"].ToString());

                }
                else
                {
                    item.Add("iState", "已组队");
                    item.Add("url", "/blog/" + dt.Rows[i]["idBlog"].ToString().Trim() + ".aspx");
                }

            }
            else
            {
                item.Add("iState", "已过期");
                item.Add("url", "");
            }
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));


    }
    /// <summary>
    /// 发布赛事
    /// </summary>
    /// <param name="context"></param>
    public void myevent(HttpContext context)
    {
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        DB6.tblRace_Competition bllevent = new DB6.tblRace_Competition();
        int cId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            cId = user.uId;
        }
        DataTable dt = bllevent.GetListByPage("idUser=" + cId, "dCreate desc", pageIndex, Pagesize).Tables[0];
        Hashtable Info = null;
        Info = new Hashtable();
        Info.Add("count", bllevent.GetRecordCount("idUser=" + cId));
        Hashtable item = null;
        List<Hashtable> items = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            item = new Hashtable();
            item.Add("id", dt.Rows[i]["id"].ToString());

            item.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
            item.Add("cCityname", dt.Rows[i]["cCityname"].ToString());
            item.Add("dRaceBegin", Convert.ToDateTime(dt.Rows[i]["dRaceBegin"].ToString()).ToString("yyyy-MM-dd"));
            item.Add("iStatus", GetMyStatus(dt.Rows[i]["iStatus"].ToString()));
            items.Add(item);
        }
        Info.Add("list", items);
        context.Response.Write(JsonConvert.SerializeObject(Info));
    }
    private string GetMyStatus(string iStatus)
    {
        string result = string.Empty;
        int Status = TypeChangeDefault.NullToInt(iStatus, -1);
        switch (Status)
        {
            case 0:
                result = "草稿"; break;
            case 1:
                result = "已发布"; break;
            default:
                result = "草稿"; break;
        }
        return result;
    }
    private string GetSignUpStatus(string iStatus)
    {
        string result = string.Empty;
        int Status = TypeChangeDefault.NullToInt(iStatus, -1);
        switch (Status)
        {
            case 0:
                result = "待审核"; break;
            case 1:
                result = "待付款"; break;
            case 2:
                result = "已付款"; break;
            case 3:
                result = "已组队"; break;
            default:
                result = "已过期"; break;
        }
        return result;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}