<%@ WebHandler Language="C#" Class="GetMessageList" %>

using System;
using System.Web;
using System.Web.SessionState;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Data;
using System.Text;
using Erun360.Model;
using Erun360.BLL;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
public class GetMessageList : IHttpHandler, IReadOnlySessionState
{

    private int _table_index_of_idUser = 0;
    public void ProcessRequest(HttpContext context)
    {
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
    public void MessageList(HttpContext context)
    {
        //具体的页面数
        int pageIndex;
        int.TryParse(context.Request["pageIndex"], out pageIndex);

        //页面显示条数
        int Pagesize = Convert.ToInt32(context.Request["pageSize"]);

        if (pageIndex == 0)
        {
            pageIndex = 1;
        }
        StringBuilder strSql = new StringBuilder();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            DB3.tblDISCUSS discuss = new DB3.tblDISCUSS();
            _table_index_of_idUser = model.uId;
            string table = String.Format(@"tblDISCUSS_{0:D1}", _table_index_of_idUser % 10);
            string strWhere = "  dCreate in (select max(dCreate) from " + table + " where idInfo =" + model.uId + " group by idUser )  and idInfo =" + model.uId;

            DataTable dtMessage = discuss.GetListByPage(strWhere, " dCreate desc ", pageIndex, Pagesize, model.uId).Tables[0];


            if (dtMessage.Rows.Count > 0)
            {
                for (int i = 0; i < dtMessage.Rows.Count; i++)
                {
                    DB1.tblMEMBER tm = new DB1.tblMEMBER();
                    DBM1.tblMEMBER idInfo = new DBM1.tblMEMBER();

                    idInfo = tm.GetModel(int.Parse(dtMessage.Rows[i]["idUser"].ToString()));
                    //strSql.Append("<li> <a href=\"MessageBox.aspx?uId=" + idInfo.id + "\"><span>" + dtMessage.Rows[i]["dCreate"].ToString() + "</span>");
                    strSql.Append("<li> <a href=\"MessageBox.aspx?uId=" + model.uId + "&idInfo=" + idInfo.id + "\"><span>" + Convert.ToDateTime(dtMessage.Rows[i]["dCreate"].ToString()).ToString("yyyy-MM-dd HH:mm") + "</span>");
                    if (idInfo.cAvatar.Trim().Length > 0)
                    {
                        strSql.Append("<img src=\"" + idInfo.cAvatar + "\"");
                    }
                    else
                    {
                        strSql.Append("<img src=\"../Html/images/wl/2.png\"");
                    }
                    strSql.Append(" class=\"userimg\"> <em>" + idInfo.cNickName + "：</em>");
                    strSql.Append("<br>" + dtMessage.Rows[i]["cContent"].ToString() + "</a>");
                    int count = Convert.ToInt32(new DB3.tblMessage().GetRecordCount(" uId=" + model.uId + " and cId=" + idInfo.id + " and itype=31  "));
                    if (count > 0)
                    {
                        strSql.Append("<div class=\"newtip\">" + count + "</div>");
                    }
                    strSql.Append("</li>");
                }
            }
            else
            {
                strSql.Append("<li>暂无留言 ！</li>");
            }
        }
        context.Response.Write(strSql.ToString());
    }
    public void addMsg(HttpContext context)
    {
        //string strMsg = string.Empty;
        //if (context.Request["text"] != null)
        //{
        //    strMsg = context.Request["text"].ToString();
        //    if (strMsg.Trim().Length > 256)
        //    {
        //        context.Response.Write("ERROR");
        //    }
        //}
        //else
        //{
        //    context.Response.Write("ERROR");
        //}
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["text"]), "");
        if (strMsg.Trim().Length > 256)
        {
            context.Response.Write("1");
        }
        else
        {
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                string id = context.Request.UrlReferrer.Query;
                //int idInfo = int.Parse(id.Substring(5, 9));//取被留言人id     
                int idInfo = int.Parse(id.Substring(id.Length - 9, 9));
                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                disModel.cLoginname = model.cNickName;
                disModel.cContent = strMsg.Trim();
                disModel.idInfo = idInfo;
                disModel.idUser = model.uId;
                // disModel.dCreate = DateTime.Now;
                int imessage = disBll.Add(disModel);
                if (imessage > 0)
                {
                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                    mMessage.cId = model.uId;
                    mMessage.uId = idInfo;
                    mMessage.itype = 31;
                    mMessage.idcode = imessage;
                    new DB3.tblMessage().Add(mMessage);
                    MsgBoxlist(context);
                }
                else
                {
                    context.Response.Write("ERROR");
                }
            }
            else
            {
                context.Response.Write("ERROR");
            }
        }
        //context.Response.Write(strSql.ToString());
    }
    //与某人留言对话列表   
    public void MsgBoxlist(HttpContext context)
    {
        StringBuilder strSql = new StringBuilder();
        if (context.Session["CurrentUser"] != null)
        {
            UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
            string id = context.Request.UrlReferrer.Query;
            //string middstr = id.Substring(5, 9);//从左边起第11位开始取10个  
            string middstr = id.Substring(id.Length - 9, 9);
            int idInfo = int.Parse(middstr);
            //具体的页面数
            int pageIndex;
            int.TryParse(context.Request["pageIndex"], out pageIndex);
            //页面显示条数
            int Pagesize = Convert.ToInt32(context.Request["pageSize"]);
            if (pageIndex == 0)
            {
                pageIndex = 1;
            }
            DB3.tblDISCUSS discuss = new DB3.tblDISCUSS();

            StringBuilder sb = new StringBuilder();

            //_table_index_of_idUser = UserInfo.id;
            //获取个人留言
            string tableidUser = String.Format(@"tblDISCUSS_{0:D1}", model.uId % 10);
            string strWhereidUser = " where idInfo=" + model.uId + " and idUser=" + idInfo;
            sb.Append("SELECT[id],[idInfo],[idUser],[iMood],[cLoginname],[cContent],[dCreate]  FROM  " + tableidUser);
            sb.Append(strWhereidUser);
            //好友留言
            string tableidInfo = String.Format(@"tblDISCUSS_{0:D1}", idInfo % 10);
            string strWhereidInfo = " where idInfo=" + idInfo + " and idUser=" + model.uId;
            sb.Append(" UNION ALL ");
            sb.Append("   SELECT[id],[idInfo],[idUser],[iMood],[cLoginname],[cContent],[dCreate]  FROM  " + tableidInfo);
            sb.Append(strWhereidInfo);
            //discuss.GetListByPage
            DataTable dtMessage = discuss.QueryByPage(sb.ToString(), " ", " dCreate desc ", Pagesize, pageIndex).Tables[0];

            if (dtMessage.Rows.Count > 0)
            {
                DB1.tblMEMBER tm = new DB1.tblMEMBER();
                DBM1.tblMEMBER idInfoModel = new DBM1.tblMEMBER();
                for (int i = 0; i < dtMessage.Rows.Count; i++)
                {
                    if (idInfo == int.Parse(dtMessage.Rows[i]["idUser"].ToString()))
                    {
                        //她说的话
                        idInfoModel = tm.GetModel(int.Parse(dtMessage.Rows[i]["idUser"].ToString()));
                        strSql.Append("<li> <a target=\"_blank\" href=\"../user/" + idInfoModel.id + ".aspx\" class=\"user-img\">");
                        if (idInfoModel.cAvatar.Trim().Length > 0)
                        {
                            strSql.Append("<img src=\"" + idInfoModel.cAvatar + "\" >");
                        }
                        else
                        {
                            strSql.Append("<img src=\"/Html/images/wl/2.png\" >");
                        }
                        //strSql.Append("</a> <div class=\"om-a\"><a class=\"delete\" href=\"\">x</a> <em></em><div class=\"om-a-n\"><a href=\"\" class=\"user\">");
                        strSql.Append("</a> <div class=\"om-a\"><em></em><div class=\"om-a-n\"><a class=\"user\">");
                        strSql.Append(dtMessage.Rows[i]["cLoginname"].ToString() + "</a>：");
                        //strSql.Append(idInfoModel.cNickName + "</a>：");
                        strSql.Append(dtMessage.Rows[i]["cContent"].ToString());
                        strSql.Append("<span>" + Convert.ToDateTime(dtMessage.Rows[i]["dCreate"].ToString()).ToString("yyyy-MM-dd HH:mm") + " </span> </div></div></li>");
                    }
                    else
                    {
                        //我说的话
                        strSql.Append("<li class=\"oneself-message\"> <a class=\"user-img\">");
                        if (model.cAvatar.Trim().Length > 0)
                        {
                            strSql.Append("<img src=\"" + model.cAvatar + "\">");
                        }
                        else
                        {
                            strSql.Append("<img src=\"../Html/images/wl/2.png\">");
                        }
                        //删除暂时不做，样式去掉
                        //strSql.Append("</a> <div class=\"om-a\"><a class=\"delete\" href=\"\">x</a> <em></em><div class=\"om-a-n\"><a href=\"\" class=\"user\">");
                        strSql.Append("</a> <div class=\"om-a\"><em></em><div class=\"om-a-n\"><a class=\"user\">");
                        //strSql.Append(dtMessage.Rows[i]["cLoginname"].ToString() + "</a>：");
                        strSql.Append("我</a>：");
                        //strSql.Append(UserInfo.cNickName + "</a>：");
                        strSql.Append(dtMessage.Rows[i]["cContent"].ToString());
                        strSql.Append("<span>" + Convert.ToDateTime(dtMessage.Rows[i]["dCreate"].ToString()).ToString("yyyy-MM-dd HH:mm") + " </span> </div></div></li>");
                    }
                }
            }
        }
        context.Response.Write(strSql.ToString());
    }
    /// <summary>
    /// 回复评论
    /// </summary>
    /// <param name="context"></param>
    public void AddHuiFu(HttpContext context)
    {
        // -1 未登录，0，失败，1成功
        //op 1博客评论回复,2留言回复      
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//op =1博客评论回复,2留言回复        
        int idBlog = TypeChangeDefault.NullToInt(context.Request["idBlog"], 0);//被回复博客id
        int idUser = TypeChangeDefault.NullToInt(context.Request["idUser"], 0);//被回复人id
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");//被回复人id

        if (strMsg.Trim().Length > 0 && strMsg.Trim().Length < 128)
        {
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                DBM1.tblMEMBER menber = new DB1.tblMEMBER().GetModelByCache(idUser);
                DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModelByCache(idBlog);
                //model.uId 当前回复人id，iduser 被回复人id  mBlog.idUser 发布博客人id
                if (menber != null && mBlog != null)
                {
                    int classify = TypeChangeDefault.NullToInt(mBlog.idHref.ToString().Substring(0, 1), 99);
                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                    if (classify == 0)
                    {
                        mMessage.itype = 32;
                    }
                    else if (classify == 5)
                    {
                        mMessage.itype = 34;
                    }
                    else if (classify == 3)
                    {
                        mMessage.itype = 33;
                    }

                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cLoginname = model.cNickName;
                    disModel.cContent = "回复  <a target=\"_blank\" href=\"/user/" + menber.id + ".aspx\">" + menber.cNickName + "</a>:" + strMsg;
                    //<a target="_blank" href="/user/100000004.aspx">丁剑</a>
                    disModel.idUser = model.uId;

                    if (op == 1)
                    {
                        disModel.idInfo = idBlog;
                        int imessage = disBll.Add(disModel);
                        //插入评论数量
                        DB1.tblMEMBER_SUMMARY msbll = new DB1.tblMEMBER_SUMMARY();
                        DBM1.tblMEMBER_SUMMARY msModel = new DBM1.tblMEMBER_SUMMARY();
                        msModel = msbll.GetModel(model.uId);
                        msModel.idUser = model.uId;
                        //msModel.iScore = msModel.iScore + 1;
                        msModel.iDiscuss = msModel.iDiscuss + 1;
                        msbll.Update(msModel);
                        //插入积分
                        //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                        //uMember_History.Insert(model.uId, 100800109, 1);
                        new DB1.tblIntegral().InsertScore(model.uId, 200810013, 1, 0);
                        //更新博客数量
                        DB2.tblBLOG_SUMMARY bsbll = new DB2.tblBLOG_SUMMARY();
                        DBM2.tblBLOG_SUMMARY bsModel = new DBM2.tblBLOG_SUMMARY();
                        bsModel = bsbll.GetModel(idBlog);
                        bsModel.idBlog = idBlog;
                        bsModel.iDiscuss = bsModel.iDiscuss + 1;
                        bsbll.Update(bsModel);

                        if (bsModel != null)
                        {
                            string CacheKey = "tblBLOG_SUMMARYModel-" + idBlog;
                            bsModel = bsbll.GetModel(idBlog);
                            int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                            Erun360.Common.DataCache.SetCache(CacheKey, bsModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                        }
                        if (model.uId == idUser)
                        {
                            if (model.uId != mBlog.idUser)
                            {
                                mMessage.cId = model.uId;
                                mMessage.uId = mBlog.idUser;//发布博客人id
                                mMessage.idcode = imessage;
                                mMessage.bId = idBlog;
                                new DB3.tblMessage().Add(mMessage);//插入评论
                                context.Response.Write("1");
                            }
                            else
                            {
                                context.Response.Write("1");
                            }
                        }
                        else
                        {
                            if (model.uId == mBlog.idUser)
                            {
                                mMessage.cId = model.uId;
                                mMessage.uId = idUser;
                                mMessage.itype = 37;//评论回复 类型为37
                                mMessage.idcode = imessage;
                                mMessage.bId = idBlog;
                                new DB3.tblMessage().Add(mMessage);
                                context.Response.Write("1");
                            }
                            else
                            {
                                if (mBlog.idUser == idUser)
                                {
                                    mMessage.cId = model.uId;
                                    mMessage.uId = idUser;
                                    mMessage.itype = 37;//评论回复 类型为37
                                    mMessage.idcode = imessage;
                                    mMessage.bId = idBlog;
                                    new DB3.tblMessage().Add(mMessage);
                                    context.Response.Write("1");
                                }
                                else
                                {
                                    //插入评论
                                    mMessage.cId = model.uId;
                                    mMessage.uId = mBlog.idUser;//发布博客人id
                                    mMessage.idcode = imessage;
                                    mMessage.bId = idBlog;
                                    new DB3.tblMessage().Add(mMessage);//插入评论

                                    //插入回复
                                    mMessage.cId = model.uId;
                                    mMessage.uId = idUser;
                                    mMessage.itype = 37;//评论回复 类型为37
                                    mMessage.idcode = imessage;
                                    mMessage.bId = idBlog;
                                    new DB3.tblMessage().Add(mMessage);

                                    context.Response.Write("1");
                                }
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
                    context.Response.Write("0");//失败
                }
            }
            else
            {
                context.Response.Write("-1");//未登录
            }
        }
        else
        {
            context.Response.Write("2");//留言为空
        }

    }
    /// <summary>
    /// 回复鞋的评论，只给回复人留言
    /// </summary>
    /// <param name="context"></param>
    public void AddHuiFuByShoe(HttpContext context)
    {
        // -1 未登录，0，失败，1成功
        //op 1博客评论回复,2留言回复      
        int op = TypeChangeDefault.NullToInt(context.Request["op"], 0);//op =1博客评论回复,2留言回复        
        int idShoe = TypeChangeDefault.NullToInt(context.Request["id"], 0);//鞋的id
        int idUser = TypeChangeDefault.NullToInt(context.Request["idUser"], 0);//被回复人id
        string strMsg = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["msg"]), "");//被回复人id

        if (strMsg.Trim().Length > 0 && strMsg.Trim().Length < 128)
        {
            if (context.Session["CurrentUser"] != null)
            {
                UserInfoModel model = context.Session["CurrentUser"] as UserInfoModel;
                DBM1.tblMEMBER menber = new DB1.tblMEMBER().GetModelByCache(idUser);
                DBM5.tblShoes mShoe = new DB5.tblShoes().GetModel(idShoe);

                //model.uId 当前回复人id，iduser 被回复人id  mBlog.idUser 发布博客人id
                if (menber != null && mShoe != null)
                {
                    DBM3.tblMessage mMessage = new DBM3.tblMessage();

                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cLoginname = model.cNickName;
                    disModel.cContent = "回复  <a target=\"_blank\" href=\"/user/" + menber.id + ".aspx\">" + menber.cNickName + "</a>:" + strMsg;
                    //<a target="_blank" href="/user/100000004.aspx">丁剑</a>
                    disModel.idUser = model.uId;

                    if (op == 1)
                    {
                        disModel.idInfo = idShoe;
                        int imessage = disBll.Add(disModel);

                        //插入回复
                        mMessage.cId = model.uId;
                        mMessage.uId = idUser;
                        mMessage.itype = 38;//评论回复 类型为37
                        mMessage.idcode = imessage;
                        mMessage.bId = idShoe;
                        new DB3.tblMessage().Add(mMessage);
                        context.Response.Write("1");
                    }
                    else
                    {
                        context.Response.Write("0");
                    }
                }
                else
                {
                    context.Response.Write("0");//失败
                }
            }
            else
            {
                context.Response.Write("-1");//未登录
            }
        }
        else
        {
            context.Response.Write("2");//留言为空
        }
    }
    /// <summary>
    /// 回复评论
    /// </summary>
    /// <param name="context"></param>
    public void state(HttpContext context)
    {
        if (context.Session["CurrentUser"] != null)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("-1");
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