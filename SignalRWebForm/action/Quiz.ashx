<%@ WebHandler Language="C#" Class="Quiz" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB1 = Erun360.BLL.DB1;
using System.Data;
using Erun360.Model;
using System.Web.SessionState;
public class Quiz : IHttpHandler, IReadOnlySessionState
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
    //益跑乐视2016东京马拉松女子组竞猜赢手机
    public void tokyo_woman(HttpContext context)
    {
        string result = string.Empty;
        int idItem = 4;//TypeChangeDefault.NullToInt(context.Request["id"], 2);//项目
        int idMin = TypeChangeDefault.NullToInt(context.Request["idMin"], 0);//点击的那个选项
        string cMinName = TypeChangeDefault.NullToString(context.Request["cMinName"], "");// 完赛时间      
        int iAmount = TypeChangeDefault.NullToInt(context.Request["iAmount"], 0);//竞投的积分
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您没登录！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now > DateTime.Parse("2016-02-27 22:10"))
        {
            result = "{\"msg\":\"竞猜还没开始或者已结束！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DBM5.tblQuiz ddsm = new DBM5.tblQuiz();
        DB5.tblQuiz bll = new DB5.tblQuiz();
        int count = bll.GetRecordCount("idItem=" + idItem + " and idUser = " + model.uId);
        if (count > 0)
        {
            result = "{\"msg\":\"您已参与竞猜！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (iAmount == 0 || iAmount > 2000)
        {
            result = "{\"msg\":\"竞猜积分大于0小于2000！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (iAmount < 0)
        {
            result = "{\"msg\":\"竞猜积分不能小于0！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int ys = iAmount % 100;
        if (ys != 0)
        {
            result = "{\"msg\":\"请输入100的整数倍！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + model.uId, model.uId);
        if (iAmount > isout)
        {
            result = "{\"msg\":\"您的积分不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM5.tblQuiz modlquiz = new DBM5.tblQuiz();
        modlquiz.idUser = model.uId;
        modlquiz.idItem = idItem;
        modlquiz.cItemName = "2016益跑乐视东京马拉松女子组竞猜赢手机";
        modlquiz.idMin = idMin;
        modlquiz.cMinName = cMinName;
        modlquiz.iAmount = iAmount;
        modlquiz.dCreate = DateTime.Now;
        int i = new DB5.tblQuiz().Add(modlquiz);
        if (i > 0)
        {
            new DB1.tblIntegral().InsertScore(model.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(iAmount, 0), "竞猜花费积分");
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
    //益跑乐视2016东京马拉松男子组竞猜赢手机
    public void tokyo_man(HttpContext context)
    {
        string result = string.Empty;
        int idItem = 3;//TypeChangeDefault.NullToInt(context.Request["id"], 2);//项目
        int idMin = TypeChangeDefault.NullToInt(context.Request["idMin"], 0);//点击的那个选项
        string cMinName = TypeChangeDefault.NullToString(context.Request["cMinName"], "");// 完赛时间      
        int iAmount = TypeChangeDefault.NullToInt(context.Request["iAmount"], 0);//竞投的积分
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您没登录！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now > DateTime.Parse("2016-02-27 22:10"))
        {
            result = "{\"msg\":\"竞猜还没开始或者已结束！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DBM5.tblQuiz ddsm = new DBM5.tblQuiz();
        DB5.tblQuiz bll = new DB5.tblQuiz();
        int count = bll.GetRecordCount("idItem=" + idItem + " and idUser = " + model.uId);
        if (count > 0)
        {
            result = "{\"msg\":\"您已参与竞猜！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (iAmount == 0 || iAmount > 2000)
        {
            result = "{\"msg\":\"竞猜积分大于0小于2000！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (iAmount < 0)
        {
            result = "{\"msg\":\"竞猜积分不能小于0！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int ys = iAmount % 100;
        if (ys != 0)
        {
            result = "{\"msg\":\"请输入100的整数倍！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + model.uId, model.uId);
        if (iAmount > isout)
        {
            result = "{\"msg\":\"您的积分不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM5.tblQuiz modlquiz = new DBM5.tblQuiz();
        modlquiz.idUser = model.uId;
        modlquiz.idItem = idItem;
        modlquiz.cItemName = "2016益跑乐视东京马拉松男子组竞猜赢手机";
        modlquiz.idMin = idMin;
        modlquiz.cMinName = cMinName;
        modlquiz.iAmount = iAmount;
        modlquiz.dCreate = DateTime.Now;
        int i = new DB5.tblQuiz().Add(modlquiz);
        if (i > 0)
        {
            new DB1.tblIntegral().InsertScore(model.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(iAmount, 0), "竞猜花费积分");
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
    //益跑乐视纽约马拉松竞猜赢手机
    public void letv(HttpContext context)
    {
        string result = string.Empty;
        int idItem = 2;//TypeChangeDefault.NullToInt(context.Request["id"], 2);//项目
        int idMin = TypeChangeDefault.NullToInt(context.Request["idMin"], 0);//点击的那个选项
        string cMinName = TypeChangeDefault.NullToString(context.Request["cMinName"], "");// 完赛时间      
        int iAmount = TypeChangeDefault.NullToInt(context.Request["iAmount"], 0);//竞投的积分
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您没登录！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now > DateTime.Parse("2015-11-01 22:10"))
        {
            result = "{\"msg\":\"竞猜还没开始或者已结束！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DBM5.tblQuiz ddsm = new DBM5.tblQuiz();
        DB5.tblQuiz bll = new DB5.tblQuiz();
        int count = bll.GetRecordCount("idItem=" + idItem + " and idUser = " + model.uId);
        if (count > 0)
        {
            result = "{\"msg\":\"您已参与竞猜！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (iAmount == 0 || iAmount > 2000)
        {
            result = "{\"msg\":\"竞猜积分大于0小于2000！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int ys = iAmount % 100;
        if (ys != 0)
        {
            result = "{\"msg\":\"请输入100的整数倍！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + model.uId, model.uId);
        if (iAmount > isout)
        {
            result = "{\"msg\":\"您的积分不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM5.tblQuiz modlquiz = new DBM5.tblQuiz();
        modlquiz.idUser = model.uId;
        modlquiz.idItem = 2;
        modlquiz.cItemName = "益跑乐视纽约马拉松竞猜赢手机";
        modlquiz.idMin = idMin;
        modlquiz.cMinName = cMinName;
        modlquiz.iAmount = iAmount;
        modlquiz.dCreate = DateTime.Now;
        int i = new DB5.tblQuiz().Add(modlquiz);
        if (i > 0)
        {
            new DB1.tblIntegral().InsertScore(model.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(iAmount, 0), "竞猜花费积分");
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
    //雪娇大北备战记竞猜成绩赢积分
    public void ajiao(HttpContext context)
    {
        string result = string.Empty;
        int idItem = 2;//TypeChangeDefault.NullToInt(context.Request["id"], 2);//项目
        int idMin = TypeChangeDefault.NullToInt(context.Request["idMin"], 0);//点击的那个选项
        string cMinName = TypeChangeDefault.NullToString(context.Request["cMinName"], "");// 完赛时间      
        int iAmount = TypeChangeDefault.NullToInt(context.Request["iAmount"], 0);//竞投的积分
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您没登录！\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        if (DateTime.Now < DateTime.Parse("2015-08-31") || DateTime.Now > DateTime.Parse("2015-09-13"))
        {
            result = "{\"msg\":\"竞猜还没开始或者已结束！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;

        DBM5.tblQuiz ddsm = new DBM5.tblQuiz();
        DB5.tblQuiz bll = new DB5.tblQuiz();
        int count = bll.GetRecordCount("idItem=" + idItem + " and idUser = " + model.uId);
        if (count > 0)
        {
            result = "{\"msg\":\"您已参与竞猜！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        if (iAmount == 0 || iAmount > 5000)
        {
            result = "{\"msg\":\"竞猜积分大于0小于5000！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int ys = iAmount % 100;
        if (ys != 0)
        {
            result = "{\"msg\":\"请输入100的整数倍！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int isout = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + model.uId, model.uId);
        if (iAmount > isout)
        {
            result = "{\"msg\":\"您的积分不足！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM5.tblQuiz modlquiz = new DBM5.tblQuiz();
        modlquiz.idUser = model.uId;
        modlquiz.idItem = 1;
        modlquiz.cItemName = "雪娇大北备战记竞猜成绩赢积分";
        modlquiz.idMin = idMin;
        modlquiz.cMinName = cMinName;
        modlquiz.iAmount = iAmount;
        modlquiz.dCreate = DateTime.Now;
        int i = new DB5.tblQuiz().Add(modlquiz);
        if (i > 0)
        {
            new DB1.tblIntegral().InsertScore(model.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(iAmount, 0), "竞猜花费积分");
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}