<%@ WebHandler Language="C#" Class="ajaxtrained" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Text;
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

public class ajaxtrained : IHttpHandler, IReadOnlySessionState
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
    /// 删除训练成绩
    /// </summary>
    /// <param name="context"></param>
    public void delDrill(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
        int id = TypeChangeDefault.NullToInt(HttpUtility.UrlDecode(context.Request["id"]), 0);

        DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        if (uRace_History.Delete(user.uId, id))
        {
            new DB2.tblActivity().DeleteByidBlog(id, user.uId);
            result = "{\"msg\":\"删除成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"删除失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    public void AddTrain(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        string date = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["date"]), "");
        if (date.Trim().Length == 0)
        {
            result = "{\"msg\":\"请选择日期！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idRoadStyle = TypeChangeDefault.NullToInt(HttpUtility.UrlDecode(context.Request["idRoadStyle"]), -1);
        if (idRoadStyle == -1)
        {
            result = "{\"msg\":\"请选择类型！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        decimal iDistance = TypeChangeDefault.NullToDecimal(HttpUtility.UrlDecode(context.Request["iDistance"]), 0);
        if (iDistance == 0)
        {
            result = "{\"msg\":\"请填写距离！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        if (iDistance.CompareTo(500) > 0)
        {
            result = "{\"msg\":\"最大距离为500！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        string roadtime = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["roadtime"]), "");
        if (roadtime.Trim().Length == 0)
        {
            result = "{\"msg\":\"请选择用时！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        string cMemo = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["cMemo"]), "");
        string avatarurl = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["avatarurl"]), "");

        string zblist = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["zblist"]), "");

        DBM4.tblRACE_HISTORY mRace_History = new DBM4.tblRACE_HISTORY();
        string cEquipment = string.Empty;
        string cEquipmentValue = string.Empty;
        if (zblist.Trim().Length > 0)
        {
            string[] ca = zblist.Split(',');
            for (int i = 0; i < ca.Length; i++)
            {
                string[] zb = ca[i].Split('|');
                if (zb.Length > 0)
                {
                    cEquipment += zb[0] + "|";
                    cEquipmentValue += zb[1] + "|";
                }
            }
        }
        mRace_History.dExpectTime = TypeChangeDefault.NullToDateTime(date, DateTime.Now);
        mRace_History.cEquipment = XString.SqlSafe(cEquipmentValue.TrimEnd('|'));
        mRace_History.idProduct = cEquipment.TrimEnd('|');
        mRace_History.idRoadStyle = idRoadStyle;
        mRace_History.iDistance = iDistance;
        //mRace_History.dRunTime = TypeChangeDefault.NullToDateTime("2001-01-01 " + roadtime, Convert.ToDateTime("2001-01-01 00:00:00"));
        mRace_History.RunTime = roadtime;
        mRace_History.cMemo = XString.SqlSafe(cMemo);
        mRace_History.cImageUrl = avatarurl;
        mRace_History.idUser = user.uId;
        mRace_History.cName = user.cNickName;
        DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        int Raceid = uRace_History.Add(mRace_History);
        if (Raceid > 0)
        {
            #region 积分:发表训练记录
            new DB1.tblIntegral().InsertScore(user.uId, 200810010, 1, 0, 1);
            #endregion
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练，3评论31留言/32博文/33赛事/34/装备
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = user.uId;
            mActivity.cNickName = user.cNickName;
            mActivity.cAvatar = user.cAvatar;
            mActivity.idBlog = Raceid;
            mActivity.idGroup = "25";
            mActivity.cTitle = Convert.ToDateTime(mRace_History.dExpectTime).ToString("yyyy-MM-dd") + "在 " + EnumRoad((int)mRace_History.idRoadStyle) + " 跑了 " + mRace_History.iDistance + "KM，用时 " + mRace_History.RunTime;//Convert.ToDateTime(mRace_History.dRunTime).ToString("HH小时mm分ss秒")
            mActivity.cBio = "";
            mActivity.dCreate = DateTime.Now;
            new DB2.tblActivity().Add(mActivity);
            if (mRace_History.idProduct != null)
            {
                string[] idProductUse = mRace_History.idProduct.Split('|');
                if (idProductUse.Length > 0)
                {
                    string time = mRace_History.RunTime;//Convert.ToDateTime(mRace_History.dRunTime).ToString("HH:mm:ss");
                    for (int i = 0; i < idProductUse.Length; i++)
                    {
                        DBM5.tblPRODUCTS_USE ProductUseModel = new DB5.tblPRODUCTS_USE().GetModelByidProduct(TypeChangeDefault.NullToInt(idProductUse[i], 0));
                        if (ProductUseModel != null)
                        {
                            DBM5.tblPRODUCTS_USE ProductUse = new DBM5.tblPRODUCTS_USE();
                            ProductUse.total_time = ProductUseModel.total_time + Convert2Time(time);
                            ProductUse.fRunDistance = ProductUseModel.fRunDistance + mRace_History.iDistance;
                            ProductUse.last_time = DateTime.Now;
                            ProductUse.id = ProductUseModel.id;
                            new DB5.tblPRODUCTS_USE().Update(ProductUse);
                        }
                        else
                        {
                            DBM5.tblPRODUCTS_USE ProductUse = new DBM5.tblPRODUCTS_USE();
                            ProductUse.idProduct = TypeChangeDefault.NullToInt(idProductUse[i], 0);
                            ProductUse.idUser = user.uId;
                            ProductUse.dCreate = DateTime.Now;
                            ProductUse.total_time = Convert2Time(time);
                            ProductUse.fRunDistance = mRace_History.iDistance;
                            ProductUse.last_time = DateTime.Now;
                            new DB5.tblPRODUCTS_USE().Add(ProductUse);
                        }
                    }
                }
            }
            result = "{\"msg\":\"添加成功！\",\"id\":\"" + Raceid + "\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"添加失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    public int Convert2Time(string time)
    {
        string[] _time = time.Split(':');
        int sec = Convert.ToInt32(_time[0]) * 3600;
        sec += Convert.ToInt32(_time[1]) * 60;
        sec += Convert.ToInt32(_time[2]);
        return sec;
    }
    //获取训练记录
    public void GetTrain(HttpContext context)
    {
        int uId = TypeChangeDefault.NullToInt(context.Request["uid"], 0);//用户id
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (uId == 0)
            {
                uId = model.uId;
            }
        }
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数        
        int Pagesize = 20;//显示条数
        DB4.tblRACE_HISTORY uRace_History = new DB4.tblRACE_HISTORY();
        DataTable dt = uRace_History.GetListByPage(" idUser=" + uId, " dCreate desc", pageIndex, Pagesize, uId).Tables[0];

        Hashtable RaceInfo = null;
        List<Hashtable> RaceInfoList = new List<Hashtable>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            RaceInfo = new Hashtable();
            RaceInfo.Add("id", dt.Rows[i]["id"].ToString());
            RaceInfo.Add("Time", Convert.ToDateTime(dt.Rows[i]["dExpectTime"]).ToString("yyyy-MM-dd"));
            RaceInfo.Add("RoadStyle", EnumRoad(int.Parse(dt.Rows[i]["idRoadStyle"].ToString())));
            RaceInfo.Add("idRoadStyle", dt.Rows[i]["idRoadStyle"].ToString());
            RaceInfo.Add("Distance", dt.Rows[i]["iDistance"].ToString() + "Km");
            //RaceInfo.Add("RunTime", Convert.ToDateTime(dt.Rows[i]["dRunTime"]).ToString("HH:mm:ss"));
            RaceInfo.Add("RunTime", dt.Rows[i]["RunTime"]);
            RaceInfo.Add("speed", NewFormat(float.Parse(dt.Rows[i]["iDistance"].ToString()), dt.Rows[i]["RunTime"].ToString()));//Convert.ToDateTime(dt.Rows[i]["dRunTime"])
            RaceInfo.Add("Equipment", dt.Rows[i]["cEquipment"].ToString());
            RaceInfo.Add("Memo", dt.Rows[i]["cMemo"].ToString().Trim());
            RaceInfo.Add("img", dt.Rows[i]["cImageUrl"].ToString());
            RaceInfoList.Add(RaceInfo);
        }

        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(RaceInfoList, iso));
    }
    private string EnumRoad(int idRoadStyle)
    {
        string Road = string.Empty;
        switch (idRoadStyle)
        {
            case 0: Road = "公园"; break;//a
            case 1: Road = "田径场"; break;//b
            case 2: Road = "公路"; break;//o
            case 3: Road = "山路"; break;//ab
            case 4: Road = "跑步机"; break;//其他
            case 5: Road = "其它"; break;//其他
            default:
                Road = "赛事App记录";
                break;
        }
        return Road;
    }
    public static string Format(float distance, DateTime time)
    {
        StringBuilder sb = new StringBuilder();
        double speed = distance * 60.0 / (time.Hour * 60.0 + time.Minute + time.Second / 60.0);
        sb.AppendLine("" + String.Format("{0:F2}", speed) + " km/h ");
        if (speed > 22.0) sb.AppendLine("<span class=\"train4\" alt=\"您的速度太恐怖了！\"></span>");
        else if (speed > 12.0) sb.AppendLine("<span class=\"train3\" alt=\"高手高手高高手\"></span>");
        else if (speed > 7.0) sb.AppendLine("<span class=\"train2\" alt=\"享受跑步的乐趣\"></span>");
        else if (speed > 4.0) sb.AppendLine("<span class=\"train1\" alt=\"您走的真不慢\"></span>");
        else sb.AppendLine("<span class=\"train0\" alt=\"您这好慢啊\"></span>");

        return sb.ToString();
    }
    public static string NewFormat(float distance, string time)
    {
        StringBuilder sb = new StringBuilder();
        try
        {
            string[] times = time.Split(':');
            double speed = distance * 60.0 / (int.Parse(times[0]) * 60.0 + int.Parse(times[1]) + int.Parse(times[2]) / 60.0);
            sb.AppendLine("" + String.Format("{0:F2}", speed) + " km/h ");
            if (speed > 22.0) sb.AppendLine("<span class=\"train4\" alt=\"您的速度太恐怖了！\"></span>");
            else if (speed > 12.0) sb.AppendLine("<span class=\"train3\" alt=\"高手高手高高手\"></span>");
            else if (speed > 7.0) sb.AppendLine("<span class=\"train2\" alt=\"享受跑步的乐趣\"></span>");
            else if (speed > 4.0) sb.AppendLine("<span class=\"train1\" alt=\"您走的真不慢\"></span>");
            else sb.AppendLine("<span class=\"train0\" alt=\"您这好慢啊\"></span>");
        }
        catch (Exception)
        {
            sb.AppendLine("<span class=\"train0\" alt=\"您这好慢啊\"></span>");
        }
        return sb.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}