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
using System.Collections;
using Newtonsoft.Json;
using DB1 = Erun360.BLL.DB1;
public partial class Competetion_equipinfo : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    public int id = 0;
    public string subtitle = string.Empty;
    public int idUser = 0;
    public string colorjson = string.Empty;
    public string sizejson = string.Empty;
    public int iBuyMax = 0;
    public int iScore = 0;
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
            iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + idUser, idUser);
            title = model.cTitle;
            this.page_Title = title+"-赛事介绍-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";
            if (id == 0)
            {
                AlertHelper.JQAlertGo("该装备不存在！", "/Competetion/equipment.aspx?sid=" + sid + "&nav=8", false);
                return;
            }
            DB6.tblEquipment bll = new DB6.tblEquipment();
            DBM6.tblEquipment modelEquip = bll.GetModel(id);
            DB6.tblEquipment_Item bllitem = new DB6.tblEquipment_Item();
            StringBuilder sb = new StringBuilder();
            //StringBuilder sbitem = new StringBuilder();
            if (modelEquip != null)
            {
                /*
                  <h1>Nike Women's DF Cool Breeze Strappy Tank VLV</h1>
                            <img src="http://img.erun360.com/shoe/Adidas_Adistar_Boost_2.jpg" class="eqinbigthumb">
                            市场价格：<i>&yen;160</i> 益跑价格：<em>&yen;160</em>
                            <div class="equicolor">
                                可选颜色：<img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif" class="this"  data-color="1"/><img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif" ><img src="http://119.2.5.59:8081/utility/uploads/2015/07/02/100000002_105241069.gif" >
                            </div>
                            <div class="equisize">
                                可选尺寸：<a class="this" data-size="xs">XS</a><a  data-size="s">S</a><a>M</a><a>L</a><a>XL</a><a>XXL</a>
                            </div>
                            <div class="equinum">
                            数量：<input type="number" name="annexnum0" clss="fen" value="1" min="1" max="6">
                            </div>
                            <a href="javascript:void(0)" class="equilgo">加入购物车</a>
                 */
                subtitle = modelEquip.cName;
                ltltu.Text = "<h1>" + modelEquip.cName + "</h1><img src=\"" + modelEquip.cImage + "\" class=\"eqinbigthumb\" >";

                //DataTable dt = new DB6.tblEquipment_Item().GetPriceByColor("cColor = '" + color + "' and idEquipment=" + idItem, "id").Tables[0];
                DataTable dt = bllitem.GetList("idEquipment=" + id).Tables[0];
                Hashtable size = null;
                List<Hashtable> sizeList = new List<Hashtable>();
                Hashtable color = null;
                List<Hashtable> colorList = new List<Hashtable>();
                Dictionary<String, String> pColor = new Dictionary<String, String>();
                Dictionary<String, String> pSize = new Dictionary<String, String>();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (pColor.ContainsKey(dt.Rows[i]["cColor"].ToString()) == false)
                        {
                            pColor.Add(dt.Rows[i]["cColor"].ToString(), dt.Rows[i]["cColor"].ToString());
                            color = new Hashtable();
                            color.Add("Color", dt.Rows[i]["cColor"].ToString());
                            color.Add("cURL", dt.Rows[i]["cURL"].ToString());
                            color.Add("cSize", bllitem.GetSizeByColor("cColor = '" + dt.Rows[i]["cColor"].ToString() + "' and idEquipment=" + id, "id").Tables[0]);
                            colorList.Add(color);
                        }
                        if (pSize.ContainsKey(dt.Rows[i]["cSize"].ToString()) == false)
                        {
                            pSize.Add(dt.Rows[i]["cSize"].ToString(), dt.Rows[i]["cSize"].ToString());
                            size = new Hashtable();
                            size.Add("cSize", dt.Rows[i]["cSize"].ToString());
                            size.Add("cColor", bllitem.GetColorBySize("cSize = '" + dt.Rows[i]["cSize"].ToString() + "' and idEquipment=" + id, "id").Tables[0]);
                            sizeList.Add(size);
                        }
                    }
                }
                colorjson = JsonConvert.SerializeObject(colorList);
                sizejson = JsonConvert.SerializeObject(sizeList);
                ltlprice.Text = "市场价格：<i>&yen;" + TypeChangeDefault.NullToInt(bllitem.MaxPrice(id), 0) + "</i> 益跑价格：<em>&yen;" + bllitem.MinPrice(id) + "</em>";
              
                //string color = string.Empty;
                //ltlcolor.Text = "<div class=\"equicolor\"> 可选颜色：";
                //Dictionary<String, String> pColor = new Dictionary<String, String>();
                //Dictionary<String, String> pSize = new Dictionary<String, String>();
                //for (int j = 0; j < dtcolor.Rows.Count; j++)
                //{
                //    if (pColor.ContainsKey(dtcolor.Rows[j]["cColor"].ToString()) == false)
                //    {
                //        pColor.Add(dtcolor.Rows[j]["cColor"].ToString(), "<img src=\"" + dtcolor.Rows[j]["cURL"].ToString() + "\" data-color=\"" + dtcolor.Rows[j]["cColor"].ToString() + "\"/>");
                //    }
                //    if (pSize.ContainsKey(dtcolor.Rows[j]["cSize"].ToString()) == false)
                //    {
                //        pSize.Add(dtcolor.Rows[j]["cSize"].ToString(), dtcolor.Rows[j]["cSize"].ToString() + " ");
                //    }

                //}
                //foreach (String value in pColor.Values)
                //{
                //    ltlcolor.Text += value;
                //}
                //ltlcolor.Text += "</div>";
                //ltlsize.Text = "<div class=\"equisize\">可选尺寸：";
                //DataTable dtsize = bllitem.GetPriceByColor("cColor='" + color + "' and idEquipment=" + id, "id").Tables[0];
                //for (int i = 0; i < dtsize.Rows.Count; i++)
                //{
                //    if (i == 0)
                //    {
                //        ltlprice.Text = "  市场价格：<i>&yen;" + dtsize.Rows[i]["fMarketPrice"].ToString() + "</i> 益跑价格：<em>&yen;" + dtsize.Rows[i]["fSellPrice"].ToString() + "</em>";
                //        ltlsize.Text += "<a class=\"this\" data-id=\"" + dtsize.Rows[i]["id"].ToString() + "\" data-price=\"" + dtsize.Rows[i]["fSellPrice"].ToString() + "\" data-sprice=\"" + dtsize.Rows[i]["fMarketPrice"].ToString() + "\" data-size=\"" + dtsize.Rows[i]["cSize"].ToString() + "\">" + dtsize.Rows[i]["cSize"].ToString() + "</a> ";
                //    }
                //    else
                //    {
                //        ltlsize.Text += "<a data-id=\"" + dtsize.Rows[i]["id"].ToString() + "\" data-price=\"" + dtsize.Rows[i]["fSellPrice"].ToString() + "\" data-sprice=\"" + dtsize.Rows[i]["fMarketPrice"].ToString() + "\" data-size=\"" + dtsize.Rows[i]["cSize"].ToString() + "\">" + dtsize.Rows[i]["cSize"].ToString() + "</a> ";
                //    }
                //}
                //ltlsize.Text += "</div>";
                //ltlnum.Text = "<div class=\"equinum\">数量：";
                //ltlnum.Text += "<input type=\"number\" name=\"num\" clss=\"fen\" value=\"1\" min=\"1\" max=\"" + modelEquip.iBuyMax + "\">";
                //ltlnum.Text += "</div><a href=\"javascript:void(0)\" class=\"equilgo\">立即购买</a>";

                //sb.AppendLine("");
                //sb.AppendLine("</div>");
                //ltltu.Text = sb.ToString(); ;
                iBuyMax = modelEquip.iBuyMax ?? 0;
                if (modelEquip.cBio.Length > 0)
                    ltljs.Text = "<h4>产品介绍</h4>" + modelEquip.cBio + "<hr>";
                if (modelEquip.cReason.Length > 0)
                    ltlyy.Text = "<h4>推荐原因</h4>" + modelEquip.cReason + "<hr>";
                if (modelEquip.cNorm.Length > 0)
                    ltltd.Text = "<h4>特点</h4>" + modelEquip.cNorm + "<hr>";

                DataTable dtuser = new DB6.tblPassenger().GetList("idUser=" + idUser).Tables[0];
                StringBuilder sbUser = new StringBuilder();
                if (dtuser.Rows.Count > 0)
                {
                    for (int g = 0; g < dtuser.Rows.Count; g++)
                    {
                        if (g == 0)
                        {
                            sbUser.AppendLine("<div class=\"equipop\">选择常用联系人： <br>");
                        }

                        sbUser.AppendLine("<label><input type=\"radio\" data-id=\"" + dtuser.Rows[g]["id"].ToString() + "\" data-fristname=\"" + dtuser.Rows[g]["csurname"].ToString() + "\" data-lastname=\"" + dtuser.Rows[g]["cname"].ToString() + "\" data-tel=\"" + dtuser.Rows[g]["Phone"].ToString() + "\" data-add=\"" + dtuser.Rows[g]["cAddress"].ToString() + "\" name=\"lxr\"> " + dtuser.Rows[g]["cFullname"].ToString() + "</label>");
                        if (g == dtuser.Rows.Count-1)
                        {
                            sbUser.AppendLine("</div>");
                        }
                    }
                }
                ltlInfo.Text = sbUser.ToString();
            }
        }
    }
}