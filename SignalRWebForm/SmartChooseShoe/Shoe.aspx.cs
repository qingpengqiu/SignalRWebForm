using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Text;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
using System.Data;
public partial class infocenter_Shoe : PageBase
{
    public int uId = 0;//通过参数传递过来的用户id
    public int cId = 0;
    public int bId = 0;//通过参数传递过来的用户id
    public string DiscussList = string.Empty;
    public string ctitle = string.Empty;
    public string Result = string.Empty;
    protected DBM5.tblShoes mShoe;
    protected string pingtuan_html = string.Empty;
    protected string shoeSummary;
    protected string shoeReview;
    protected string shoeTester;
    protected string shoeVideo;
    protected string shoeEvaluationBlog;
    public ADRight addgg = new ADRight();
    DB1.tblTour tourBll = new DB1.tblTour();
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title = "高级搜索-跑步装备-益跑网-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
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
        if (Request.QueryString["id"] != null)
        {
            bId = TypeChangeDefault.NullToInt(Request.QueryString["id"].ToString(), 0);
        }

        BlogInfo bInfo = new BlogInfo();
        if (!IsPostBack)
        {
            mShoe = new DB5.tblShoes().GetModel(bId);
            if (mShoe != null)
            {
                pingtuan_html = GetPinTuanlink(mShoe.id.ToString());
                shoeEvaluationBlog = GetBlogInfo(mShoe.id.ToString());
                if (!string.IsNullOrEmpty(mShoe.cSum))
                {
                    shoeSummary = string.Format("<h2>编辑说：</h2><div class=\"shoembox\">{0}</div>", mShoe.cSum);
                }
                if (!string.IsNullOrEmpty(mShoe.cTester))
                {
                    shoeTester = string.Format("<h2>测试者：</h2><div class=\"shoembox\">{0}</div>", mShoe.cTester);
                }
                if (!string.IsNullOrEmpty(mShoe.cReview))
                {
                    shoeReview = string.Format("<h2>穿着感受：</h2><div class=\"shoembox\">{0}</div>", mShoe.cReview);
                }
                if (!string.IsNullOrEmpty(mShoe.cVideo))
                {
                    shoeVideo = string.Format("<h2>评测视频：</h2><div class=\"shoembox\">{0}</div>", mShoe.cVideo);
                }

            }
            else
            {
                Response.Redirect("/");
            }
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                DiscussList = bInfo.GetDiscussList(CurrentUser.uId, bId);
                new DB3.tblMessage().DeleteMsg(" bId=" + bId + " and itype=38 and uId=" + CurrentUser.uId);
            }
            else
            {
                DiscussList = bInfo.GetDiscussList(0, bId);
            }
        }
    }
    //检查是否与拼团产品关联，如果关联返回购买链接
    protected string GetPinTuanlink(string shoeid)
    {
        string strReturn = string.Empty;
        string strWhere = string.Format(" shoesId={0} and linktype=2 ", shoeid);
        List<DBM5.tblShoes_Linked> listofshoelink = new DB5.tblShoes_Linked().GetModelList(strWhere);
        if (listofshoelink.Count > 0)
        {
            #region 注释
            //< div class="shoebuy shoebuy1">
            //    <div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            //</ div >
            //< div class="shoebuy shoebuy2">
            //    <div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            //    < div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            // </ div >
            // < div class="shoebuy shoebuy3">
            //    <div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            //    < div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            //     < div class="shoebuybox"><b>拼团价</b>   <span>&yen;</span><i>629.00</i> <em>(7折)</em> <a href = "" > 立即拼团 </ a ></ div >
            //  </ div >
            #endregion
            string goodsids = string.Empty;
            foreach (DBM5.tblShoes_Linked shoelinked in listofshoelink)
            {
                if (!string.IsNullOrEmpty(shoelinked.linkedId))
                {
                    goodsids += shoelinked.linkedId + ",";
                }
            }
            if (!string.IsNullOrEmpty(goodsids))
            {
                goodsids = goodsids.Substring(0, goodsids.Length - 1);
            }
            //拼团购买链接
            if (!string.IsNullOrEmpty(goodsids))
            {
                DataSet dsGoodTours = new DB1.tblTour().GetGoodTourList(goodsids);
                if (dsGoodTours != null && dsGoodTours.Tables.Count > 0 && dsGoodTours.Tables[0].Rows.Count > 0)
                {
                    int count = dsGoodTours.Tables[0].Rows.Count;
                    StringBuilder linklist = new StringBuilder();
                    linklist.AppendFormat("<div class=\"shoebuy shoebuy{0}\">", count);
                    foreach (DataRow GoodTourRow in dsGoodTours.Tables[0].Rows)
                    {
                        linklist.AppendFormat("<div class=\"shoebuybox\"><b>拼团价</b><span>&yen;</span><i>{1}</i> <em>({2}折)</em> <a href = \"/GroupBuy/Group.aspx?id={0}\" target=\"_blank\" >立即拼团</a></div>", GoodTourRow["id"].ToString(), GoodTourRow["fBuyPrice"].ToString(), Getzk(GoodTourRow["id"].ToString(), GoodTourRow["fMarketPrice"].ToString()));
                    }
                    linklist.AppendFormat("</div>");
                    strReturn = linklist.ToString();
                }
            }
        }
        return strReturn;
    }

    //检查是否有关联的测评文章
    protected string GetBlogInfo(string shoeid)
    {
        string strReturn = string.Empty;
        string strWhere = string.Format(" shoesId={0} and linktype=1 ", shoeid);
        List<DBM5.tblShoes_Linked> listofshoelink = new DB5.tblShoes_Linked().GetModelList(strWhere);
        if (listofshoelink.Count > 0)
        {
            #region 注释
            //   < div class="shoebetest">
            //    <span>相关测评文章：</span>
            //    <div class="shoebetestbox">
            //        <a href = "" >< img src="/Html/images/shoe1.jpg"></a>
            //        <a href = "" >【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated</a>
            //        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
            //    </div>
            //    <div class="shoebetestbox">
            //        <a href = "" >< img src="/Html/images/shoe1.jpg"></a>
            //        <a href = "" >【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated</a>
            //        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
            //    </div>
            //    <div class="shoebetestbox">
            //        <a href = "" >< img src="/Html/images/shoe1.jpg"></a>
            //        <a href = "" >【评测】Vibram FiveFingers CVT Wool & Trek Ascent Insulated</a>
            //        <p>即将迈入第14个年头的厦门国际马拉松赛，明年将再次做出重大调整:赛事将回到厦门国际会展中心起跑，终取消半程和10公里，只设全程和5公里。</p>
            //    </div>
            //</div>
            #endregion
            //DBM5.tblShoes_Linked shoelinked = listofshoelink[0];
            string blogIds = string.Empty;
            foreach (DBM5.tblShoes_Linked shoelinked in listofshoelink)
            {
                if (!string.IsNullOrEmpty(shoelinked.linkedId))
                {
                    blogIds += shoelinked.linkedId + ",";
                }
            }
            if (!string.IsNullOrEmpty(blogIds))
            {
                blogIds = blogIds.Substring(0, blogIds.Length - 1);
            }
            if (!string.IsNullOrEmpty(blogIds))
            {
                strWhere = string.Format(" id in({0}) ", blogIds);
                List<DBM2.tblBLOG> ListOfBlog = new DB2.tblBLOG().GetModelList(strWhere);
                if (ListOfBlog.Count > 0)
                {
                    StringBuilder bloglist = new StringBuilder();
                    bloglist.AppendFormat("<div class=\"shoebetest\"><span>相关测评文章：</span>");
                    foreach (DBM2.tblBLOG BlogModel in ListOfBlog)
                    {
                        DBM3.tblIMAGES imgModel = new DB3.tblIMAGES().GetModelByidBolg(BlogModel.id);
                        string imgurl = "/Html/images/mrsj.jpg ";
                        if (imgModel!=null)
                        {
                            if (string.IsNullOrEmpty(imgModel.cImageUrl))
                            {
                                imgurl = imgModel.cImageUrl;
                            }
                        }
                        bloglist.AppendFormat("<div class=\"shoebetestbox\">" +
                                                "<a href = \"/blog/{0}.aspx\" target=\"_blank\" ><img src=\"{2}\"></a>" +
                                                "<a href = \"/blog/{0}.aspx\" target=\"_blank\" >{1}</a>" +
                                                "<p>{3}</p>" +
                                            "</div>", BlogModel.id,BlogModel.cTitle, imgurl, XString.ContentTrunc(HTMLHelper.NoHTML(BlogModel.cContent), 60));
                    }
                    bloglist.AppendFormat("</div>");
                    strReturn = bloglist.ToString();
                }
            }
        }
        return strReturn;
    }

    //折扣
    public string Getzk(string idGood, string MarketPrice)
    {
        DataTable dt = new DB1.tblTour().GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        decimal mp = TypeChangeDefault.NullToDecimal(MarketPrice, 1);
        if (mp == 0)
        {
            mp = 1;
        }
        return (TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"], 0) / mp * 10).ToString("f");
    }
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
    //拼团最低价格
    public string GetScore(string fScore)
    {
        if (fScore == "1")
            return "<span>积分抵扣</span>";
        return "";
    }
}