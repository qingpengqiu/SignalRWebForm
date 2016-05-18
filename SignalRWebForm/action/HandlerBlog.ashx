<%@ WebHandler Language="C#" Class="HandlerBlog" %>

using System;
using System.Data;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Web.SessionState;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;

public class HandlerBlog : IHttpHandler,IRequiresSessionState {
    public UserInfoModel CurrentUser;
    public string result;
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";
        string operation = string.Empty;
        if (!string.IsNullOrEmpty(context.Request["op"]))
        {
            operation = context.Request["op"].Trim().ToLower();
        }
        switch (operation)
        {
            case "validatetitle":
                ValidateTitle(context);
                break;
            case "savebloginfo":
                SaveBlogInfo(context);
                break;
            case "articlelist":
                ArticleList(context);
                break;
            case "focuslist":
                FocusArticleList(context);
                break;
            case "unfollow":
                UnFollow(context);
                break;
            default:
                break;
        }
    }
    protected void ValidateTitle(HttpContext context)
    {
        string blogtitle = context.Request["title"];
        if (GCommon.BadTitle(blogtitle))
        {
            ResponseEnd(context, "{\"msg\":\"标题含有非法内容！\",\"status\":\"0\"}");
        }
    }
    protected void SaveBlogInfo(HttpContext context)
    {
        int bId = int.Parse(context.Request.Form["bid"]);
        if (context.Session["CurrentUser"] != null)
        {
            CurrentUser = (UserInfoModel)context.Session["CurrentUser"];
        }
        if (CurrentUser == null)
        {
            result="{\"msg\":\"您还没有登录！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
        if (0 > user.idMemberStyle)
        {
            result="{\"msg\":\"你的账号已被限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        if (string.IsNullOrEmpty(context.Request.Form["title"]))
        {
            result="{\"msg\":\"标题不能为空！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        else if (context.Request.Form["title"].Trim().Length > 60)
        {
            result="{\"msg\":\"标题超过60个汉字的限制！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }

        if (GCommon.BadTitle(context.Request.Form["title"].Trim()))
        {
            result="{\"msg\":\"标题含有非法内容！\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        if (context.Request.Form["content"].Trim().Length <= 0)
        {
            result="{\"msg\":\"博客内容不能为空\",\"status\":\"0\"}";
            ResponseEnd(context, result);
        }
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.idHref = 0;
        bModel.cTitle = context.Request.Form["title"].Trim();// XString.NickSafe();
        bModel.cContent = context.Request.Form["content"].Trim();
        if (!string.IsNullOrEmpty(context.Request.Form["blogtype"]))
        {
            bModel.idPersonGroup = int.Parse(context.Request.Form["blogtype"].Trim());
        }
        BlogInfo uBlog = new BlogInfo();
        DB4.tblRACE_LINKS uLinks = new DB4.tblRACE_LINKS();
        if (0 == bId)
        {
            bId = uBlog.Add(bModel);
            //同步到俱乐部
            DBM4.tblRACE_LINKS tlModel = new DBM4.tblRACE_LINKS();
            tlModel.idMaster = TypeChangeDefault.NullToInt(context.Request.Form["club"], 0);
            tlModel.idSlave = bId;
            tlModel.idUser = CurrentUser.uId;
            //DB4.tblRACE_LINKS uLinks = new DB4.tblRACE_LINKS();
            uLinks.Add(tlModel);
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810004, 1, 0, 1);
            DB1.tblMEMBER_SUMMARY uMember_Summary = new DB1.tblMEMBER_SUMMARY();
            DBM1.tblMEMBER_SUMMARY mBlog = new DBM1.tblMEMBER_SUMMARY();
            mBlog = uMember_Summary.GetModel(bModel.idUser);
            mBlog.iBlogCount = mBlog.iBlogCount + 1;//博客数量-1
            mBlog.idUser = bModel.idUser;
            uMember_Summary.Update(mBlog);
        }
        else
        {
            bModel.id = bId;
            uBlog.Update(bModel);
            string CacheKey = "tblBLOGModel-" + bId;
            Erun360.Common.DataCache.RemoveAllCache(CacheKey);
            //修改博客分类数量
            DBM2.tblBLOG_GROUP model = new DB2.tblBLOG_GROUP().GetModel(bModel.idPersonGroup ?? 0);
            if (model != null)
            {
                if (bModel.idPersonGroup != 0)
                {
                    int count = new DB2.tblBLOG().GetRecordCount("idUser=" + CurrentUser.uId + "  and idPersonGroup=" + bModel.idPersonGroup);
                    model.iNumber = count;
                    model.id = bModel.idPersonGroup ?? 0;
                    new DB2.tblBLOG_GROUP().Update(model);
                }
            }
            //俱乐部
            if (!string.IsNullOrEmpty(context.Request.Form["club"]))
            {
                if (uLinks.GetRecordCount(" idMaster=" + context.Request.Form["club"] + " and idSlave=" + bId) == 0)
                {
                    DBM4.tblRACE_LINKS tlModel = new DBM4.tblRACE_LINKS();
                    tlModel.idMaster = TypeChangeDefault.NullToInt(context.Request.Form["club"], 0);
                    tlModel.idSlave = bId;
                    tlModel.idUser = CurrentUser.uId;
                    uLinks.Add(tlModel);
                }
            }
            else
            {
                //DBM4.tblRACE_LINKS RaceLinkModel = new DBM4.tblRACE_LINKS();
                //RaceLinkModel = new DB4.tblRACE_LINKS().getmo
                //if (uLinks.GetRecordCount(" idMaster=" +  + " and idSlave=" + bId) > 0)
                //{
                //    uLinks.delBolg(TypeChangeDefault.NullToInt(context.Request.Form["club"], 0), bId);
                //}
            }
        }
        //同步到俱乐部
        if (CurrentUser.idMemberStyle == 2)
        {
            string idClub = new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId);
            if (uLinks.GetRecordCount("idMaster=" + idClub + " and  idSlave=" + bId + " and idUser=" + CurrentUser.uId) == 0)
            {
                //uLinks.delBolgByidUser(bId, CurrentUser.uId);
                DBM4.tblRACE_LINKS tlModel = new DBM4.tblRACE_LINKS();
                tlModel.idMaster = TypeChangeDefault.NullToInt(new DB4.tblRACE_CLUB().GetIdClub(CurrentUser.uId), 0);
                tlModel.idSlave = bId;
                tlModel.idUser = CurrentUser.uId;
                uLinks.Add(tlModel);
            }
        }
        DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
        DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
        //删除原来博客图片
        imgBll.DeleteByIdBlog(bId);
        BlogInfo ucBlog = new BlogInfo();
        //插入图片
        string[] ImgList = ucBlog.GetHtmlImageUrlList(bModel.cContent);
        string thumbnail = string.Empty;//缩略图
        if (ImgList.Length > 0)
        {
            thumbnail = ImgList[0];
            for (int i = 0; i < ImgList.Length; i++)
            {
                imgModel.idUser = CurrentUser.uId;
                imgModel.idInfo = bId;
                imgModel.cImageUrl = ImgList[i];
                imgModel.cThumbUrl = ImgList[i];
                imgModel.dCreate = DateTime.Now;
                imgBll.Add(imgModel);
            }
        }
        string idGroup = "22";
        //发布相关博客内容
        if (int.Parse(context.Request.Form["from"].ToString()) != 0)
        {
            idGroup = "46";
            int fromId = Convert.ToInt32(context.Request.Form["from"].ToString());
            DB2.tblBLOG_LINKS uBlog_Link = new DB2.tblBLOG_LINKS();
            DBM2.tblBLOG_LINKS mBlog_Link = new DBM2.tblBLOG_LINKS();
            mBlog_Link.idBlog = fromId;
            mBlog_Link.idInfo = bId;
            uBlog_Link.Add(mBlog_Link);
            //新版没有增加缓存
        }
        if (!new DB2.tblActivity().Exists(CurrentUser.uId, bId))
        {
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练/26约跑，3评论31留言/32博文/33赛事/34装备/35训练/36约跑  4分享;46约跑博文分享
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = CurrentUser.uId;
            mActivity.cNickName = CurrentUser.cNickName;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = bId;
            mActivity.idGroup = idGroup;
            if (idGroup == "46")
            {
                int fromId = Convert.ToInt32(context.Request.Form["from"].ToString());
                DBM4.tblRACE_ACTIVITY activity = new DB4.tblRACE_ACTIVITY().GetModel(fromId);
                if (activity != null)
                {
                    mActivity.cTitle = "《<a target=\"_blank\" href=\"/race/" + fromId + ".aspx\">" + activity.cTitle + "</a>》中分享了博文《<a target=\"_blank\" href=\"/blog/" + bId + ".aspx\">" + bModel.cTitle + "</a>》";
                }
                else
                {
                    mActivity.cTitle = bModel.cTitle;
                }
            }
            else
            {
                mActivity.cTitle = bModel.cTitle;
            }

            mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
            mActivity.cImageUrl = thumbnail;
            new DB2.tblActivity().Add(mActivity);
        }
        result="{\"msg\":\"发布成功\",\"status\":\"" + bId + "\"}";
        ResponseEnd(context, result);
    }
    //文章分类：0博客，3赛事，4约跑，5装备，6俱乐部，2全部
    /// <summary>
    /// 获得个人的文章列表信息
    /// </summary>
    /// <param name="context"></param>
    protected void ArticleList(HttpContext context)
    {
        string result = string.Empty;
        int CUId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            CUId = user.uId;
        }

        DB2.tblBLOG bll_tblBLOG = new DB2.tblBLOG();
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        
        int uid = TypeChangeDefault.NullToInt(context.Request["uid"], 0);
        int type = TypeChangeDefault.NullToInt(context.Request["type"], 0);//文章分类
        if (type == 5)
        {
            Pagesize = 100;//显示条数
        }
        DataTable dtArticle = new DataTable();
        int status = 0;
        if (uid == CUId)
        {
            status = 1;
        }
        dtArticle = bll_tblBLOG.GetListByuId(uid,type.ToString(), pageIndex,Pagesize ).Tables[0];
        List<Hashtable> ArticleInfoList = new List<Hashtable>();
        DB2.tblBLOG_SUMMARY bllSummary = new DB2.tblBLOG_SUMMARY();
        if (dtArticle.Rows.Count > 0)
        {
            for (int i = 0; i < dtArticle.Rows.Count; i++)
            {
                Hashtable ArticleInfo = new Hashtable();
                int idBlog=TypeChangeDefault.NullToInt( dtArticle.Rows[i]["id"], 0);
                ArticleInfo.Add("id", dtArticle.Rows[i]["id"].ToString());
                ArticleInfo.Add("cTitle", dtArticle.Rows[i]["cTitle"].ToString());
                ArticleInfo.Add("cContent", XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(dtArticle.Rows[i]["cContent"].ToString())), 220));
                ArticleInfo.Add("dCreate",DateStringFromNow(TypeChange.NullToDateTime(dtArticle.Rows[i]["dCreate"], DateTime.Now)));
                DBM2.tblBLOG_SUMMARY SummaryModel = bllSummary.GetModel(idBlog);
                Hashtable Summary = new Hashtable();
                Summary.Add("iShowTimes", SummaryModel.iShowTimes);
                Summary.Add("iDiscuss", SummaryModel.iDiscuss);
                Summary.Add("iDing", SummaryModel.iDing);
                Summary.Add("iFocus", SummaryModel.iFocus);
                ArticleInfo.Add("show", Summary);
                ArticleInfo.Add("cThumbUrl", new DB3.tblIMAGES().GetThumbUrl(6, "idInfo=" + idBlog, "id").Tables[0]);
                ArticleInfo.Add("status", status);
                ArticleInfoList.Add(ArticleInfo);
            }
        }
        IsoDateTimeConverter iso = new IsoDateTimeConverter();
        iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
        context.Response.Write(JsonConvert.SerializeObject(ArticleInfoList, iso));
    }
    //文章分类：0博客，3赛事，4约跑，5装备，6俱乐部，2全部
    /// <summary>
    /// 获得个人关注的文章列表信息
    /// </summary>
    /// <param name="context"></param>
    public void FocusArticleList(HttpContext context)
    {
        string result = string.Empty;
        int CUId = 0;
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel user = context.Session["CurrentUser"] as UserInfoModel;
            CUId = user.uId;
        }
        int pageIndex = TypeChangeDefault.NullToInt(context.Request["p"], 1);//当前页数
        int Pagesize = 20;//显示条数
        int uid = TypeChangeDefault.NullToInt(context.Request["uid"], 0);
        string type = TypeChangeDefault.NullToString(context.Request["type"], "0");//文章分类
        int status = 0;
        if (uid == CUId)
        {
            status = 1;
        }
        if (status == 0 && type != "3")
        {
            context.Response.Write("[]");
        }
        else if (status == 1 || (status == 0 && type == "3"))
        {
            DB3.tblATTENTION uFocus = new DB3.tblATTENTION();
            string IdBlogs = uFocus.GetAttentionIdList(uid, 2, 0);
            DB2.tblBLOG bll = new DB2.tblBLOG();
            DataTable dt = bll.GetFocusList(IdBlogs, type, pageIndex, Pagesize).Tables[0];
            List<Hashtable> ArticleInfoList = new List<Hashtable>();
            DB2.tblBLOG_SUMMARY bllSummary = new DB2.tblBLOG_SUMMARY();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Hashtable ArticleInfo = new Hashtable();
                    int idBlog = TypeChangeDefault.NullToInt(dt.Rows[i]["id"], 0);
                    ArticleInfo.Add("id", dt.Rows[i]["id"].ToString());
                    ArticleInfo.Add("cTitle", dt.Rows[i]["cTitle"].ToString());
                    ArticleInfo.Add("cContent", XString.ContentTrunc(HTMLHelper.NoHTML(HTMLHelper.NoHTML(dt.Rows[i]["cContent"].ToString())), 220));
                    ArticleInfo.Add("dCreate", DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dCreate"], DateTime.Now)));
                    DBM2.tblBLOG_SUMMARY SummaryModel = bllSummary.GetModel(idBlog);
                    Hashtable Summary = new Hashtable();
                    Summary.Add("iShowTimes", SummaryModel.iShowTimes);
                    Summary.Add("iDiscuss", SummaryModel.iDiscuss);
                    Summary.Add("iDing", SummaryModel.iDing);
                    Summary.Add("iFocus", SummaryModel.iFocus);
                    ArticleInfo.Add("show", Summary);
                    ArticleInfo.Add("cThumbUrl", new DB3.tblIMAGES().GetThumbUrl(6, "idInfo=" + idBlog, "id").Tables[0]);
                    ArticleInfo.Add("status", status);
                    ArticleInfoList.Add(ArticleInfo);
                }
            }
            IsoDateTimeConverter iso = new IsoDateTimeConverter();
            iso.DateTimeFormat = "yyyy-MM-dd HH:mm";
            context.Response.Write(JsonConvert.SerializeObject(ArticleInfoList, iso));
        }
    }
    /// <summary>
    /// 取消关注博客
    /// </summary>
    /// <param name="context"></param>
    public void UnFollow(HttpContext context)
    {
        int idBlog = TypeChangeDefault.NullToInt(context.Request["bId"], 0);
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            string returevalue = new FocusLand().AttentionState(model.uId, idBlog, 0, 2);
            if (returevalue == "1")
            {
                result="{\"msg\":\"取消关注成功\",\"status\":\"1\"}";
                ResponseEnd(context, result);
            }
            else
            {
                result="{\"msg\":\"取消关注失败\",\"status\":\"0\"}";
                ResponseEnd(context, result);
            }
        }
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
    protected void ResponseEnd(HttpContext context, string result)
    {
        context.Response.Write(result);
        context.Response.End();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}