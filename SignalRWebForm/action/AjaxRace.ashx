<%@ WebHandler Language="C#" Class="AjaxRace" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Text;
public class AjaxRace : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
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
    #region 搜索页
    /// <summary>
    /// 热门活动
    /// </summary>
    /// <param name="context"></param>
    public void toprace(HttpContext context)
    {
        System.Data.DataSet ds = null;
        ds = new DB4.tblRACE_ACTIVITY().GetThumbnailList(6, "", " newid() ");
        context.Response.Write(ConvertJson.ToJson(ds));
    }
    //最新活动
    public void newrace(HttpContext context)
    {
        System.Data.DataSet ds = null;
        ds = new DB4.tblRACE_ACTIVITY().GetThumbnailList(6, "", " dCreate desc ");
        context.Response.Write(ConvertJson.ToJson(ds));
    }
    //活跃成员
    public void ActiveMember(HttpContext context)
    {
        System.Data.DataSet ds = null;
        ds = new DB4.tblRACE_JOIN().ActiveMember(6, " left(idActivity,1)=4 ", " sum(1) desc ", " idUser,cLoginname,iStatus ");
        context.Response.Write(ConvertJson.ToJson(ds));
    }
    //活动达人
    public void Daren(HttpContext context)
    {
        System.Data.DataSet ds = null;
        ds = new DB4.tblRACE_ACTIVITY().Daren(6, "", " sum(1) desc ");
        context.Response.Write(ConvertJson.ToJson(ds));
    }
    //搜索活动
    public void search(HttpContext context)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(" 1=1 ");
        int uId = TypeChangeDefault.NullToInt(context.Request["uId"], 0);
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["pageIndex"], 1);
        //页面显示条数
        int Pagesize = TypeChangeDefault.NullToInt(context.Request["pageSize"], 10);

        string cityid = TypeChangeDefault.NullToString(context.Request["cityid"], "1");
        string areaid = TypeChangeDefault.NullToString(context.Request["areaid"], "0");
        if (areaid == "0")
        {
            //sb.Append(" and idCity like '" + cityid + "%'");
            sb.Append(" and replace(idCity,right(idCity,2),'')='" + cityid + "'");
        }
        else
        {
            sb.Append(" and idCity = '" + cityid + areaid.PadLeft(2, '0') + "'");
        }
        string time = TypeChangeDefault.NullToString(context.Request["time"], "0");
        if ("0" != time)
        {
            if ("1" == time)
            {
                sb.Append(" and datediff(week,dOpen,getdate())=0 ");//1本周2,下周，3最近一个月
            }
            if ("2" == time)
            {
                sb.Append(" and  DateDiff(wk, GetDate(), dOpen ) = 1");//1本周2,下周，3最近一个月
            }
            if ("3" == time)
            {
                sb.Append(" and dOpen between CONVERT(varchar(10), getdate(), 20) and CONVERT(varchar(10), DATEADD(mm, 1, getdate()), 20) ");//1本周2,下周，3最近一个月
            }

        }

        string game = TypeChangeDefault.NullToString(context.Request["game"], "0");
        if (game != "0")
        {
            sb.Append(" and idRoadStyle = '" + game + "'");
        }
        string level = TypeChangeDefault.NullToString(context.Request["level"], "0");
        if (level != "0")
        {
            sb.Append(" and iStrength = '" + level + "'");
        }
        string km = TypeChangeDefault.NullToString(context.Request["km"], "0");
        if ("0" != km)
        {
            switch (km)
            {
                case "1": sb.Append(" and  iDistance <5 "); break;
                case "2": sb.Append(" and  iDistance between 5 and 10 "); break;
                case "3": sb.Append(" and  iDistance >21 "); break;
            }
        }
        string features = TypeChangeDefault.NullToString(context.Request["features"], "100");
        if ("100" != features)
        {
            sb.Append(" and iWinner = '" + features + "'");
        }
        string key = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["key"]), "");
        if (key.Trim().Length > 0)
        {
            sb.Append(" and(  cContent like '%" + key + "%'");
            sb.Append(" or  cTitle like '%" + key + "%')");
        }
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new RaceInfo().SearchToJson(model.uId, sb.ToString(), key, Pagesize, pageIndex));
        }
        else
        {
            context.Response.Write(new RaceInfo().SearchToJson(0, sb.ToString(), key, Pagesize, pageIndex));
        }

    }
    #endregion
    #region 约跑列表页（个人中心）
    //约跑信息列表
    public void raceList(HttpContext context)
    {
        int uId = TypeChangeDefault.NullToInt(context.Request["uId"], 0);
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["pageIndex"], 0);
        //页面显示条数
        int Pagesize = TypeChangeDefault.NullToInt(context.Request["pageSize"], 0);
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new RaceInfo().ToJson(model.uId, uId, op, Pagesize, pageIndex));
        }
        else
        {
            context.Response.Write(new RaceInfo().ToJson(0, uId, 4, Pagesize, pageIndex));
        }

    }
    #endregion
    #region 约跑详情页
    /// <summary>
    ///约跑信息
    /// </summary>
    /// <param name="context"></param>
    public void race(HttpContext context)
    {

        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        System.Data.DataSet ds = null;

        ds = new DB4.tblRACE_ACTIVITY().GetModelbyidRace(idRace);
        ds.Tables[0].Columns.Add("cAvatar", typeof(string));
        ds.Tables[0].Columns.Add("cNickName", typeof(string));
        ds.Tables[0].Columns.Add("cContent", typeof(string));
        ds.Tables[0].Columns.Add("gly", typeof(string));//管理员
        ds.Tables[0].Columns.Add("state", typeof(string));//约跑状态
        ds.Tables[0].Columns.Add("qx", typeof(string));//权限
        ds.Tables[0].Columns.Add("fx", typeof(string));//发布分享
        ds.Tables[0].Columns.Add("gz", typeof(string));//关注发布约跑的人
        if (ds.Tables[0].Rows.Count > 0)
        {
            ds.Tables[0].Rows[0]["gly"] = "0";
            ds.Tables[0].Rows[0]["gz"] = "0";
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (model.uId == Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString()))
                {
                    ds.Tables[0].Rows[0]["gly"] = "1";
                    if (DateTime.Now >= Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinEnd"].ToString()))
                    {
                        ds.Tables[0].Rows[0]["qx"] = "0";
                    }
                    else
                    {
                        ds.Tables[0].Rows[0]["qx"] = "1";
                    }
                }
                else
                {
                    if (new DB3.tblATTENTION().Exists("idInfo=" + ds.Tables[0].Rows[0]["idUser"].ToString() + " and idUser=" + model.uId))
                    {
                        ds.Tables[0].Rows[0]["gz"] = "1";//已关注
                    }
                }
                //if (new DB4.tblRACE_JOIN().Exists(idRace, model.uId))
                //{
                //    ds.Tables[0].Rows[0]["qx"] = "1";
                //}
                //else
                //{
                //    ds.Tables[0].Rows[0]["qx"] = "0";
                //}

            }

            DBM1.tblMEMBER mModel = new DB1.tblMEMBER().GetModel(Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString()));
            if (mModel != null)
            {
                ds.Tables[0].Rows[0]["cAvatar"] = mModel.cAvatar;
                ds.Tables[0].Rows[0]["cNickName"] = mModel.cNickName;
            }
            else
            {
                ds.Tables[0].Rows[0]["cAvatar"] = "../Html/images/wl/2.png";
                ds.Tables[0].Rows[0]["cNickName"] = "";
            }

            DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(Convert.ToInt32(ds.Tables[0].Rows[0]["idBlog"].ToString()));
            if (mBlog != null)
            {
                ds.Tables[0].Rows[0]["cContent"] = UBB.ToHtml(mBlog.cContent);
            }
            else
            {
                ds.Tables[0].Rows[0]["cContent"] = "";
            }
            //ds.Tables[0].Rows[0]["dOpen"] = Convert.ToDateTime(ds.Tables[0].Rows[0]["dOpen"].ToString()).ToString("yyyy-MM-dd HH:mm");
            //ds.Tables[0].Rows[0]["dCollect"] = Convert.ToDateTime(ds.Tables[0].Rows[0]["dCollect"].ToString()).ToString("yyyy-MM-dd HH:mm");
            //ds.Tables[0].Rows[0]["dJoinBegin"] = Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinBegin"].ToString()).ToString("yyyy-MM-dd HH:mm");
            //ds.Tables[0].Rows[0]["dJoinEnd"] = Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinEnd"].ToString()).ToString("yyyy-MM-dd HH:mm");
            if (DateTime.Now >= Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinEnd"].ToString()))
            {
                ds.Tables[0].Rows[0]["state"] = "<a class=\"running-ing running-end\" href=\"\">报名结束</a>";
            }
            else if (DateTime.Now >= Convert.ToDateTime(ds.Tables[0].Rows[0]["dJoinBegin"].ToString()))
            {
                ds.Tables[0].Rows[0]["state"] = "<a  class=\"running-ing running-to\">报名中</a>";
            }
            else
            {
                ds.Tables[0].Rows[0]["state"] = "<a  class=\"running-ing\">未开始</a>";
            }

        }

        context.Response.Write(ConvertJson.ToJson(ds));
    }
    //申请报名
    public void apply(HttpContext context)
    {
        int tag = -1;//-1未登录，0未报名，1已报名，4（人员已满），-2 不存在
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//0,获取状态，1 发送请求2 取消报名

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (op == 0)
            {
                tag = new DB4.tblRACE_JOIN().GetJion(idRace, model.uId);
            }
            else if (op == 1)
            {
                string name = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["name"]), "");
                string tel = TypeChangeDefault.NullToString(context.Request["tel"], "");
                string cMark = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["bz"]), "");//备注
                
                if (name.Trim().Length > 0 && tel.Trim().Length > 0)
                {
                    if (new DB4.tblRACE_JOIN().Exists(idRace, model.uId))
                    {
                        tag = 1;
                    }
                    else
                    {
                        if (name.Trim().Length > 64 || tel.Trim().Length > 12 || cMark.Trim().Length > 128)
                        {
                            tag = 0;
                        }
                        else {
                            //tag = new DB4.tblRACE_JOIN().Jion(idRace, model.uId, model.cNickName, name, tel);
                            //添加备注
                            tag = new DB4.tblRACE_JOIN().Jion(idRace, model.uId, model.cNickName, name, tel, cMark);
                            //// 报名约跑积分
                            //new DB1.tblIntegral().InsertScore(model.uId, 200810017, 1, 0);
                        }
                    }
                }
                else
                {
                    tag = 0;//失败
                }
            }
            else if (op == 2)
            {
                tag = new DB4.tblRACE_JOIN().Jion(idRace, model.uId, "", "", "");
            }
        }
        else
        {
            tag = -1;
        }
        context.Response.Write(tag);
    }
    /// <summary>
    /// 删除，签到
    /// </summary>
    /// <param name="context"></param>
    public void qdel(HttpContext context)
    {
        int tag = -1;//-2活动不存在，-1未登录，0失败，1成功，2活动已过期,3该人已经报名不能删除
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        int idUser = TypeChangeDefault.NullToInt(context.Request["idUser"], 0);
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//0,获取状态，1 操作
        System.Data.DataSet ds = null;
        ds = new DB4.tblRACE_ACTIVITY().GetModelbyidRace(idRace);

        if (ds.Tables[0].Rows.Count > 0)
        {
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (model.uId == Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString()))
                {
                    string Stra = Convert.ToDateTime(DateTime.Now).ToString("yyyy-MM-dd").ToString();
                    string Strb = Convert.ToDateTime(ds.Tables[0].Rows[0]["dOpen"].ToString()).ToString("yyyy-MM-dd").ToString();

                    int compare = Stra.CompareTo(Strb);
                    if (op == 0)
                    {
                        int state = new DB4.tblRACE_JOIN().GetState(idRace, idUser);
                        if (state == 2)
                        {
                            tag = 3;                           
                        }
                        else
                        {
                            if (compare == 0)
                            {
                                tag = 1; //签到
                            }
                            else if (compare == 1)
                            {//当前时间大于活动时间
                                tag = 0;//活动已经过期，不做任何处理
                            }
                            else if (compare == -1)
                            {//当前时间小于活动时间
                                //删除操作
                                tag = 2;
                            }
                        }
                    }
                    else if (op == 1)
                    {
                        if (compare == 0)
                        {
                            //签到
                            if (new DB4.tblRACE_JOIN().Signin(idRace, idUser))
                            {
                                tag = 1; //签到成功
                            }
                            else
                            {
                                tag = 0;
                            }
                        }
                        else if (compare == 1)
                        {//当前时间大于活动时间
                            tag = 2;//活动已经过期，不做任何处理
                        }
                        else if (compare == -1)
                        {//当前时间小于活动时间
                            //删除操作
                            int state = new DB4.tblRACE_JOIN().GetState(idRace, idUser);
                            if (state > 1)
                            {
                                tag = 3;//已报名成功，不允许删除                                
                            }
                            else
                            {
                                if (new DB4.tblRACE_JOIN().Delete(idRace, idUser))
                                {
                                    tag = 1; //删除成功
                                }
                                else
                                {
                                    tag = 0;
                                }
                            }
                        }
                    }
                }
                else
                {
                    tag = 0;
                }
            }
            else
            {
                tag = -1;//用户未登录
            }
        }
        else
        {
            tag = -2;//该活动不存在
        }
        context.Response.Write(tag);
    }
    //关注
    public void focus(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//0,获取状态，1 发送请求
        //-1 未登录，0失败，1关注成功，2已存在
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (op == 0)
            {
                if (new DB3.tblATTENTION().Exists("idInfo=" + idRace + " and idUser=" + model.uId))
                {
                    context.Response.Write("2");
                }
                else
                {
                    context.Response.Write("3");
                }
            }
            else if (op == 1)
            {
                if (new DB3.tblATTENTION().Exists("idInfo=" + idRace + " and idUser=" + model.uId))
                {
                    context.Response.Write("2");
                }
                else
                {
                    DBM3.tblATTENTION mAttention = new DBM3.tblATTENTION();
                    mAttention.cLoginname = model.cNickName;
                    mAttention.idInfo = idRace;
                    mAttention.idUser = model.uId;
                    int imessage = new DB3.tblATTENTION().Add(mAttention);
                    if (imessage > 0)
                    {
                        new DB1.tblIntegral().InsertScore(model.uId, 200810015, 1, 0, 1);
                        context.Response.Write("1");
                    }
                    else
                    {
                        context.Response.Write("0");
                    }
                }
            }
            else
            {
                context.Response.Write("0");
            }


        }
        else
        {
            context.Response.Write("-1");
        }
    }
    //删除
    public void del(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            DBM4.tblRACE_ACTIVITY taModel = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
            if (model.uId == taModel.idUser)
            {
                if (new DB4.tblRACE_ACTIVITY().Delete(idRace))
                {
                    new DB2.tblBLOG().Delete(Convert.ToInt32(taModel.idBlog));
                    
                    new DB1.tblIntegral().InsertScore(model.uId, 200810024, 1, 0);
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            else
            {
                context.Response.Write("0");
            }
        }
        else
        {
            context.Response.Write("-1");
        }
    }
    //图文分享
    public void blog(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);

        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["pageIndex"], 0);
        //页面显示条数
        int Pagesize = TypeChangeDefault.NullToInt(context.Request["pageSize"], 10);

        context.Response.Write(new RaceInfo().BlogToJson(idRace, Pagesize, pageIndex));
    }
    /// <summary>
    /// 组内成员
    /// </summary>
    /// <param name="context"></param>
    public void ClubNewMember(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        //op 1最新加入成员，2活动全部成员
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);
        if (op == 1)
        {
            System.Data.DataSet ds = null;
            ds = new DB4.tblRACE_JOIN().ActiveMember(9, "iStatus>0 and  idActivity= " + idRace, " dCreate desc ", "");
            context.Response.Write(ConvertJson.ToJson(ds));
        }
        else if (op == 2)
        {
            System.Data.DataSet ds = null;
            int recordCount = 0;   //签到人数        
            int bmCount = 0;   //报名人数     
            int wfkCount = 0;   //未付款人数   
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                DBM4.tblRACE_ACTIVITY taModel = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
                if (model.uId == taModel.idUser)
                {
                    ds = new DB4.tblRACE_JOIN().getMember(0, " iStatus>0 and idActivity= " + idRace, " dCreate desc ", "");                   
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        recordCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=3");
                        bmCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=2");
                        wfkCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=1");
                        //context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
                        context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                    }
                    else
                    {
                        context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                    }
                }
                else
                {
                    ds = new DB4.tblRACE_JOIN().ActiveMember(0, "iStatus>0 and  idActivity= " + idRace, " dCreate desc ", "");
                    //ds.Tables[0].Columns.Add("count", typeof(string));
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        recordCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=3");
                        bmCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=2");
                        wfkCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=1");
                        context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                    }
                    else
                    {
                        context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                        //context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
                    }
                }
            }
            else
            {
                ds = new DB4.tblRACE_JOIN().ActiveMember(0, "iStatus>0 and idActivity= " + idRace, " dCreate desc ", "");
                //ds.Tables[0].Columns.Add("count", typeof(string));
                if (ds.Tables[0].Rows.Count > 0)
                {
                    recordCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=3");
                    bmCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=2");
                    wfkCount = new DB4.tblRACE_JOIN().GetRecordCount("idActivity=" + idRace + " and iStatus=1");
                    context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                }
                else
                {
                    context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + ",\"bmcount\":" + bmCount + ",\"wfkCount\":" + wfkCount + "}"));
                    //context.Response.Write(ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
                }
            }
        }
        else
        {
            context.Response.Write("-1");
        }
    }
    /// <summary>
    /// 我的发起的其他活动
    /// </summary>
    /// <param name="context"></param>
    public void other(HttpContext context)
    {
        int idRace = TypeChangeDefault.NullToInt(context.Request["idRace"], 0);
        System.Data.DataSet ds = null;

        System.Data.DataTable dt = new DB4.tblRACE_ACTIVITY().GetList(" and id=" + idRace).Tables[0];
        if (dt.Rows.Count > 0)
        {
            ds = new DB4.tblRACE_ACTIVITY().GetList(20, " id !=" + idRace + "and idUser=" + Convert.ToInt32(dt.Rows[0]["idUser"].ToString()), "dCreate desc");
            context.Response.Write(ConvertJson.ToJson(ds));
        }
        else
        {
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(ds));
        }
    }
    #endregion
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}