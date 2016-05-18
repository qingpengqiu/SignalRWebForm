using System;
using System.IO;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using System.Text;
using ERUN360.Entity;
public partial class _Home_Default : PageBase
{
    public ADRight addgg = new ADRight();
    DB1.tblTour tourBll = new DB1.tblTour();
    int ModelCache = 10;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title = "益跑网-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        if (!IsPostBack)
        {
            #region 焦点图
            string KeyFocus = "IndexFocusmap";
            object Focusmap = Erun360.Common.DataCache.GetCache(KeyFocus);
            if (Focusmap == null)
            {
                Focusmap = new Erun360.BLL.DB2.tblFocusmap().GetList(6, "idChannel=30000 and iStatus =1", "dCreate desc,id desc").Tables[0];
                if (Focusmap != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyFocus, Focusmap, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            DataTable dtFocus = Focusmap as DataTable;
            for (int i = 0; i < dtFocus.Rows.Count; i++)
            {
                if (i == 0)
                {
                    ltljdt.Text += "<li class=\"tm\"><a class=\"imgTop\" href=\"" + dtFocus.Rows[i]["cLink"].ToString() + "\" target=\"_blank\"><img data-echo=\"" + dtFocus.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\" src=\"/Html/images/blank.gif\" /></a><div class=\"imgCen\">" + dtFocus.Rows[i]["cTitle"].ToString() + "</div></li>";
                }
                else
                {
                    ltljdt.Text += "<li><a class=\"imgTop\" href=\"" + dtFocus.Rows[i]["cLink"].ToString() + "\" target=\"_blank\"><img data-echo=\"" + dtFocus.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\" src=\"/Html/images/blank.gif\" /></a><div class=\"imgCen\">" + dtFocus.Rows[i]["cTitle"].ToString() + "</div></li>";
                }
            }
            #endregion
            #region 文章列表
            string KeyArticle = "IndexArticle";
            object Article = Erun360.Common.DataCache.GetCache(KeyArticle);
            if (Article == null)
            {
                DBM2.tblChannel model = new DB2.tblChannel().GetModel(30000);
                DB2.tblPush bll = new DB2.tblPush();
                Article = bll.GetList(model.iMaxPageSize ?? 0, "dPush <=GETDATE()", "dPush desc").Tables[0];
                if (Article != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyArticle, Article, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            string KeyFlow = "indexADFlow";
            object Flow = Erun360.Common.DataCache.GetCache(KeyFlow);
            if (Flow == null)
            {
                DB2.tblADFlow flow = new DB2.tblADFlow();
                Flow = flow.GetList("GETDATE() between dBegintime and dEndtime and idChannel = 30000 and iPage=1").Tables[0];
                if (Flow != null)
                {
                    //int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(KeyFlow, Flow, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            DataTable dt = Article as DataTable;
            StringBuilder sb = new StringBuilder();
            DataTable dtflow = Flow as DataTable;

            if (dt != null)
            {
                int count = dt.Rows.Count;
                for (int i = 0; i < count; i++)
                {
                    if (dtflow != null)
                    {
                        DataRow[] dr = dtflow.Select("iIndex=" + i);
                        if (dr.Length > 0)
                        {
                            sb.Append(dr[0]["cHtml"].ToString());
                            if ("2" == dr[0]["iShow"].ToString())
                            {
                                sb.Append("<div class=\"V3Consulth V3Consulthm\"></div>");
                            }
                        }
                        else
                        {
                            sb.Append("<div class=\"V3Consulth\"></div>");
                        }
                    }
                    sb.Append("<div class=\"V3Consult\">");
                    sb.Append("<a class=\"V3TopTip\" target=\"_blank\" href=\"/Channels/list.aspx?id=" + dt.Rows[i]["idClass"].ToString() + "\">" + dt.Rows[i]["cClassName"].ToString() + "</a>");
                    sb.Append("<a target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">");
                    sb.Append("<img src=\"/Html/images/blank.gif\" data-echo=\"" + dt.Rows[i]["cImageUrl"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\">");
                    sb.Append("<h3>" + dt.Rows[i]["cTitle"].ToString() + "</h3>");
                    sb.Append("</a>");
                    if (dt.Rows[i]["iType"].ToString() == "1")//文章
                    {
                        sb.Append("<em>by: <a target=\"_blank\" class=\"listusername\" href=\"/user/" + dt.Rows[i]["idUser"].ToString() + ".aspx\">" + dt.Rows[i]["cNickName"].ToString() + "</a></em>" + DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)) + "");
                        sb.Append("<p>" + dt.Rows[i]["cBio"].ToString() + "</p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "2")//赛事报名
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString());
                        if ("1" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">立即报名</a>");
                        }
                        else if ("2" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/result.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=6\">成绩查询</a>");
                        }
                        else if ("3" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/gallery.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=11\">查看相册</a>");
                        }
                        else if ("4" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/hotel.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=4\">查看酒店</a>");
                        }
                        else if ("5" == dt.Rows[i]["cMark"].ToString())
                        {
                            sb.Append("<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/equipment.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=8\">查看装备</a>");
                        }
                        sb.Append("</p>");

                        //sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a target=\"_blank\" class=\"V3ConsultButtom\"  href=\"/Competetion/projects.aspx?sid=" + dt.Rows[i]["idInfo"].ToString() + "&nav=2\">立即报名</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "3")//约跑
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"" + dt.Rows[i]["cLinkUrl"].ToString() + "\">立即报名</a></p>");
                    }
                    else if (dt.Rows[i]["iType"].ToString() == "4")//拼团
                    {
                        sb.Append(DateStringFromNow(TypeChange.NullToDateTime(dt.Rows[i]["dPush"], DateTime.Now)));
                        sb.Append("<p class=\"V3ConsultP\">" + dt.Rows[i]["cBio"].ToString() + "<a class=\"V3ConsultButtom\" target=\"_blank\" href=\"\">立即拼团</a></p>");
                    }
                    sb.Append("</div>");
                    //if (i != dt.Rows.Count-1)
                    //    sb.Append("<div class=\"V3Consulth\"></div>");
                }
            }
            ltlBlog.Text = sb.ToString();
            #endregion
            #region 推荐用户
            //string KeyUser = "IndexUser";
            //object UserList = Erun360.Common.DataCache.GetCache(KeyUser);
            //if (UserList == null)
            //{
            //    DB3.tblRecom bll = new DB3.tblRecom();
            //    UserList = bll.GetList(15, "cState=1", " NEWID()").Tables[0];
            //    if (Article != null)
            //    {
            //        int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
            //        Erun360.Common.DataCache.SetCache(KeyUser, UserList, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
            //    }
            //}
            //DataTable dtUser = UserList as DataTable;
            //for (int i = 0; i < dtUser.Rows.Count; i++)
            //{
            //    DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(TypeChangeDefault.NullToInt(dtUser.Rows[i]["idUser"], 0));
            //    if (model != null)
            //    {
            //        ltlUser.Text += "<div class=\"V3HotUser\"><i>" + UserStyle(TypeChangeDefault.NullToInt(dtUser.Rows[i]["cType"], 0)) + "</i><a href=\"/user/" + dtUser.Rows[i]["idUser"].ToString() + ".aspx\"><img src=\"" + model.cAvatar + "\"><span>" + model.cNickName + "</span></a><p>" + dtUser.Rows[i]["cBio"].ToString() + "</p><em data-id=\"" + dtUser.Rows[i]["idUser"].ToString() + "\">关注TA</em></div>";
            //    }
            //}
            #endregion
            #region 右侧拼团产品
            DB1.tblGoods Bll = new DB1.tblGoods();
            DataTable dttour = Bll.GetList(3, "iState=1 and iType =2 and  dEndTime>GETDATE()", "id desc").Tables[0];
            for (int i = 0; i < dttour.Rows.Count; i++)
            {
                int idGood = TypeChange.NullToInt(dttour.Rows[i]["id"].ToString(), 0);
                ltlTour.Text += " <div class=\"V3RiP\">";
                ltlTour.Text += " <a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + dttour.Rows[i]["id"].ToString() + "\">" + Getems(idGood.ToString()) + dttour.Rows[i]["cName"].ToString() + GetScore(dttour.Rows[i]["fScore"].ToString()) + "</a> <br>";
                //ltlTour.Text += " <a href=\"/GroupBuy/Group.aspx?id=" + dttour.Rows[i]["id"].ToString() + "\">【益秒杀】" + dttour.Rows[i]["cName"].ToString() + " <span>积分抵扣</span></a> <br>";
                ltlTour.Text += "拼团价：<em>￥" + GetTour(idGood.ToString()) + "<i>(" + Getzk(idGood.ToString(), dttour.Rows[i]["fMarketPrice"].ToString()) + "折)</i></em>";
                ltlTour.Text += "<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\"><img src=\"/Html/images/blank.gif\" data-echo=\"" + dttour.Rows[i]["cImage"].ToString().Replace(HostInfo.imgName, HostInfo.imgCDN) + "\"></a>";
                ltlTour.Text += "<a class=\"V3RiPB\" target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">立即拼团</a>";
                ltlTour.Text += "</div>";
            }
            #endregion
        }
    }
    #region 拼团
    //拼团最低价格
    public string GetScore(string fScore)
    {
        if (fScore == "1")
            return "<span>积分抵扣</span>";
        return "";
    }
    //拼团最低价格
    public string GetTour(string idGood)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        return dt.Rows[0]["fBuyPrice"].ToString();
    }
    //益秒杀
    public string Getems(string idGood)
    {
        int ems = tourBll.GetRecordCount("idGood=" + idGood);
        if (ems == 1)
            return "【益秒杀】";
        return "";
    }
    //折扣
    public string Getzk(string idGood, string MarketPrice)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        decimal mp = TypeChangeDefault.NullToDecimal(MarketPrice, 1);
        if (mp == 0)
        {
            mp = 1;
        }

        return (TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"], 0) / mp * 10).ToString("f");
    }
    #endregion

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
    private string UserStyle(int cType)
    {
        string Style = string.Empty;
        switch (cType)
        {
            case 1: Style = "特约专家"; break;
            case 2: Style = "明星跑者"; break;
            case 3: Style = "海外跑者"; break;
            case 4: Style = "测评达人"; break;
        }
        return Style;
    }
}