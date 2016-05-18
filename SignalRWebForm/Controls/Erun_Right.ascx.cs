using System;
using System.Text;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using System.Data;
using DBM2 = Erun360.Model.DB2;
using DB2 = Erun360.BLL.DB2;
using DB4 = Erun360.BLL.DB4;

public partial class Controls_Erun_Right : PageBaseCtrl
{
    public UserInfoModel model = new UserInfoModel();
    private int uId = 0;//通过参数传递过来的用户id
    private int bId = 0;//博客id
    public string cFans = string.Empty;//推荐好友，他的粉丝
    public string cAction = string.Empty;//热门活动，俱乐部
    public int cId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (Request.QueryString["bId"] != null)
        {
            bId = int.Parse(Request.QueryString["bId"].ToString());
        }
        if (!IsPostBack)
        {
            if (uId == 0)
            {
                DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModel(bId);
                if (mBlog != null)
                    uId = mBlog.idUser;
            }
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                if (cId == uId)
                {
                    UserInfoBll uClient = new UserInfoBll();
                    //推荐好友
                    StringBuilder recomul = new StringBuilder();
                    recomul.Append("<div class=\"recom\">推荐好友</div>");
                    recomul.Append("<ul class=\"recomul\">");

                    //编辑推荐tag=1
                    string Keybjtj = "bjtj" + cId;
                    object bjtj = Erun360.Common.DataCache.GetCache(Keybjtj);
                    if (bjtj == null)
                    {
                        //bjtj = new DB3.tblRecom().GetList(2, " and cState=1", " NEWID()").Tables[0];
                        bjtj = new DB1.tblMEMBER().GetPerson("1", " idMemberStyle>=0 and id in(SELECT top 2[idUser] FROM [YP_DB_3].[dbo].[tblRecom] where cState>0 and idUser!=" + cId + " and idUser not in (SELECT [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION] where LEFT(idInfo,1)=1 and idUser=" + cId + " ) order by NEWID())", cId);
                        if (bjtj != null)
                        {
                            int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                            Erun360.Common.DataCache.SetCache(Keybjtj, bjtj, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                        }
                    }
                    //编活动达人tag=2
                    string Keyhddr = "hddr" + cId;
                    object hddr = Erun360.Common.DataCache.GetCache(Keyhddr);
                    if (hddr == null)
                    {
                        hddr = new DB1.tblMEMBER().GetPerson("2", " idMemberStyle>=0 and id in(SELECT top 2 idUser  FROM [YP_DB_4].[dbo].[tblRACE_ACTIVITY] where idUser!=" + cId + " and idUser not in (SELECT [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION] where LEFT(idInfo,1)=1 and idUser=" + cId + " ) group by idUser  order by SUM(1) desc )", cId);
                        if (hddr != null)
                        {
                            int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                            Erun360.Common.DataCache.SetCache(Keyhddr, hddr, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                        }
                    }
                    //俱乐部tag=3
                    string Keyjlb = "jlb" + cId;
                    object jlb = Erun360.Common.DataCache.GetCache(Keyjlb);
                    if (jlb == null)
                    {
                        //jlb = new DB1.tblMEMBER().GetPerson("(SELECT id FROM [YP_DB_4].[dbo].[tblRACE_CLUB] where idUser=tblMEMBER.id)", " id in(SELECT TOP 2 [idUser] FROM [YP_DB_4].[dbo].[tblRACE_CLUB] where idUser!=" + cId + " and idUser not in (SELECT [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION] where LEFT(idInfo,1)=1 and idUser=" + cId + " ) and iAudit>3 order by NEWID() )", cId);
                        jlb = new DB1.tblMEMBER().GetClubPerson(cId);
                        if (jlb != null)
                        {
                            int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                            Erun360.Common.DataCache.SetCache(Keyjlb, jlb, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                        }
                    }
                    //好友关注 tag=4
                    string Keyhygz = "hygz" + cId;
                    object hygz = Erun360.Common.DataCache.GetCache(Keyhygz);
                    if (hygz == null)
                    {
                        hygz = new DB1.tblMEMBER().GetPerson("4", " idMemberStyle>=0 and id in (SELECT TOP 2 [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION]  where idUser=" + cId + " and idInfo!=" + cId + " and LEFT(idInfo,1)=1 and idInfo not in (SELECT [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION] where LEFT(idInfo,1)=1 and idUser=" + cId + " )  order by NEWID())", cId);
                        if (hygz != null)
                        {
                            int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                            Erun360.Common.DataCache.SetCache(Keyhygz, hygz, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                        }
                    }

                    DataTable dt3 = new DataTable();
                    dt3.Merge(bjtj as DataTable);
                    dt3.Merge(hddr as DataTable);
                    dt3.Merge(jlb as DataTable);
                    dt3.Merge(hygz as DataTable);


                    //dt.DefaultView.Sort = "id desc"; 
                    //DataTable dt = new DB1.tblMEMBER().GetTopList(uId);
                    if (dt3.Rows.Count > 0)
                    {

                        //新注册用户 tag=5
                        string Keyxzcyh = "xzcyh" + cId;
                        object xzcyh = Erun360.Common.DataCache.GetCache(Keyxzcyh);
                        if (xzcyh == null)
                        {
                            xzcyh = new DB1.tblMEMBER().GetPerson("5", 10 - dt3.Rows.Count, " idMemberStyle>=0 and id!=" + cId + " and id not in (SELECT [idInfo] FROM [YP_DB_3].[dbo].[tblATTENTION] where LEFT(idInfo,1)=1 and idUser=" + cId + " )", cId, " id desc ");
                            if (xzcyh != null)
                            {
                                int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                                Erun360.Common.DataCache.SetCache(Keyxzcyh, xzcyh, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                            }
                        }
                        dt3.Merge(xzcyh as DataTable);
                        DataView dv = dt3.DefaultView;
                        dv.Sort = "id Asc";
                        DataTable dt = dv.ToTable();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            recomul.Append("<li>");
                            if (dt.Rows[i]["tag"].ToString().Length == 9)
                            {
                                recomul.Append("<a href=\"/club/" + dt.Rows[i]["tag"].ToString() + ".aspx\" target=\"_blank\" >");
                                //recomul.Append("<em>推荐原因</em>：俱乐部");
                            }
                            else
                            {
                                recomul.Append("<a href=\"/user/" + dt.Rows[i]["id"].ToString() + ".aspx\" target=\"_blank\" >");
                            }
                            if (dt.Rows[i]["cAvatar"].ToString().Trim().Length > 0)
                                recomul.Append("<img src=\"" + dt.Rows[i]["cAvatar"].ToString() + "\">");
                            else
                                recomul.Append("<img src=\"../Html/images/wl/2.png\">");

                            recomul.Append(XString.Trunc(dt.Rows[i]["cNickName"].ToString(), 12) + " </a>");
                            recomul.Append("<br>");
                            if ("1" == dt.Rows[i]["tag"].ToString())
                            {
                                recomul.Append("<em>推荐原因</em>：编辑推荐");
                            }
                            else if ("2" == dt.Rows[i]["tag"].ToString())
                            {
                                recomul.Append("<em>推荐原因</em>：活动达人");
                            }
                            else if (dt.Rows[i]["tag"].ToString().Length == 9)
                            {
                                recomul.Append("<em>推荐原因</em>：俱乐部用户");
                            }
                            else if ("4" == dt.Rows[i]["tag"].ToString())
                            {
                                recomul.Append("<em>推荐原因</em>：好友关注");
                            }
                            else if ("5" == dt.Rows[i]["tag"].ToString())
                            {
                                recomul.Append("<em>推荐原因</em>：新注册用户");
                            }
                            recomul.Append("<br>");
                            if ("2" == dt.Rows[i]["gz"].ToString())
                            {
                                recomul.Append("<a class=\"focus-off\">相互关注</a>");
                            }
                            else if ("1" == dt.Rows[i]["gz"].ToString())
                            {
                                recomul.Append("<a class=\"focus-off\">已关注</a>");
                            }
                            else
                            {
                                recomul.Append("<a class=\"focus\"  href=\"/action/GetFoucsList.ashx?command=addFoucs&uId=" + dt.Rows[i]["id"].ToString() + "&timestamp=" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + "\">+ 关注TA</a>");
                            }

                            recomul.Append("</li>");

                        }
                    }

                    recomul.Append("</ul>");
                    cFans = recomul.ToString();
                    //热门活动               
                    //StringBuilder HotAct = new StringBuilder();
                    //HotAct.Append("<div class=\"hot-act\">热门活动</div>");
                    //HotAct.Append("<ul class=\"hot-act-ul\">");
                    //DataTable dtAct = memberClient.GetTopList(uId);
                    //if (dtAct.Rows.Count > 0)
                    //{
                    //for (int i = 0; i < 4; i++)
                    //{
                    //    HotAct.Append("<li>");
                    //    HotAct.Append("<a href=\" /infocenter/Running.aspx?uId=100000002 \">");
                    //    HotAct.Append("<img src=\"../Html/images/wl/2.png\">");
                    //    HotAct.Append("植物园跑步 </a>");
                    //    HotAct.Append("<br>");
                    //    HotAct.Append("地点：植物园跑步<br>");
                    //    HotAct.Append("时间：3月26日<br>");
                    //    HotAct.Append("</li>");
                    //}
                    //}                
                    //HotAct.Append("</ul>");
                    //cAction = HotAct.ToString();
                }
                else if (0 != uId)
                {
                    //TA的粉丝
                    StringBuilder ifans = new StringBuilder();
                    ifans.Append("<div class=\"recom\">TA的粉丝</div>");
                    ifans.Append("<ul class=\"recomul\">");
                    DB3.tblATTENTION attentionClient = new DB3.tblATTENTION();
                    DataTable dtAttention = attentionClient.GetTopList(uId);
                    if (dtAttention.Rows.Count > 0)
                    {
                        //DB1.tblMEMBER memberClient = new DB1.tblMEMBER();
                        for (int i = 0; i < dtAttention.Rows.Count; i++)
                        {
                            int id = int.Parse(dtAttention.Rows[i]["idUser"].ToString());
                            if (id == 0)
                                break;
                            //DBM1.tblMEMBER memberModel = memberClient.GetModel(id);
                            Erun360.Model.DB1.tblMEMBER memberModel = new Erun360.BLL.DB1.tblMEMBER().GetModelByCache(id);
                            if (memberModel != null)
                            {
                                ifans.Append("<li>");
                                ifans.Append("<a href=\"/user/" + id + ".aspx\" target=\"_blank\" >");
                                if (memberModel.cAvatar.Trim().Length > 0)
                                    ifans.Append("<img src=\"" + memberModel.cAvatar + "\">");
                                else
                                    ifans.Append("<img src=\"../Html/images/wl/2.png\">");

                                ifans.Append(XString.Trunc(memberModel.cNickName, 12) + " </a>");
                                ifans.Append("<br>");
                                //ifans.Append("推荐原因：原因原因原");
                                //ifans.Append("<br>");
                                if (id == cId)
                                {
                                    ifans.Append("<a class=\"focus-off\">已关注</a>");
                                }
                                else if (attentionClient.Exists("idInfo=" + memberModel.id + " and idUser=" + cId))
                                {
                                    ifans.Append("<a class=\"focus-off\">已关注</a>");
                                }
                                else
                                {
                                    ifans.Append("<a class=\"focus-ta\"  href=\"javascript:void(0)\" rel=\"/action/GetFoucsList.ashx?command=addFoucs&uId=" + memberModel.id + "&timestamp=" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + "\">+ 关注TA</a>");
                                }
                                ifans.Append("</li>");
                            }
                        }
                    }
                    else
                    {
                        ifans.Append("<li>木有粉丝</li>");
                    }

                    ifans.Append("</ul>");
                    cFans = ifans.ToString();
                    //TA加入的俱乐部
                    //StringBuilder club = new StringBuilder();
                    //club.Append("<div class=\"user-club\">TA加入的俱乐部</div>");
                    //club.Append("<ul class=\"user-club-ul\">");
                    //for (int i = 0; i < 4; i++)
                    //{
                    //    club.Append("<li>");
                    //    club.Append("<a href=\" / \">");
                    //    club.Append("<img src=\"../Html/images/wl/2.png\">");
                    //    club.Append("植物园跑步 </a>");
                    //    club.Append("</li>");
                    //}
                    //club.Append("</ul>");
                    //cAction = club.ToString();
                }
            }
            else
            {
                //TA的粉丝
                StringBuilder ifans = new StringBuilder();
                ifans.Append("<div class=\"recom\">TA的粉丝</div>");
                ifans.Append("<ul class=\"recomul\">");
                DB3.tblATTENTION attentionClient = new DB3.tblATTENTION();
                DataTable dtAttention = attentionClient.GetTopList(uId);
                if (dtAttention.Rows.Count > 0)
                {
                    //DB1.tblMEMBER memberClient = new DB1.tblMEMBER();
                    for (int i = 0; i < dtAttention.Rows.Count; i++)
                    {
                        int id = int.Parse(dtAttention.Rows[i]["idUser"].ToString());
                        if (id == 0)
                            break;
                        //DBM1.tblMEMBER memberModel = memberClient.GetModel(id);
                        Erun360.Model.DB1.tblMEMBER memberModel = new Erun360.BLL.DB1.tblMEMBER().GetModelByCache(id);
                        if (memberModel != null)
                        {
                            ifans.Append("<li>");
                            ifans.Append("<a href=\"/user/" + id + ".aspx\" target=\"_blank\" >");
                            if (memberModel.cAvatar.Trim().Length > 0)
                                ifans.Append("<img src=\"" + memberModel.cAvatar + "\">");
                            else
                                ifans.Append("<img src=\"../Html/images/wl/2.png\">");

                            ifans.Append(XString.Trunc(memberModel.cNickName, 12) + " </a>");
                            ifans.Append("<br>");
                            //ifans.Append("<a class=\"focus\">+ 关注Ta</a>");
                            ifans.Append("</li>");
                        }
                    }
                }

                ifans.Append("</ul>");
                cFans = ifans.ToString();
                //TA加入的俱乐部
                //StringBuilder club = new StringBuilder();
                //club.Append("<div class=\"user-club\">TA加入的俱乐部</div>");
                //club.Append("<ul class=\"user-club-ul\">");
                //for (int i = 0; i < 4; i++)
                //{
                //    club.Append("<li>");
                //    club.Append("<a href=\" / \">");
                //    club.Append("<img src=\"../Html/images/wl/2.png\">");
                //    club.Append("植物园跑步 </a>");
                //    club.Append("</li>");
                //}
                //club.Append("</ul>");
                //cAction = club.ToString();
            }
            //周排行
            string CacheKey = "zph";
            object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
            if (objModel == null)
            {
                objModel = new DB4.tblRACE_HISTORY().GetRaceRanking().Tables[0];
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            rptRanking.DataSource = (DataTable)objModel;
            rptRanking.DataBind();
        }

    }

}