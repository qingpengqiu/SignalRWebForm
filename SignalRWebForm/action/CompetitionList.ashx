<%@ WebHandler Language="C#" Class="CompetitionList" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Erun360.BLL;
using Erun360.Model;
using System.Text;
using System.Data;
public class CompetitionList : IHttpHandler, IReadOnlySessionState
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
    /// 付款名单-分页
    /// </summary>
    /// <param name="context"></param>
    public void pay(HttpContext context)
    {
        int idCompete = TypeChangeDefault.NullToInt(context.Request["id"], 0);
         //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        //页面显示条数
        int Pagesize = 50;
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT  r.idUser, ");
        strSql.Append("(SELECT cNickName FROM [YP_DB_1].[dbo].[tblMEMBER]  where id=r.idUser) as cNickName ");
        strSql.Append(", r.cType, r.iState,r.dPay ");
        strSql.Append("FROM tblRACE_SIGNUP AS s INNER JOIN tblRACE_SALES AS r ON s.id = r.idSignUp ");
        strSql.Append("where iState>=2 and s.idCompete=" + idCompete);
        int recordCount = 0;

        DataSet ds = new DB4.tblRACE_SIGNUP().QueryByPage(strSql.ToString(), "", " dPay ", Pagesize, pageIndex, out recordCount);
        if (ds.Tables[0].Rows.Count > 0)
        {
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
        }
        else
        context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}"));
    }
    /// <summary>
    /// 关注名单-分页
    /// </summary>
    /// <param name="context"></param>
    public void Foucs(HttpContext context)
    {
        int idCompete = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);
        //页面显示条数
        int Pagesize = 50;
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT m.id, m.cAvatar, m.cNickName,j.idActivity, j.dCreate ");
        strSql.Append("FROM  YP_DB_4.dbo.tblRACE_JOIN AS j INNER JOIN ");
        strSql.Append("YP_DB_1.dbo.tblMEMBER AS m ON j.idUser = m.id ");
        int recordCount = 0;
        DataSet ds = new DB4.tblRACE_SIGNUP().QueryByPage(strSql.ToString(), "idActivity =" + idCompete, " dCreate ", Pagesize, pageIndex, out recordCount);
        if (ds.Tables[0].Rows.Count > 0)
        {
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
        }
        else
            context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}"));
    }
    /// <summary>
    /// 关注赛事
    /// </summary>
    /// <param name="context"></param>
    public void FoucsCompetetion(HttpContext context)
    {
        int uId = 0;
        if (context.Request["uId"] != null)
        {
            uId = int.Parse(context.Request["uId"].ToString());
        }
        int id = 0;
        if (context.Request["id"] != null)
        {
            id = int.Parse(context.Request["id"].ToString());
        }
        int bId = 0;
        if (context.Request["bId"] != null)
        {
            bId = int.Parse(context.Request["bId"].ToString());
        }
        if(uId==0)
        {
            context.Response.Write("nologin");
          return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        if (model == null)
        {
            context.Response.Write("nologin");
            return;
        }
        if (uId == model.uId)
        {
            DB4.tblRACE_JOIN uRace_Join = new DB4.tblRACE_JOIN();
            if (uRace_Join.Exists(id, uId))
            {
                context.Response.Write("OK");
                return;
            }
            CompetetionInfo uCompetetion = new CompetetionInfo();
            if (uCompetetion.Insert(uId, id, bId))
            {
                context.Response.Write("OK");
            }
            else
            {
                context.Response.Write("error");
                return;
            }
        }
        else
        {
            context.Response.Write("error");
            return;
        }   
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}