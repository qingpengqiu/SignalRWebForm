using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
public partial class Competetion_hotelinfo : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    public string subtitle = string.Empty;
    public int idUser = 0;
    public int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (model.idUser != idUser || idUser != 100000002)
            {
                if (1 != model.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            title = model.cTitle;
            this.page_Title = title+"-酒店-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";

            ltlhotel.Text = "<a class=\"backlisteq\" href=\"/Competetion/hotel.aspx?sid=" + sid + "&nav=4\">>返回酒店列表</a>";

            /*
             <img src="/Html/images/hotel.jpg" class="hotelthumbbig">
                                <div class="hotelthumbsmall">
                                    <img src="/Html/images/hotel.jpg" class="this">
                                    <img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif">
                                    <img src="/Html/images/hotel.jpg">
                                    <img src="/Html/images/hotel.jpg">
                                    <img src="/Html/images/hotel.jpg">
                                </div>
             */
            //ltldate.Text = "<input type=\"text\" name=\"destine\" value=\""+DateTime.Now.ToString("yyyy-MM-dd")+"\" onfocus=\"WdatePicker({minDate:'%y-%M-%d'})\"/>";
            int iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + idUser, idUser);
            DB6.tblHotel bll = new DB6.tblHotel();
            DBM6.tblHotel modelHotel = bll.GetModel(id);
            DB6.tblHotel_Item bllitem = new DB6.tblHotel_Item();
            StringBuilder sb = new StringBuilder();
            StringBuilder sbitem = new StringBuilder();
            StringBuilder sbr = new StringBuilder();
            if (modelHotel != null)
            {
                subtitle = modelHotel.cName;
                sbitem.AppendLine("<h1>" + modelHotel.cName + "</h1>");
                sb.AppendLine("<img src=\"" + modelHotel.cImage + "\" class=\"hotelthumbbig\" >");
                sb.AppendLine("<div class=\"hotelthumbsmall\">");
                DataTable dtitem = bllitem.GetList(0, "idHotel=" + id, "fSellPrice").Tables[0];
                sb.AppendLine("<img src=\"" + modelHotel.cImage + "\">");
                for (int j = 0; j < dtitem.Rows.Count; j++)
                {
                    if (dtitem.Rows[j]["cURL"].ToString().Length > 0)
                    {
                        sb.AppendLine("<img src=\"" + dtitem.Rows[j]["cURL"].ToString() + "\">");
                    }
                    if (j == 0)
                    {
                        sbitem.AppendLine("<em>市场价格：</em><b>￥" + dtitem.Rows[j]["fMarketPrice"].ToString() + "</b> <em>益跑价格：</em><i>￥" + dtitem.Rows[j]["fSellPrice"].ToString() + "</i>");
                    }
                    sbitem.AppendLine("<div class=\"am-radio\"><label>");
                    //if (modelHotel.iBuyMax > 0)
                    //{
                    //    sbitem.AppendLine("<input type=\"radio\" name=\"hotel\" {0} data-jf=\"{1}\" data-max=\"" + modelHotel.iBuyMax + "\" data-id=\"" + dtitem.Rows[j]["id"].ToString() + "\" data-name=\"" + dtitem.Rows[j]["cItemName"].ToString() + "\" data-price=\"" + dtitem.Rows[j]["fSellPrice"].ToString() + "\" value=\"" + dtitem.Rows[j]["id"].ToString() + "\">" + dtitem.Rows[j]["cItemName"].ToString() + "");
                    //}
                    //else
                    //{
                    //    sbitem.AppendLine("<input type=\"radio\" name=\"hotel\" {0} data-jf=\"{1}\" data-max=\"" + dtitem.Rows[j]["iLimit"].ToString() + "\" data-id=\"" + dtitem.Rows[j]["id"].ToString() + "\" data-name=\"" + dtitem.Rows[j]["cItemName"].ToString() + "\" data-price=\"" + dtitem.Rows[j]["fSellPrice"].ToString() + "\" value=\"" + dtitem.Rows[j]["id"].ToString() + "\">" + dtitem.Rows[j]["cItemName"].ToString() + "");
                    //}
                    if (modelHotel.iBuyMax > 0)
                    {
                        sbitem.AppendLine("<input type=\"radio\" name=\"hotel\" {0} data-jf=\"{1}\" data-max=\"" + modelHotel.iBuyMax + "\" data-id=\"" + dtitem.Rows[j]["id"].ToString() + "\" data-name=\"" + dtitem.Rows[j]["cItemName"].ToString() + "\" data-price=\"" + dtitem.Rows[j]["fSellPrice"].ToString() + "\"  data-sprice=\"" + dtitem.Rows[j]["fMarketPrice"].ToString() + "\" value=\"" + dtitem.Rows[j]["id"].ToString() + "\">" + dtitem.Rows[j]["cItemName"].ToString() + "");
                    }
                    else
                    {
                        sbitem.AppendLine("<input type=\"radio\" name=\"hotel\" {0} data-jf=\"{1}\" data-max=\"" + dtitem.Rows[j]["iLimit"].ToString() + "\" data-id=\"" + dtitem.Rows[j]["id"].ToString() + "\" data-name=\"" + dtitem.Rows[j]["cItemName"].ToString() + "\" data-price=\"" + dtitem.Rows[j]["fSellPrice"].ToString() + "\" data-sprice=\"" + dtitem.Rows[j]["fMarketPrice"].ToString() + "\" value=\"" + dtitem.Rows[j]["id"].ToString() + "\">" + dtitem.Rows[j]["cItemName"].ToString() + "");
                    }
                    if (TypeChangeDefault.NullToDateTime(dtitem.Rows[j]["dBeginTime"], DateTime.Now) > DateTime.Now)
                    {
                        //报名未开始
                        sbitem.AppendLine("（未开始）");
                        sbitem = sbitem.Replace("{0}", "disabled");
                    }
                    else if (DateTime.Now > TypeChangeDefault.NullToDateTime(dtitem.Rows[j]["dEndTime"], DateTime.Now))
                    {
                        //报名截止
                        sbitem.AppendLine("（已截止）");
                        sbitem = sbitem.Replace("{0}", "disabled");
                    }
                    else
                    {
                        //20150708 更改库存数量（有从订单查询改为从库存中判断）edit                        
                        if (TypeChangeDefault.NullToInt(dtitem.Rows[j]["iLimit"], 0) <= 0)
                        {
                            sbitem.AppendLine("（已售罄）");
                            sbitem = sbitem.Replace("{0}", "disabled");
                        }
                        else
                        {
                            sbitem = sbitem.Replace("{0}", "");
                        }
                    }
                    if (dtitem.Rows[j]["iScore"].ToString() == "0")
                    {
                        sbitem = sbitem.Replace("{1}", "0");
                    }
                    else
                    {
                        if (TypeChangeDefault.NullToInt(dtitem.Rows[j]["iScore"],0) > iScore)
                        {
                            sbitem = sbitem.Replace("{1}", "当前积分不足以抵扣，&lt;a href=\"/blog/200016255.aspx\" target=\"_blank\"&gt;点击查看积分来源&lt;/a&gt;");
                        }
                        else
                        {
                            sbitem = sbitem.Replace("{1}", "您有<i>" + iScore + "</i>积分,可使用<i>" + dtitem.Rows[j]["iScore"].ToString() + "</i>积分 抵扣<i>" + dtitem.Rows[j]["iMoney"].ToString() + "</i>元");
                        }
                    }
                    sbitem.AppendLine("</label></div>");
                }
                sb.AppendLine("</div>");
            }
            ltltu.Text = sb.ToString();
            sbitem.AppendLine("<a class=\"buyhotel\">立即购买</a>");

            ltlitem.Text = sbitem.ToString();
            if (modelHotel.cBio.Length > 0)
                ltljs.Text = "<h4>酒店介绍</h4>" + modelHotel.cBio + "<hr>";
            if (modelHotel.cFit.Length > 0)
                ltlss.Text = "<h4>酒店设施</h4>" + modelHotel.cFit + "<hr>";
            if (modelHotel.cNorm.Length > 0)
                ltlzz.Text = "<h4>酒店政策</h4>" + modelHotel.cNorm + "<hr>";
        }

        DataTable dt = new DB6.tblPassenger().GetList("idUser=" + idUser).Tables[0];
        foreach (DataRow dr in dt.Rows)
        {
            ltlInfo.Text += "<label><input type=\"checkbox\" data-id=\"" + dr["id"].ToString() + "\"data-fristname=\"" + dr["csurname"].ToString() + "\" data-lastname=\"" + dr["cname"].ToString() + "\" data-idcard=\"" + dr["IdNo"].ToString() + "\"> " + dr["cFullname"].ToString() + "</label>";
            //ltlInfo.Text += "<label><input type=\"checkbox\" data-fristname=\"" + dr["csurname"].ToString() + "\" data-lastname=\"" + dr["cname"].ToString() + "\" data-idtype=\"" + dr["IdType"].ToString() + "\" data-IdNo=\"" + dr["IdNo"].ToString() + "\" data-Phone=\"" + dr["Phone"].ToString() + "\" >" + dr["csurname"].ToString() + dr["cname"].ToString() + "</label>";
        }
        if (idUser != 0)
        {
            ltlLink.Text = "<label><em>姓名：</em><input type=\"text\"  name=\"linkname\" value=\"" + CurrentUser.cName + "\"></label><label><em>手机号码：</em><input type=\"text\"  name=\"mobile\" value=\"" + CurrentUser.cMobile + "\"></label><label><em>Email：</em><input type=\"text\"  name=\"email\" value=\"" + CurrentUser.cMail + "\"></label>";
        }
    }
}