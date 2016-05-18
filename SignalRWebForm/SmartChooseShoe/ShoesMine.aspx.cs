using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DB1 = Erun360.BLL.DB1;

public partial class SmartChooseShoe_ShoesMine : PageBase
{
    public ADRight addgg = new ADRight();
    DB1.tblTour tourBll = new DB1.tblTour();
    protected void Page_Load(object sender, EventArgs e)
    {
    	this.page_Title = "根据现有鞋选择相似鞋-益跑网-中国领先的跑步门户网站-ERUN360.COM";
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