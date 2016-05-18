using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Models_DB2 = Erun360.Model.DB2;
using BLL_DB2 = Erun360.BLL.DB2;
using Models_DB3 = Erun360.Model.DB3;
using BLL_DB3 = Erun360.BLL.DB3;
using Erun360.BLL;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using System.Text;

public partial class article_equipcontent : PageBase
{
    DB1.tblTour tourBll = new DB1.tblTour();
    protected Models_DB2.tblBLOG modelBlog;
    protected Models_DB2.tblBLOG_SUMMARY modelBlogsummary;
    public string Previous = string.Empty;
    public string Next = string.Empty;
    protected string strColllection = string.Empty;
    protected int ArticleAuthorId;
    public ADRight addgg = new ADRight();
    public int sid = 0;
    protected string classify = string.Empty;
    protected string equipinfo = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
        sid = TypeChange.NullToInt(Request.QueryString["sid"], 0);
        if (!IsPostBack)
        {
            if (0 != sid)
            {
                modelBlog = new BLL_DB2.tblBLOG().GetModel(sid);
                if (modelBlog == null)
                {
                    Response.Redirect("/404.html");
                }
                this.page_Title = modelBlog.cTitle + "-益跑网-中国领先的跑步门户网站-ERUN360.COM";
                classify = modelBlog.idHref.ToString().Substring(0, 1);

                BLL_DB2.tblBLOG_SUMMARY Blog_Summary = new BLL_DB2.tblBLOG_SUMMARY();
                modelBlogsummary = Blog_Summary.GetModel(sid);
                if (modelBlogsummary != null)
                {
                    Random seed = new Random();
                    int i2 = new Random().Next(2, 11);
                    modelBlogsummary.idBlog = sid;
                    modelBlogsummary.iShowTimes = modelBlogsummary.iShowTimes + i2;
                    Blog_Summary.Update(modelBlogsummary);

                    modelBlogsummary = Blog_Summary.GetModelByCache(sid);
                    modelBlogsummary.iShowTimes = modelBlogsummary.iShowTimes + i2;
                }
                else
                {
                    modelBlogsummary = new Models_DB2.tblBLOG_SUMMARY();
                    modelBlogsummary.iShowTimes = 2;
                    modelBlogsummary.iDiscuss = 1;
                    modelBlogsummary.iFocus = 2;
                    modelBlogsummary.iDing = 1;
                }
                ArticleAuthorId = modelBlog.idUser;
                BlogInfoNew BlogInfo = new BlogInfoNew();
                equipinfo = BlogInfo.GetSingleBolgInfo(modelBlog);
                Previous = BlogInfo.PreviousBlog(modelBlog.idUser ,modelBlog.id, classify);
                Next = BlogInfo.NextBlog(modelBlog.idUser, modelBlog.id, classify);
                #region 右侧拼团产品
                DB1.tblGoods Bll = new DB1.tblGoods();
                DataTable dttour = Bll.GetList(3, "iState=1 and iType =2 and  dEndTime>GETDATE()", "dEndTime desc").Tables[0];
                for (int i = 0; i < dttour.Rows.Count; i++)
                {
                    int idGood = TypeChange.NullToInt(dttour.Rows[i]["id"].ToString(), 0);
                    ltlTour.Text += " <div class=\"V3RiP\">";
                    ltlTour.Text += " <a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + dttour.Rows[i]["id"].ToString() + "\">" + Getems(idGood.ToString()) + dttour.Rows[i]["cName"].ToString() + GetScore(dttour.Rows[i]["fScore"].ToString()) + "</a> <br>";
                    ltlTour.Text += "拼团价：<em>￥" + GetTour(idGood.ToString()) + "<i>(" + Getzk(idGood.ToString(), dttour.Rows[i]["fMarketPrice"].ToString()) + "折)</i></em>";
                    ltlTour.Text += "<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\"><img src=\"" + dttour.Rows[i]["cImage"].ToString() + "\"></a>";
                    ltlTour.Text += "<a class=\"V3RiPB\" target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">立即拼团</a>";
                    ltlTour.Text += "</div>";
                }
                #endregion

               if (CurrentUser != null)
                {
                    #region 清除个人评论提示
                    string itype = string.Empty;
                    if (classify == "0")
                    {
                        itype = "32";
                    }
                    else if (classify == "5")
                    {
                        itype = "34";
                    }
                    else if (classify == "3")
                    {
                        itype = "33";

                    }
                    else if (classify == "4")
                    {
                        itype = "36";
                    }
                    else
                    {
                        itype = "0";
                    }
                    new BLL_DB3.tblMessage().DeleteMsg(" bId=" + sid + " and itype=" + itype + " and uId=" + CurrentUser.uId);
                    new BLL_DB3.tblMessage().DeleteMsg(" bId=" + sid + " and itype=37 and uId=" + CurrentUser.uId);
                    #endregion
                    string strwhere = string.Format("idInfo={0} and idUser={1}", int.Parse(Request.QueryString["sid"]), CurrentUser.uId);
                    List<Models_DB3.tblATTENTION> listAttention = new BLL_DB3.tblATTENTION().GetModelList(strwhere);
                    if (listAttention.Count > 0)
                    {
                        strColllection = "<a class=\"Collection\" href=\"javascript: void(0)\" data-up=\"off\"><img src=\"/assets/css/images/x.png\" />已收藏</a>";
                    }
                    else
                    {
                        strColllection = "<a class=\"Collection\" href=\"javascript:void(0)\" data-up=\"on\"><img src = \"/assets/css/images/x.png\" />收藏</a>";
                    }
                }
                else
                {
                    strColllection = "<a class=\"Collection\" href=\"javascript:void(0)\" data-up=\"on\"><img src = \"/assets/css/images/x.png\" />收藏</a>";
                }
            }
            else
            {
                Response.Redirect("/");
            }
        }
    }
    public string GetTour(string idGood)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        return dt.Rows[0]["fBuyPrice"].ToString();
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
    //益秒杀
    public string Getems(string idGood)
    {
        int ems = tourBll.GetRecordCount("idGood=" + idGood);
        if (ems == 1)
            return "【益秒杀】";
        return "";
    }
    //拼团最低价格
    public string GetScore(string fScore)
    {
        if (fScore == "1")
            return "<span>积分抵扣</span>";
        return "";
    }
}