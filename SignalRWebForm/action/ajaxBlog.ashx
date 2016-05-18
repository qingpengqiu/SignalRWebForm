<%@ WebHandler Language="C#" Class="ajaxBlog" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using Newtonsoft.Json;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Converters;
using Erun360.BLL;
public class ajaxBlog : IHttpHandler, IReadOnlySessionState
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
    /// 根据博客id删除博客相关信息
    /// </summary>
    /// <param name="context"></param>
    public void DeleteBlog(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int idBlog = TypeChangeDefault.NullToInt(context.Request["bId"], 0);//博客id
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        BlogInfo uBlog = new BlogInfo();
        if (uBlog.Delete(model.uId, idBlog))
        {
            //删除俱乐部里对应的博文
            new DB4.tblRACE_LINKS().DeleteBlog(idBlog);
            //博客数量-1
            DB1.tblMEMBER_SUMMARY uMember_Summary = new DB1.tblMEMBER_SUMMARY();
            DBM1.tblMEMBER_SUMMARY mBlog = new DBM1.tblMEMBER_SUMMARY();
            mBlog = uMember_Summary.GetModel(model.uId);
            mBlog.iBlogCount = mBlog.iBlogCount - 1;//博客数量-1
            mBlog.idUser = model.uId;
            uMember_Summary.Update(mBlog);
            new DB1.tblIntegral().InsertScore(model.uId, 200810021, 1, 0);

            result = "{\"msg\":\"Blog.aspx\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"Blog.aspx\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

    }
    /// <summary>
    /// 我关注的博客列表
    /// </summary>
    /// <param name="context"></param>
    public void focuslist(HttpContext context)
    {
        string result = string.Empty;
        int cId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            cId = user.uId;
        }
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        int uid = TypeChangeDefault.NullToInt(context.Request["uid"], 0);
        string classify = TypeChangeDefault.NullToString(context.Request["cfy"], "0");
        int status = 0;
        if (uid == cId)
        {
            status = 1;
        }
        if (status == 0)
        {
            context.Response.Write("[]");
        }
        else if (status == 1)
        {
            DB3.tblATTENTION uFocus = new DB3.tblATTENTION();
            string IdBlogs = uFocus.GetAttentionIdList(uid, 2, 0);
            DB2.tblBLOG bll = new DB2.tblBLOG();
            DataTable dt = bll.GetFocusList(IdBlogs, classify, pageIndex, Pagesize).Tables[0];
            Hashtable RaceInfo = null;
            List<Hashtable> RaceInfoList = new List<Hashtable>();
            DB2.tblBLOG_SUMMARY bllSummary = new DB2.tblBLOG_SUMMARY();
            Hashtable mInfo = null;
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    RaceInfo = new Hashtable();
                    int idBlog = TypeChangeDefault.NullToInt(dt.Rows[i]["id"], 0);
                    RaceInfo.Add("id", dt.Rows[i]["id"].ToString());
                    RaceInfo.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
                    RaceInfo.Add("cContent", XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(dt.Rows[i]["cContent"].ToString())), 220));
                    RaceInfo.Add("dCreate", DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dCreate"], DateTime.Now)));
                    DBM2.tblBLOG_SUMMARY model = bllSummary.GetModel(idBlog);
                    mInfo = new Hashtable();
                    mInfo.Add("iShowTimes", model.iShowTimes);
                    mInfo.Add("iDiscuss", model.iDiscuss);
                    mInfo.Add("iDing", model.iDing);
                    mInfo.Add("iFocus", model.iFocus);
                    RaceInfo.Add("show", mInfo);
                    RaceInfo.Add("cThumbUrl", new DB3.tblIMAGES().GetThumbUrl(6, "idInfo=" + idBlog, "id").Tables[0]);
                    RaceInfo.Add("status", status);
                    RaceInfoList.Add(RaceInfo);
                }
            }
            IsoDateTimeConverter iso = new IsoDateTimeConverter();
            iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
            context.Response.Write(JsonConvert.SerializeObject(RaceInfoList, iso));
        }

    }
    /// <summary>
    /// 博客列表
    /// </summary>
    /// <param name="context"></param>
    public void bloglist(HttpContext context)
    {
        string result = string.Empty;
        int uId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            uId = user.uId;
        }

        DB2.tblBLOG bll = new DB2.tblBLOG();
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        int idUser = TypeChangeDefault.NullToInt(context.Request["uid"], 0);
        DataTable dt = new DataTable();
        int status = 0;
        if (idUser == uId)
        {
            status = 1;
        }
        dt = bll.GetPageListByIdUser(idUser, pageIndex,Pagesize ).Tables[0];
        Hashtable RaceInfo = null;
        List<Hashtable> RaceInfoList = new List<Hashtable>();
        DB2.tblBLOG_SUMMARY bllSummary = new DB2.tblBLOG_SUMMARY();
        Hashtable mInfo = null;
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                RaceInfo = new Hashtable();
                int idBlog=TypeChangeDefault.NullToInt( dt.Rows[i]["id"], 0);
                RaceInfo.Add("id", dt.Rows[i]["id"].ToString());
                RaceInfo.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
                RaceInfo.Add("cContent", XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(dt.Rows[i]["cContent"].ToString())), 220));
                RaceInfo.Add("dCreate",DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dCreate"], DateTime.Now)));
                DBM2.tblBLOG_SUMMARY model = bllSummary.GetModel(idBlog);
                mInfo = new Hashtable();
                mInfo.Add("iShowTimes", model.iShowTimes);
                mInfo.Add("iDiscuss", model.iDiscuss);
                mInfo.Add("iDing", model.iDing);
                mInfo.Add("iFocus", model.iFocus);
                RaceInfo.Add("show", mInfo);
                RaceInfo.Add("cThumbUrl", new DB3.tblIMAGES().GetThumbUrl(6, "idInfo=" + idBlog, "id").Tables[0]);
                RaceInfo.Add("status", status);
                RaceInfoList.Add(RaceInfo);
            }
        }
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(RaceInfoList, iso));
    }
    //使用C#把发表的时间改为几个月,几天前,几小时前,几分钟前,或几秒前
    public string DateStringFromNow(DateTime dt)
    {
        TimeSpan span = DateTime.Now - dt;
        if (span.TotalDays > 60)
        {
            return Convert.ToDateTime(dt).ToString("yyyy-MM-dd");
        }
        else
        {
            if (span.TotalDays > 30)
            {
                return
                "1个月前";
            }
            else
            {
                if (span.TotalDays > 14)
                {
                    return
                    "2周前";
                }
                else
                {
                    if (span.TotalDays > 7)
                    {
                        return
                        "1周前";
                    }
                    else
                    {
                        if (span.TotalDays > 1)
                        {
                            return
                            string.Format("{0}天前", (int)Math.Floor(span.TotalDays));
                        }
                        else
                        {
                            if (span.TotalHours > 1)
                            {
                                return
                                string.Format("{0}小时前", (int)Math.Floor(span.TotalHours));
                            }
                            else
                            {
                                if (span.TotalMinutes > 1)
                                {
                                    return
                                    string.Format("{0}分钟前", (int)Math.Floor(span.TotalMinutes));
                                }
                                else
                                {
                                    if (span.TotalSeconds >= 1)
                                    {
                                        return
                                        string.Format("{0}秒前", (int)Math.Floor(span.TotalSeconds));
                                    }
                                    else
                                    {
                                        return
                                        "1秒前";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    /// <summary>
    /// 取消关注博客
    /// </summary>
    /// <param name="context"></param>
    public void qxgz(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int idBlog = TypeChangeDefault.NullToInt(context.Request["bId"], 0);//博客id
        if (idBlog < 200000000)
        {
            result = "{\"msg\":\"博文不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        FocusLand bll = new FocusLand();
        result = bll.AttentionState(model.uId, idBlog, 0, 2);
        int gz = TypeChangeDefault.NullToInt(result, -1);
        if (gz==1)
        {
            result = "{\"msg\":\"取消关注成功！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"取消关注失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        context.Response.Write(new FocusLand().AttentionState(model.uId, idBlog, 0, 2));
    }
    /// <summary>
    /// 顶
    /// </summary>
    /// <param name="context"></param>
    public void Ding(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//博客id
        if (idBlog < 200000000)
        {
            result = "{\"msg\":\"博文不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        BlogInfo uBlog = new BlogInfo();
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        result = uBlog.cDing(idBlog, model.uId);
        int ding = TypeChangeDefault.NullToInt(result, -1);
        if (ding > -1)
        {
            result = "{\"msg\":\"" + ding + "\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else if (result == "<em>您已顶过</em>")
        {
            result = "{\"msg\":\"您已顶过！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"顶失败！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
    }
    /// <summary>
    /// 收藏/关注博客
    /// </summary>
    /// <param name="context"></param>
    public void iHouse(HttpContext context)
    {
        string result = string.Empty;
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"-1\"}";
            context.Response.Write(result);
            return;
        }
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//博客id
        if (idBlog < 200000000)
        {
            result = "{\"msg\":\"博文不存在\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        result = new FocusLand().AttentionState(model.uId, idBlog, 1, 2);
        if (result == "1")
        {
            result = "{\"msg\":\"收藏成功\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else if (result == "您已关注过！！！")
        {
            result = "{\"msg\":\"您已收藏！\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        else
        {
            result = "{\"msg\":\"收藏失败！\",\"status\":\"0\"}";
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
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (strMsg.Trim().Length > 256 || strMsg.Trim().Length == 0)
        {
            result = "{\"msg\":\"内容超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//被评论编码（赛事id）
        DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(idBlog);
        if (mBlog == null)
        {
            result = "{\"msg\":\"博客不存在，不允许评论！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }

        UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;

        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
        disModel.idInfo = idBlog;
        disModel.idUser = user.uId;
        disModel.cLoginname = user.cNickName;
        disModel.cContent = strMsg.Trim();
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            DB1.tblMEMBER_SUMMARY msbll = new DB1.tblMEMBER_SUMMARY();
            DBM1.tblMEMBER_SUMMARY msModel = new DBM1.tblMEMBER_SUMMARY();
            msModel = msbll.GetModel(user.uId);
            msModel.idUser = user.uId;
            msModel.iScore = msModel.iScore + 3;
            msModel.iDiscuss = msModel.iDiscuss + 1;
            msbll.Update(msModel);
            //插入积分               
            new DB1.tblIntegral().InsertScore(user.uId, 200810013, 1, 0, 1);
            //更新博客数量
            DB2.tblBLOG_SUMMARY bsbll = new DB2.tblBLOG_SUMMARY();
            DBM2.tblBLOG_SUMMARY bsModel = new DBM2.tblBLOG_SUMMARY();
            bsModel = bsbll.GetModel(idBlog);
            bsModel.idBlog = idBlog;
            bsModel.iDiscuss = bsModel.iDiscuss + 1;
            bsbll.Update(bsModel);

            int iClassfy = 0;
            int classify = TypeChangeDefault.NullToInt(mBlog.idHref.ToString().Substring(0, 1), 99);
            if (classify == 0)
            {
                iClassfy = 32;
            }
            else if (classify == 5)
            {
                iClassfy = 34;
            }
            else if (classify == 3)
            {
                iClassfy = 33;
            }
            else if (classify == 4)
            {
                iClassfy = 36;
            }

            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = user.uId;
            mActivity.cNickName = user.cNickName;
            mActivity.cAvatar = user.cAvatar;
            mActivity.idBlog = idBlog;
            mActivity.idGroup = iClassfy.ToString();
            mActivity.cTitle = mBlog.cTitle;
            mActivity.cBio = strMsg.Trim();
            new DB2.tblActivity().Add(mActivity);
            if (user.uId != mBlog.idUser)
            {
                DBM3.tblMessage mMessage = new DBM3.tblMessage();
                mMessage.cId = user.uId;
                mMessage.uId = mBlog.idUser;
                mMessage.itype = iClassfy;//评论回复 类型为37
                mMessage.bId = idBlog;
                mMessage.idcode = imessage;
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
        int idUser = TypeChangeDefault.NullToInt(context.Request["user"], 0);//被回复人id
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//被评论编码（赛事id）
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");
        if (strMsg.Trim().Length > 256 || strMsg.Trim().Length == 0)
        {
            result = "{\"msg\":\"内容为空或超过限制！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(idBlog);
        if (mBlog == null)
        {
            result = "{\"msg\":\"博客不存在，不允许评论！\",\"status\":\"0\"}";
            context.Response.Write(result);
            return;
        }
        UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);//被回复人信息
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
        disModel.idInfo = idBlog;
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            int iClassfy = 0;
            int classify = TypeChangeDefault.NullToInt(mBlog.idHref.ToString().Substring(0, 1), 99);
            if (classify == 0)
            {
                iClassfy = 32;
            }
            else if (classify == 5)
            {
                iClassfy = 34;
            }
            else if (classify == 3)
            {
                iClassfy = 33;
            }
            else if (classify == 4)
            {
                iClassfy = 36;
            }
            //插入评论数量
            DB1.tblMEMBER_SUMMARY msbll = new DB1.tblMEMBER_SUMMARY();
            DBM1.tblMEMBER_SUMMARY msModel = new DBM1.tblMEMBER_SUMMARY();
            msModel = msbll.GetModel(model.uId);
            msModel.idUser = model.uId;
            msModel.iScore = msModel.iScore + 3;
            msModel.iDiscuss = msModel.iDiscuss + 1;
            msbll.Update(msModel);
            //插入积分
            new DB1.tblIntegral().InsertScore(model.uId, 200810013, 1, 0);
            //更新博客数量
            DB2.tblBLOG_SUMMARY bsbll = new DB2.tblBLOG_SUMMARY();
            DBM2.tblBLOG_SUMMARY bsModel = new DBM2.tblBLOG_SUMMARY();
            bsModel = bsbll.GetModel(idBlog);
            bsModel.idBlog = idBlog;
            bsModel.iDiscuss = bsModel.iDiscuss + 1;
            bsbll.Update(bsModel);

            DBM3.tblMessage mMessage = new DBM3.tblMessage();
            if (model.uId == idUser)
            {
                if (model.uId != mBlog.idUser)
                {
                    mMessage.cId = model.uId;
                    mMessage.uId = mBlog.idUser;//发布博客人id
                    mMessage.itype = iClassfy;//评论回复 类型为37
                    mMessage.idcode = imessage;
                    mMessage.bId = idBlog;
                    new DB3.tblMessage().Add(mMessage);//插入评论
                }
            }
            else
            {
                if (model.uId == mBlog.idUser)
                {
                    mMessage.cId = model.uId;
                    mMessage.uId = idUser;
                    mMessage.itype = iClassfy;//评论回复 类型为37
                    mMessage.idcode = imessage;
                    mMessage.bId = idBlog;
                    new DB3.tblMessage().Add(mMessage);
                }
                else
                {
                    if (mBlog.idUser == idUser)
                    {
                        mMessage.cId = model.uId;
                        mMessage.uId = idUser;
                        mMessage.itype = iClassfy;//评论回复 类型为37
                        mMessage.idcode = imessage;
                        mMessage.bId = idBlog;
                        new DB3.tblMessage().Add(mMessage);
                    }
                    else
                    {
                        //插入评论
                        mMessage.cId = model.uId;
                        mMessage.uId = mBlog.idUser;//发布博客人id
                        mMessage.itype = iClassfy;//评论回复 类型为37
                        mMessage.idcode = imessage;
                        mMessage.bId = idBlog;
                        new DB3.tblMessage().Add(mMessage);//插入评论

                        //插入回复
                        mMessage.cId = model.uId;
                        mMessage.uId = idUser;
                        mMessage.itype = iClassfy;//评论回复 类型为37
                        mMessage.idcode = imessage;
                        mMessage.bId = idBlog;
                        new DB3.tblMessage().Add(mMessage);
                    }
                }

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
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//被评论编码（博客id）
        DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(idBlog);
        if (model == null)
        {
            context.Response.Write("{\"msg\":\"小伙伴迷失了！\",\"status\":\"-2\"}");
            return;
        }
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 0);//当前页数        
        int Pagesize = 20;//显示条数

        DB3.tblDISCUSS bll = new DB3.tblDISCUSS();
        DataTable dt = new DataTable();
        dt = bll.GetListByPage(" idInfo=" + idBlog, " dCreate desc ", pageIndex, Pagesize, idBlog).Tables[0];

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