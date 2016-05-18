<%@ WebHandler Language="C#" Class="Advert" %>

using System;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;
using Erun360.Model;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using Newtonsoft.Json.Converters;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;

public class Advert : IHttpHandler 
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        Hashtable googd = new Hashtable();
        List<Hashtable> gameList = new List<Hashtable>();
        string str = string.Empty;
        if (id > 0)
        {
            //DataTable ds = new DB6.tblAdvert().GetList("begintime < '" + DateTime.Now + "' and '" + DateTime.Now + "' < endtime and cState =2 and cPosition =" + id).Tables[0];
            DBM6.tblOrder modl = new DBM6.tblOrder();
            modl.ID = id;
            modl.iStatus = 1;
            bool i = new DB6.tblOrder().Update(modl);
            if (i)
            {
                context.Response.Write("审核通过");

                DBM6.tblOrder msignpu = new DB6.tblOrder().GetModel(id);
                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                disModel.cContent = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + msignpu.cFromToID + "&nav=1\">" + msignpu.cFromToName + "</a>》审核通过！请您去付款，谢谢！";
                disModel.idInfo = msignpu.idUser;
                disModel.idUser = 100001183;
                disModel.cLoginname = "益跑赛事";
                // disModel.dCreate = DateTime.Now;
                int imessage = disBll.Add(disModel);
                if (imessage > 0)
                {
                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                    mMessage.cId = 100001183;
                    mMessage.uId = msignpu.idUser;
                    mMessage.itype = 31;
                    mMessage.idcode = imessage;
                    int test = new DB3.tblMessage().Add(mMessage);
                }
            }
            else
            {
                context.Response.Write("审核未通过");  
            }
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}