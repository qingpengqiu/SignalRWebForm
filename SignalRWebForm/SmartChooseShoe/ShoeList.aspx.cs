using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using DB1 = Erun360.BLL.DB1;
public partial class SmartChooseShoe_ShoeList : PageBase
{
    public string Result = string.Empty;
    public int pageIndex = 1;
    public int RecordCount = 0;
    protected int weightpercent;
    protected int heightpercent;
    protected int heelpercent;
    protected int forefootpercent;
    protected int stiffnesspercent;
    protected int stabilitypercent;
    protected string cssAdvisor;
    protected string cssLikeMine;
    protected string cssSearch;
    protected string orderby;
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
        if (!IsPostBack)
        {
            StringBuilder sWhere = new StringBuilder();
            orderby = "rWeight,rHeight";
            if (Request["action"] == "advisor")
            {
                cssAdvisor = "this";
                if (string.IsNullOrEmpty(Request["gender"]))
                {
                    Response.Write("<script>alert('请输入性别!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["tall"]))
                {
                    Response.Write("<script>alert('请输入身高!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["weight"]))
                {
                    Response.Write("<script>alert('请输入体重!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["shoetype"]))
                {
                    Response.Write("<script>alert('请输入鞋型!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["runlevel"]))
                {
                    Response.Write("<script>alert('请输入您的跑步水平!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["weekrunkm"]))
                {
                    Response.Write("<script>alert('请输入周跑量!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["pacemin"]))
                {
                    Response.Write("<script>alert('请输入配速分钟数!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["pacesec"]))
                {
                    Response.Write("<script>alert('请输入配速秒数!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["injured"]))
                {
                    Response.Write("<script>alert('请输入近一年是否受伤!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["highofarch"]))
                {
                    Response.Write("<script>alert('请输入足弓高度!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["motionmechanics"]))
                {
                    Response.Write("<script>alert('请输入内外翻!');history.back();</script>");
                    Response.End();
                }
                if (string.IsNullOrEmpty(Request["strikeground"]))
                {
                    Response.Write("<script>alert('请输入着地位置!');history.back();</script>");
                    Response.End();
                }

                sWhere = GetAdvisorWhereCondition();
            }
            else if (Request["action"] == "likemine")
            {
                cssLikeMine = "this";
                sWhere = GetLikeMineWhereCondition();
            }
            else if (Request["action"] == "search")
            {
                cssSearch = "this";
                sWhere = GetSearchWhereCondition();
            }
            //具体的页面数     
            pageIndex = TypeChangeDefault.NullToInt(Request["p"], 1);
            RecordCount = new DB5.tblShoes().GetRecordCount(sWhere.ToString());
            //页面显示条数
            int Pagesize = 20;
            DataTable dt = new DB5.tblShoes().GetListByPage(sWhere.ToString(), orderby, pageIndex, Pagesize).Tables[0];

            //IsoDateTimeConverter iso = new IsoDateTimeConverter();
            //iso.DateTimeFormat = "yyyy-MM-dd";
            //Result = JsonConvert.SerializeObject(dt, iso);
            if (dt != null && dt.Rows.Count > 0)
            {
                StringBuilder strHtml = new StringBuilder();
                foreach (DataRow showRow in dt.Rows)
                {
                    strHtml.AppendFormat("<li>" +
                                        "<a href=\"/shoe/{0}.aspx\" target=\"_blank\" >" +
                                        "<img src=\"{1}\" alt=\"{2}\">" +
                                        "</a>" +
                                        "<div class=\"shoenr\">" +
                                        "<a href=\"/shoe/{0}.aspx\" target=\"_blank\" class=\"shoelisttitle\">{2}</a>" +
                                        "<p>{3}</p>" +
                                        "<em>价格：￥{4}</em>" +
                                        "{5}" +
                                        "</div>" +
                                        "</li>", showRow["id"].ToString(), showRow["cImage"].ToString(), showRow["cName"].ToString(), showRow["cSum"].ToString(), showRow["fPrice"].ToString(), GetPinTuanlink(showRow["id"].ToString()));
                }
                Result = strHtml.ToString();
            }
        }
    }
    //智能选鞋搜索条件
    protected StringBuilder GetAdvisorWhereCondition()
    {
        StringBuilder sWhere = new StringBuilder();

        Runner oneRunner = new Runner();
        oneRunner.Gender = int.Parse(Request["gender"].ToString());
        oneRunner.Tall = decimal.Parse(Request["tall"].ToString());
        oneRunner.Weight = decimal.Parse(Request["weight"].ToString());
        oneRunner.TypeOfShoe = Request["shoetype"];
        oneRunner.Level = Request["runlevel"];
        oneRunner.RunInATypicalWeek = Request["weekrunkm"];
        oneRunner.AveragePace = decimal.Parse(Request["pacemin"]) * 60 + decimal.Parse(Request["pacesec"]);
        oneRunner.InjuredLast12Months = Request["injured"];
        oneRunner.HighOfArch = Request["highofarch"];
        oneRunner.MotionMechanics = Request["motionmechanics"];
        oneRunner.StrikeTheGround = Request["strikeground"];
        SmartChooseShoes smartchooseshoes = new SmartChooseShoes();
        Runner smartRunner = smartchooseshoes.GetPercentRanking(oneRunner);


        //最终结果四舍五入
        weightpercent = (int)(smartRunner.WeightPercent + 0.5m);
        if (weightpercent > 100)
        {
            weightpercent = 100;
        }
        if (weightpercent < 0)
        {
            weightpercent = 0;
        }
        heightpercent = (int)(smartRunner.HeightPercent + 0.5m);
        if (heightpercent > 100)
        {
            heightpercent = 100;
        }
        if (heightpercent < 0)
        {
            heightpercent = 0;
        }
        heelpercent = (int)(smartRunner.HeelCushionPercent + 0.5m);
        if (heelpercent > 100)
        {
            heelpercent = 100;
        }
        if (heelpercent < 0)
        {
            heelpercent = 0;
        }
        forefootpercent = (int)(smartRunner.ForefootCushionPercent + 0.5m);
        if (forefootpercent > 100)
        {
            forefootpercent = 100;
        }
        if (forefootpercent < 0)
        {
            forefootpercent = 0;
        }
        stiffnesspercent = (int)(smartRunner.StiffnessPercent + 0.5m);
        if (stiffnesspercent > 100)
        {
            stiffnesspercent = 100;
        }
        if (stiffnesspercent < 0)
        {
            stiffnesspercent = 0;
        }
        stabilitypercent = (int)(smartRunner.StabilityPercent + 0.5m);
        if (stabilitypercent > 100)
        {
            stabilitypercent = 100;
        }
        if (stabilitypercent < 0)
        {
            stabilitypercent = 0;
        }

        sWhere.Append(" idGender = " + oneRunner.Gender);
        switch (oneRunner.TypeOfShoe)
        {
            case "road":
                sWhere.Append(" and  cType='公路'");
                break;
            case "trail":
                sWhere.Append(" and  cType='越野'");
                break;
            default:
                break;
        }
        sWhere.AppendFormat(" and rWeight between {0} and {1}", weightpercent - 20, weightpercent + 20);
        sWhere.AppendFormat(" and rHeight between {0} and {1}", heightpercent - 20, heightpercent + 20);
        sWhere.AppendFormat(" and rHeel between {0} and {1}", heelpercent - 20, heelpercent + 20);
        sWhere.AppendFormat(" and rForefeet between {0} and {1}", forefootpercent - 20, forefootpercent + 20);
        sWhere.AppendFormat(" and rStiffness between {0} and {1}", stiffnesspercent - 20, stiffnesspercent + 20);
        sWhere.AppendFormat(" and rStability between {0} and {1}", stabilitypercent - 20, stabilitypercent + 20);

        return sWhere;
    }

    //与我的鞋相似的搜索条件
    protected StringBuilder GetLikeMineWhereCondition()
    {
        StringBuilder sWhere = new StringBuilder();
        try
        {

            sWhere.Append(" 1=1 ");
            if (!string.IsNullOrEmpty(Request["gender"]))
            {
                sWhere.AppendFormat(" and idGender={0} ", Request["gender"]);
            }
            if (!string.IsNullOrEmpty(Request["manufacturer"]))
            {
                sWhere.AppendFormat("  and cBrand='{0}' ", Request["manufacturer"]);
            }
            if (!string.IsNullOrEmpty(Request["model"]))
            {
                sWhere.AppendFormat("  and cSeries='{0}' ", Request["model"]);
            }
            List<DBM5.tblShoes> listmodel = new DB5.tblShoes().GetModelList(sWhere.ToString());
            DBM5.tblShoes oneshoe = listmodel.ToArray()[0];
            weightpercent = oneshoe.rWeight ?? 0;
            heightpercent = oneshoe.rHeight ?? 0;
            heelpercent = oneshoe.rHeel ?? 0;
            forefootpercent = oneshoe.rForefeet ?? 0;
            stiffnesspercent = oneshoe.rStiffness ?? 0;
            stabilitypercent = oneshoe.rStability ?? 0;
            sWhere.Clear();
            sWhere.AppendFormat(" id!={0} ", oneshoe.id);
            if (!string.IsNullOrEmpty(Request["gender"]))
            {
                sWhere.AppendFormat(" and idGender={0} ", Request["gender"]);
            }
            sWhere.AppendFormat(" and rWeight between {0} and {1}", weightpercent - 10, weightpercent + 10);
            sWhere.AppendFormat(" and rHeight between {0} and {1}", heightpercent - 10, heightpercent + 10);
            if (forefootpercent >= stiffnesspercent)
            {
                sWhere.AppendFormat(" and rForefeet>{0}", forefootpercent - 15);
                orderby += ",rForefeet";
            }
            else
            {
                sWhere.AppendFormat(" and rHeel>{0}", heelpercent - 15);
                orderby += ",rHeel";
            }
            //sWhere.AppendFormat(" and rHeel between {0} and {1}", heelpercent - 20, heelpercent + 20);
            //sWhere.AppendFormat(" and rForefeet between {0} and {1}", forefootpercent - 20, forefootpercent + 20);
            //sWhere.AppendFormat(" and rStiffness between {0} and {1}", stiffnesspercent - 20, stiffnesspercent + 20);
            //sWhere.AppendFormat(" and rStability between {0} and {1}", stabilitypercent - 20, stabilitypercent + 20);
        }
        catch (Exception ex)
        {

        }
        return sWhere;
    }

    //查找跑鞋搜索条件
    protected StringBuilder GetSearchWhereCondition()
    {
        StringBuilder sWhere = new StringBuilder();
        int idGender = TypeChangeDefault.NullToInt(Request["xb"], 0);//性别
        sWhere.Append(" idGender = " + idGender);

        string cBrand = TypeChangeDefault.NullToString(Request["zzs"], "0");//制造商
        if (cBrand != "0")
        {
            sWhere.Append(" and cBrand ='" + cBrand + "'");
        }

        string cName = TypeChangeDefault.NullToString(Request["mz"], "");//鞋的名字
        if (cName.Trim().Length > 0)
        {
            sWhere.Append(" and cName ='" + cName + "'");
        }
        string cType = TypeChangeDefault.NullToString(Request["xx"], "0");//鞋型      
        if ("0" != cType)
        {
            switch (cType)
            {
                case "1": sWhere.Append(" and  cType='公路'"); break;
                case "2": sWhere.Append(" and  cType='越野'"); break;
            }
        }
        string fPrice = TypeChangeDefault.NullToString(Request["jg"], "0");//价格 
        if ("0" != fPrice)
        {
            switch (fPrice)
            {
                case "1": sWhere.Append(" and  fPrice < 400 "); break;
                case "2": sWhere.Append(" and  fPrice between 400 and 600 "); break;
                case "3": sWhere.Append(" and  fPrice between 600 and 1000 "); break;
                case "4": sWhere.Append(" and  fPrice >1000 "); break;
            }
        }
        string rHeel = TypeChangeDefault.NullToString(Request["zghc"], "0");//足跟缓冲
        if ("0" != rHeel)
        {
            switch (rHeel)
            {
                case "1": sWhere.Append(" and  rHeel < 20 "); break;
                case "2": sWhere.Append(" and  rHeel between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rHeel between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rHeel between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rHeel >80 "); break;
            }
        }
        string rForefeet = TypeChangeDefault.NullToString(Request["qjzhc"], "0");//前脚掌缓冲
        if ("0" != rForefeet)
        {
            switch (rForefeet)
            {
                case "1": sWhere.Append(" and  rForefeet < 20 "); break;
                case "2": sWhere.Append(" and  rForefeet between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rForefeet between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rForefeet between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rForefeet >80 "); break;
            }
        }

        string rStiffness = TypeChangeDefault.NullToString(Request["lhx"], "0");//灵活性
        if ("0" != rStiffness)
        {
            switch (rStiffness)
            {
                case "1": sWhere.Append(" and  rStiffness < 20 "); break;
                case "2": sWhere.Append(" and  rStiffness between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rStiffness between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rStiffness between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rStiffness >80 "); break;
            }
        }

        string qhgc = TypeChangeDefault.NullToString(Request["qhgc"], "0");//前后跟差
        if ("0" != qhgc)//fHeel-fForefeet=0
        {
            switch (qhgc)
            {
                case "1": sWhere.Append(" and  fHeel-fForefeet =0 "); break;
                case "2": sWhere.Append(" and  fHeel-fForefeet between 0 and 4 "); break;
                case "3": sWhere.Append(" and  fHeel-fForefeet between 4 and 8 "); break;
                case "4": sWhere.Append(" and  fHeel-fForefeet between 8 and 12 "); break;
                case "5": sWhere.Append(" and  fHeel-fForefeet >12 "); break;
            }
        }

        string rStability = TypeChangeDefault.NullToString(Request["wdx"], "0");// 稳定性 
        if ("0" != rStiffness)
        {
            switch (rStiffness)
            {
                case "1": sWhere.Append(" and  rStability < 20 "); break;
                case "2": sWhere.Append(" and  rStability between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rStability between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rStability between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rStability >80 "); break;
            }
        }
        string rWeight = TypeChangeDefault.NullToString(Request["zl"], "0");// 重量 
        if ("0" != rWeight)
        {
            switch (rWeight)
            {
                case "1": sWhere.Append(" and  rWeight < 20 "); break;
                case "2": sWhere.Append(" and  rWeight between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rWeight between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rWeight between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rWeight >80 "); break;
            }
        }

        string rHeight = TypeChangeDefault.NullToString(Request["gd"], "0");// 重量 
        if ("0" != rHeight)
        {
            switch (rHeight)
            {
                case "1": sWhere.Append(" and  rHeight < 20 "); break;
                case "2": sWhere.Append(" and  rHeight between 20 and 40 "); break;
                case "3": sWhere.Append(" and  rHeight between 40 and 60 "); break;
                case "4": sWhere.Append(" and  rHeight between 60 and 80 "); break;
                case "5": sWhere.Append(" and  rHeight >80 "); break;
            }
        }

        return sWhere;
    }

    //检查是否与拼团产品关联，如果关联返回购买链接
    protected string GetPinTuanlink(string shoeid)
    {
        string strReturn = string.Empty;
        string strWhere = string.Format(" shoesId={0} and linktype=2 ", shoeid);
        List<DBM5.tblShoes_Linked> listofshoelink = new DB5.tblShoes_Linked().GetModelList(strWhere);
        if (listofshoelink.Count > 0)
        {
            DBM5.tblShoes_Linked shoelinked = listofshoelink[0];
            strReturn = string.Format("<a href=\"/GroupBuy/Group.aspx?id={0}\">前往购买</a>", shoelinked.linkedId);
        }
        return strReturn;
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