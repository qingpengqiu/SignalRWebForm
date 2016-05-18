<%@ WebHandler Language="C#" Class="AjaxClub" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model;
using Erun360.BLL;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Data;
using System.Text;

public class AjaxClub : IHttpHandler, IReadOnlySessionState
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
    /// <summary>
    /// 申请，审核，退出俱乐部
    /// </summary>
    /// <param name="context"></param>
    public void Join(HttpContext context)
    {
        int tag = -1;//-1未登录，0未申请，1申请待审核，2审核通过，退出俱乐部,4（人员已满）
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//0,获取状态，1 发送请求
        string msg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            DBM4.tblRACE_CLUB mClub = new DB4.tblRACE_CLUB().GetModelByCache(idClub);
            if (op == 0)
            {
                tag = new DB4.tblRACE_CLUB_MEMBER().GetJion(idClub, model.uId);
            }
            else if (op == 1)
            {
                tag = new DB4.tblRACE_CLUB_MEMBER().Jion(idClub, model.uId);
                if (tag == 1)
                {
                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cContent = "申请加入《<a target=\"_blank\" href=\"/club/" + mClub.id + ".aspx\">" + mClub.cTitle + "</a>》留言：" + msg;
                    disModel.idInfo = TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0);
                    disModel.idUser = model.uId;
                    disModel.cLoginname = model.cNickName;
                    // disModel.dCreate = DateTime.Now;
                    int imessage = disBll.Add(disModel);

                    if (imessage > 0)
                    {

                        DBM3.tblMessage mMessage = new DBM3.tblMessage();
                        mMessage.cId = model.uId;
                        mMessage.uId = TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0);
                        mMessage.itype = 31;
                        mMessage.idcode = imessage;
                        int test = new DB3.tblMessage().Add(mMessage);
                    }

                }
                else if (tag == 3)
                {
                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cContent = "您已退出《<a target=\"_blank\" href=\"/club/" + mClub.id + ".aspx\">" + mClub.cTitle + "</a>》";
                    disModel.idInfo = TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0);
                    disModel.idUser = model.uId;
                    disModel.cLoginname = model.cNickName;
                    // disModel.dCreate = DateTime.Now;
                    int imessage = disBll.Add(disModel);
                    new DB1.tblIntegral().InsertScore(model.uId, 200810023, 1, 0);
                    if (imessage > 0)
                    {

                        DBM3.tblMessage mMessage = new DBM3.tblMessage();
                        mMessage.cId = model.uId;
                        mMessage.uId = TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0);
                        mMessage.itype = 31;
                        mMessage.idcode = imessage;
                        int test = new DB3.tblMessage().Add(mMessage);
                    }
                }
                
            }
        }
        else
        {
            tag = -1;
        }
        context.Response.Write(tag);

    }
    /// <summary>
    /// 俱乐部信息
    /// </summary>
    /// <param name="context"></param>
    public void ClubInfo(HttpContext context)
    {

        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        System.Data.DataSet ds = null;

        ds = new DB4.tblRACE_CLUB().GetList(" id=" + idClub);

        ds.Tables[0].Columns.Add("BlogCount", typeof(string));
        ds.Tables[0].Columns.Add("MemberERCount", typeof(string));
        ds.Tables[0].Columns.Add("cAvatar", typeof(string));
        ds.Tables[0].Columns.Add("gly", typeof(string));
        ds.Tables[0].Columns.Add("state", typeof(string));
        if (ds.Tables[0].Rows.Count > 0)
        {
            ds.Tables[0].Rows[0]["BlogCount"] = new DB4.tblRACE_LINKS().GetBlogCountByCache(idClub);
            ds.Tables[0].Rows[0]["MemberERCount"] = new DB4.tblRACE_CLUB_MEMBER().GetCountByCache(idClub);
            DBM1.tblMEMBER mModel = new DB1.tblMEMBER().GetModel(Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString()));
            if (mModel != null)
            {
                ds.Tables[0].Rows[0]["cAvatar"] = mModel.cAvatar;
            }
            else
            {
                ds.Tables[0].Rows[0]["cAvatar"] = "/Html/images/wl/2.png";
            }
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
                {
                    ds.Tables[0].Rows[0]["gly"] = "1";
                    ds.Tables[0].Rows[0]["state"] = "1";
                }
                else
                {
                    ds.Tables[0].Rows[0]["gly"] = "0";
                    if (ds.Tables[0].Rows[0]["iStates"].ToString() == "0")
                    {
                        string state = new DB4.tblRACE_CLUB_MEMBER().GetClubState("idClub=" + idClub + " and idUser=" + model.uId);

                        if (state == "2")
                        {
                            ds.Tables[0].Rows[0]["state"] = "1";
                        }
                        else
                        {
                            ds.Tables[0].Rows[0]["state"] = "0";
                        }
                    }
                    else
                    {
                        ds.Tables[0].Rows[0]["state"] = "1";
                    }
                }

            }
            else
            {
                ds.Tables[0].Rows[0]["gly"] = "0";
                ds.Tables[0].Rows[0]["state"] = "0";
            }
        }

        context.Response.Write(ConvertJson.ToJson(ds));
    }
    /// <summary>
    /// 俱乐部全部博文
    /// </summary>
    /// <param name="context"></param>
    public void ClubBlog(HttpContext context)
    {
        //具体的页面数     
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["pageIndex"], 0);
        //页面显示条数
        int Pagesize = TypeChangeDefault.NullToInt(context.Request["pageSize"], 0);
        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        context.Response.Write(new Club().ToJson(idClub, "22,23", pageIndex, Pagesize));
    }
    /// <summary>
    /// 俱乐部成员
    /// </summary>
    /// <param name="context"></param>
    public void ClubMember(HttpContext context)
    {
        //op  1待审核，2 审核通过
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
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
            context.Response.Write(new Club().ToMemberJson(idClub, model.uId, " iStates=" + op + " ", pageIndex, Pagesize));
        }
        else
        {
            context.Response.Write(new Club().ToMemberJson(idClub, 0, " iStates=" + op + " ", pageIndex, Pagesize));
        }

    }
    /// <summary>
    /// 俱乐部成员Audit
    /// </summary>
    /// <param name="context"></param>
    public void Audit(HttpContext context)
    {
        //-1 没登录，0审核失败，1审核成功
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        string idUsers = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["idUser"]), "0");
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
           
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                int falg = new DB4.tblRACE_CLUB_MEMBER().Audit(idClub, idUsers);
                try
                {

                    if (falg == 1)
                    {
                        DBM4.tblRACE_CLUB mClub = new DB4.tblRACE_CLUB().GetModelByCache(idClub);
                        if (mClub != null)
                        {
                            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                            disModel.cContent = "恭喜您，已通过《<a target=\"_blank\" href=\"/club/" + mClub.id + ".aspx\">" + mClub.cTitle + "</a>》俱乐部审核!";
                            disModel.idInfo = Convert.ToInt32(idUsers);
                            disModel.idUser = model.uId;
                            disModel.cLoginname = model.cNickName;
                            // disModel.dCreate = DateTime.Now;
                            int imessage = disBll.Add(disModel);
                            new DB1.tblIntegral().InsertScore(Convert.ToInt32(idUsers), 200810020, 1, 0);
                            if (imessage > 0)
                            {

                                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                mMessage.cId = model.uId;
                                mMessage.uId = Convert.ToInt32(idUsers);
                                mMessage.itype = 31;
                                mMessage.idcode = imessage;
                                int test = new DB3.tblMessage().Add(mMessage);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    //log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
                }
                context.Response.Write(falg);
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
    /// <summary>
    /// 移除俱乐部成员
    /// </summary>
    /// <param name="context"></param>
    public void DelUser(HttpContext context)
    {
        //-1 没登录，0失败，1成功
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        string idUsers = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["idUser"]), "0");
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                int falg = new DB4.tblRACE_CLUB_MEMBER().DeleteList(idClub, idUsers);
                if (falg == 1)
                {
                    DBM4.tblRACE_CLUB mClub = new DB4.tblRACE_CLUB().GetModelByCache(idClub);
                    if (mClub != null)
                    {
                        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                        disModel.cContent = "您已被管理员踢出《" + mClub.cTitle + "》俱乐部!";
                        disModel.idInfo = Convert.ToInt32(idUsers);
                        disModel.idUser = model.uId;
                        disModel.cLoginname = model.cNickName;
                        // disModel.dCreate = DateTime.Now;
                        int imessage = disBll.Add(disModel);
                        new DB1.tblIntegral().InsertScore(Convert.ToInt32(idUsers), 200810023, 1, 0);
                        if (imessage > 0)
                        {

                            DBM3.tblMessage mMessage = new DBM3.tblMessage();
                            mMessage.cId = model.uId;
                            mMessage.uId = Convert.ToInt32(idUsers);
                            mMessage.itype = 31;
                            mMessage.idcode = imessage;
                            int test = new DB3.tblMessage().Add(mMessage);
                        }
                    }
                }
                context.Response.Write(falg);
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
    /// <summary>
    /// 俱乐部新成员
    /// </summary>
    /// <param name="context"></param>
    public void ClubNewMember(HttpContext context)
    {
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            context.Response.Write(new Club().ToNewMemberJson(idClub, model.uId, 3, " iStates=2 ", " cm.dCreate desc "));
        }
        else
        {
            context.Response.Write(new Club().ToNewMemberJson(idClub, 0, 3, " iStates=2 ", " cm.dCreate desc "));
        }
    }
    /// <summary>
    /// 修改俱乐部简介
    /// </summary>
    /// <param name="context"></param>
    public void Bio(HttpContext context)
    {
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        //string Bio = TypeChangeDefault.NullToString(context.Request["bio"], "");
        //传递中文参赛解码
        string Bio = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["bio"]), "");
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                if (new DB4.tblRACE_CLUB().UpdateDescription(idClub, Bio))
                    context.Response.Write("1");
                else
                    context.Response.Write("0");
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
    /// <summary>
    /// 修改俱乐部公告
    /// </summary>
    /// <param name="context"></param>
    public void Notice(HttpContext context)
    {
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        string Notice = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");

        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                if (new DB4.tblRACE_CLUB().UpdateNotice(idClub, Notice))
                    context.Response.Write("1");
                else
                    context.Response.Write("0");
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
    /// <summary>
    /// 讨论区隐私设置
    /// </summary>
    /// <param name="context"></param>
    public void Setting(HttpContext context)
    {
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        int iStates = TypeChangeDefault.NullToInt(context.Request["set"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                if (new DB4.tblRACE_CLUB().Setting(idClub, iStates))
                    context.Response.Write("1");
                else
                    context.Response.Write("0");
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
    /// <summary>
    /// 置顶/取消置顶
    /// </summary>
    /// <param name="context"></param>
    public void ZDing(HttpContext context)
    {
        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        int idSlave = TypeChangeDefault.NullToInt(context.Request["idSlave"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                context.Response.Write(new DB4.tblRACE_LINKS().zDing(idClub, idSlave));
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
    /// <summary>
    /// 删除俱乐部博文
    /// </summary>
    /// <param name="context"></param>
    public void delBlog(HttpContext context)
    {

        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        int idSlave = TypeChangeDefault.NullToInt(context.Request["idSlave"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                if (new DB4.tblRACE_LINKS().delBolg(idClub, idSlave))
                    context.Response.Write("1");
                else
                    context.Response.Write("0");
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
    /// <summary>
    /// 删除俱乐部评论
    /// </summary>
    /// <param name="context"></param>
    public void delDiscuss(HttpContext context)
    {

        int idClub = TypeChangeDefault.NullToInt(context.Request["idClub"], 0);
        int id = TypeChangeDefault.NullToInt(context.Request["id"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            if (TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIsAdmin(idClub), 0) == model.uId)
            {
                if (new DB3.tblDISCUSS().Delete(id, idClub))
                    context.Response.Write("1");
                else
                    context.Response.Write("0");
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
        int cId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            cId = model.uId;
        }
        
        //context.Response.Write(new RaceInfo().ToJson(uId, 0, op, Pagesize, pageIndex));
        int recordCount = 0;
        DataSet ds = null;
        StringBuilder sql = new StringBuilder();
        sql.Append(" SELECT  ");
        sql.Append("tr.id, tb.idUser, tb.cLoginname,tr.idBlog ,convert(varchar(50),tr.cTitle) as cTitle, tb.cContent,CONVERT(varchar(16), tr.dOpen, 20)as dOpen , CONVERT(varchar(16), tr.dJoinBegin, 20)as dJoinBegin, CONVERT(varchar(16), tr.dJoinEnd, 20)as dJoinEnd, CONVERT(varchar(16), tr.dCreate, 20)as dCreate, ts.iShowTimes, ts.iDiscuss, ts.iDing, ts.iFocus,tr.cImage ");
        sql.Append(" FROM  YP_DB_4.dbo.tblRACE_ACTIVITY AS tr INNER JOIN ");
        sql.Append(" YP_DB_2.dbo.tblBLOG AS tb ON tr.idBlog = tb.id INNER JOIN ");
        sql.Append(" YP_DB_2.dbo.tblBLOG_SUMMARY AS ts ON tb.id = ts.idBlog ");
        StringBuilder sWhere = new StringBuilder();
        switch (op)
        {
            case 0:
                break; //全部

            case 1: //我发起的
                sWhere.Append(" idUser=" + uId);
                break;
        }

        ds = new DB4.tblRACE_ACTIVITY().QueryByPage(sql.ToString(), sWhere.ToString(), " dOpen desc", Pagesize, pageIndex, out recordCount);
        ds.Tables[0].Columns.Add("Thumbnails", typeof(string));
        ds.Tables[0].Columns.Add("state", typeof(string));// 
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < recordCount; i++)
            {
                if (cId != 0)
                {
                    if (new DB4.tblRACE_JOIN().Exists(Convert.ToInt32(ds.Tables[0].Rows[i]["id"].ToString()), cId))
                    {
                        ds.Tables[0].Rows[i]["state"] = "<a class=\"running-ing running-focus\">已报名</a>";
                    }
                    else
                    {
                        if (DateTime.Now >= Convert.ToDateTime(ds.Tables[0].Rows[i]["dJoinEnd"].ToString()))
                        {
                            ds.Tables[0].Rows[i]["state"] = "<a class=\"running-ing running-end\" href=\"\">报名结束</a>";
                        }
                        else if (DateTime.Now >= Convert.ToDateTime(ds.Tables[0].Rows[i]["dJoinBegin"].ToString()))
                        {
                            ds.Tables[0].Rows[i]["state"] = "<a  class=\"running-ing running-to\">报名中</a>";
                        }
                        else
                        {
                            ds.Tables[0].Rows[i]["state"] = "<a  class=\"running-ing\">未开始</a>";
                        }
                    }
                }
                ds.Tables[0].Rows[i]["cContent"] = XString.ContentTrunc(HTMLHelper.NoHTML(ds.Tables[0].Rows[i]["cContent"].ToString()), 400);
                ds.Tables[0].Rows[i]["Thumbnails"] = new HomeInfo().GetImgByidBolg(Convert.ToInt32(ds.Tables[0].Rows[i]["idBlog"].ToString()));
            }

           context.Response.Write( ConvertJson.ToJson(ds).Replace("]}", "],\"count\":" + recordCount + "}"));
           return;
        }
        context.Response.Write( ConvertJson.ToJson(ds).Replace("]}", "[],\"count\":" + recordCount + "}"));

        return;
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