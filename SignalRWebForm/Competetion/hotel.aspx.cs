using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
public partial class Competetion_hotel : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
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
            
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\"  alt=\"\"/>";
            DB6.tblHotel bll = new DB6.tblHotel();
            DataTable dt = bll.GetList(0, "(iGlobal=0 or(iGlobal=1 and idCompete=" + sid + ")) and iStatus=1 ", "iSort desc").Tables[0];
            StringBuilder sb = new StringBuilder();
            if (dt.Rows.Count > 0)
            {
                /*
                 <div class="hotellist">
                    <img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif" class="hotelthumb">
                    <div class="hoteltitle">
                        <a href="">Parkroyal on Beach Road Singapore (新加坡滨海宾乐雅酒店) 双床房</a> <a class="hoteleidt">[ 编辑 ]</a>
                    </div>
                                        
                    酒店价格：<em>&yen;160</em><i>起</i> <br>
                    三人房标准间（含早餐） <br>
                    双人房标准间（含早餐） <br>
                    套间（含早餐） <br>
                    <a href="javascript:void(0)" class="equilgo">立即购买</a>
                </div>
                 */
                DB6.tblHotel_Item bllitem = new DB6.tblHotel_Item();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int idHotel = TypeChangeDefault.NullToInt(dt.Rows[i]["id"], 0);
                    int count = bllitem.GetRecordCount("idHotel=" + idHotel);
                    if (count == 0)
                        continue;
                    sb.AppendFormat("<div class=\"hotellist\">");
                    sb.AppendFormat("<img src=\"" + dt.Rows[i]["cImage"].ToString() + "\" class=\"hotelthumb\" >");                   
                    sb.AppendFormat(" <div class=\"hoteltitle\">");                   
                    sb.AppendFormat("<a href=\"/Competetion/hotelinfo.aspx?sid=" + sid + "&nav=4&id=" + dt.Rows[i]["id"].ToString() + "\">" + dt.Rows[i]["cName"].ToString() + "</a>");
                    sb.AppendFormat("  </div>");
                    sb.AppendFormat(" 益跑价格：<em>&yen;" + bllitem.MinPrice(idHotel) + "</em><i>起</i> <br>");
                    sb.AppendFormat("  <div class=\"hotellistli\">");
                    DataTable dtitem = bllitem.GetList(0, "idHotel=" + dt.Rows[i]["id"].ToString(), "fSellPrice").Tables[0];
                    for (int j = 0; j < dtitem.Rows.Count; j++)
                    {
                        sb.AppendFormat("<img src=\"/Html/images/hotelp.png\">"+dtitem.Rows[j]["cItemName"].ToString() + "<br>");
                    }
                    sb.AppendFormat("  </div>");
                    sb.AppendFormat("<a class=\"equilgo\" href=\"/Competetion/hotelinfo.aspx?sid=" + sid + "&nav=4&id=" + dt.Rows[i]["id"].ToString() + "\">查看</a>");
                   
                    sb.AppendFormat("</div>");

                    //sb.AppendFormat("<div class=\"equili\" data-id=\"" + dt.Rows[i]["id"].ToString() + "\">");
                    //sb.AppendFormat("<a class=\"equilititle\" href=\"/Competetion/hotelinfo.aspx?sid=" + sid + "&nav=4&id=" + dt.Rows[i]["id"].ToString() + "\">" + dt.Rows[i]["cName"].ToString() + "</a>");
                    //sb.AppendFormat(" 价格：<em>￥</em><b>" + bllitem.MinPrice(idHotel) + "</b><i>起</i>");
                    //sb.AppendFormat("<div class=\"equilthumb\">");
                    //sb.AppendFormat("<img src=\"" + dt.Rows[i]["cImage"].ToString() + "\">");
                    //DataTable dtitem = bllitem.GetList(0, "len(cURL)>0 and idHotel=" + dt.Rows[i]["id"].ToString(), "fSellPrice").Tables[0];
                    //for (int j = 0; j < dtitem.Rows.Count; j++)
                    //{
                    //    sb.AppendFormat("<img src=\"" + dtitem.Rows[j]["cURL"].ToString() + "\">");                            
                    //}
                    ////sb.AppendFormat("<img src=\"http://img.erun360.com/shoe/Adidas_Adistar_Boost_2.jpg\">");
                    //sb.AppendFormat("  </div>");
                    //sb.AppendFormat("</div>");
                }
            }
            ltlhotel.Text = sb.ToString();
        }
    }
}