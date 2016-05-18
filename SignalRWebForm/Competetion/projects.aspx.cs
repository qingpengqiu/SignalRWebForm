using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using DB1 = Erun360.BLL.DB1;
using System.Xml.Linq;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Competetion_projects : PageBase
{
    public int sid = 0;//赛事id
    public string la = string.Empty;//中英文
    public string xz = string.Empty;
    public string item = string.Empty;
    public int iScore = 0;
    public int MaxScore = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        if (sid == 0)
        {
            AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
            return;
        }
        la = TypeChangeDefault.NullToString(Request.QueryString["la"], "cn");
        la = la == "en" ? "en" : "cn";
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
            this.page_Title = title + "-赛事介绍-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\" alt=\"\"/>";
            if (model.iType == 2)
            {
                ltlbmxz.Text = "<h3>海外赛事</h3>1、本人自愿报名参加该比赛；<br>2、本人全面理解并同意遵守主办方所制订的各项规程、规则、规定、要求及采取的措施；<br>3、本人已为参加比赛做好充分准备，并确认自身身体和精神健康状况方面情况符合参加比赛的各项要求；<br>4、本人全面理解比赛可能出现的风险，且本人全面理解参赛可能发生的各种风险和意外，已准备必要的防范措施并做出了全面、审慎地评估，愿意自行承担由此产生的一切后果。<br>5、本人保证在参赛过程中服从裁判和赛事工作人员的管理和指挥。<br>6、本人理解该赛事将在对公众开放的公共道路上举办，并理解由此带来的风险。参加该项比赛包含不能被完全排除的内在风险，这些风险包括从轻微伤到重大伤害以及死亡的范围；理解参与赛事及相关活动期间会有各方不可知的风险，这些风险也不能被任何一方合理预见。同意承担所有前述风险。接受以下由于参加该赛事及活动个人及财产可能面临风险的个人责任，任何伤病、疾病、伤害、损失、责任、及相关花费；同意在参与赛事前检查相关场地及设施。关于任何在参加赛事及活动时会出现的伤害、疾病、医疗状况，本人授权当自己不能完全表达意思时，在场的医疗人员对您进行任何必须的紧急救治、手术。此外，本人授权这些紧急治疗费用都将由本人个人承担。本人确认被免除责任各方没有责任和义务提供或不能提供医疗救治。同意接受承办单位在比赛期间提供的现场急救性质的医务治疗，但在医院救治等发生的相关费用由本人自理；<br>7、本人授权主办方、协办单位及指定媒体无偿使用本人的肖像、姓名、声音和其它个人资料用于比赛的组织和推广；<br>8、本人同意向主办方提供有效的身份证件和资料用于核实本人身份，并同意承担因身份证件和资料不实所产生的全部责任；<br>9、本人同意主办方以本人为被保险人投保人身意外综合险（活动当天），具体内容已从保险说明书中知晓，本人均予以认可；<br>10、因个人因素如行程变更、签证等原因未能成行，益跑网不予退还费用。益跑网报名支付成功后，如需退费按赛事组委会相关规定执行。如您因各种原因不想参与比赛，请您自行负责。转让名额是组委会不允许的，如您私下转让名额，益跑网不对后果负责。<br>11、本人或法定代理人已认真阅读并全面理解以上内容，且对上述所有内容予以确认并承担相应的法律责任。";
            }
            else
            {
                ltlbmxz.Text = "<h3>国内赛事</h3>1.报名者已阅读本赛事竞赛规程和组委会发布的赛事责任声明。<br>2.本报名系统规定了报名者须接受组委会网上报名的各项条款。为完成全部报名过程，须认真阅读、理解并同意接受竞赛规程和相关规定。<br>3.报名者依照收费标准，在提交报名申请的同时，须在规定时间内完成网上支付流程，逾期即未报名成功。<br>4.鉴于组委会将根据您提交的信息为您购买保险和提供相关其他服务，报名者应真实、准确填写个人信息，正确选择比赛项目，如提供不实、不详信息，后果由报名者自负。<br>5.益跑网报名支付成功后，如需退费按赛事组委会相关规定执行。";
            }

            Dictionary<string, string> dict = Getcn_en(la);
            ltlHeader.Text = dict.FirstOrDefault(d => d.Key == "tip").Value;
            ltlProject.Text = dict.FirstOrDefault(d => d.Key == "itemInfo").Value;
            ltlbsxz.Text = dict.FirstOrDefault(d => d.Key == "racetip").Value;

            DataTable dt = new DB6.tblRace_Item().GetList(0, "idCompete=" + sid, " iType,id ").Tables[0];
            int Itype = 0;
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Itype = TypeChangeDefault.NullToInt(dt.Rows[i]["iType"], 0);
                if (Itype == 1)
                {
                    sb.AppendLine("<li>");
                }
                if (Itype == 2)
                {
                    sb.AppendLine("<li class=\"pout\">");
                }
                if (Itype == 3)
                {
                    sb.AppendLine("<li class=\"pout3\">");
                }
                if (Itype == 4)
                {
                    sb.AppendLine("<li class=\"pout4\">");
                }
                //20150708 更改库存数量（有从订单查询改为从库存中判断）del
                //int count = new DB6.tblOrder().GetRecordCount(" iStatus>-1 and iFromTpye=2 and iItemID=" + dt.Rows[i]["id"].ToString() + " and iTypeID=" + dt.Rows[i]["idCompete"].ToString());
              
                int dkscore = TypeChangeDefault.NullToInt(dt.Rows[i]["iScore"], 0);
                iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + idUser, idUser);//用户积分
                if (TypeChangeDefault.NullToInt(dt.Rows[i]["iScore"], 0) > 0 && TypeChangeDefault.NullToInt(dt.Rows[i]["iMoney"], 0) == 0)
                {
                    //status = 2;//最多可使用多少积分
                    if (dkscore > iScore)
                    {
                        sb.AppendLine("<input type=\"radio\" data-status=\"2\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + iScore + "\" {0} name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cItemName"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em>");
                        //xsscore = iScore;
                    }
                    else
                    {
                        sb.AppendLine("<input type=\"radio\" data-status=\"2\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" {0} name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cItemName"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em>");
                        //xsscore = dkscore;
                    }
                }
                else
                {
                    sb.AppendLine("<input type=\"radio\" data-status=\"1\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" {0} name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cItemName"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em>");
                }
                //sb.AppendLine("<input type=\"radio\" data-dprice=\"" + dt.Rows[i]["iCost"] + "\" data-price=\"" + dt.Rows[i]["iMoney"] + "\" data-Integral=\"" + dt.Rows[i]["iScore"] + "\" {0} name=\"project\" id=\"project" + i + "\" value=\"" + dt.Rows[i]["id"].ToString() + "\"><label for=\"project" + i + "\" class=\"projectover\">" + dt.Rows[i]["cItemName"] + "：<em>￥" + dt.Rows[i]["iCost"] + "元</em>");

                if (TypeChangeDefault.NullToDateTime(dt.Rows[i]["dJoinBegin"], DateTime.Now) > DateTime.Now)
                {
                    //报名未开始
                    sb.AppendLine("<span>（报名未开始）</span>");
                    sb = sb.Replace("{0}", "disabled");
                }
                else if (DateTime.Now > TypeChangeDefault.NullToDateTime(dt.Rows[i]["dJoinEnd"], DateTime.Now))
                {
                    //报名截止
                    sb.AppendLine("<span>（报名已截止）</span>");
                    sb = sb.Replace("{0}", "disabled");
                }
                else
                {
                    //20150708 更改库存数量（有从订单查询改为从库存中判断）edit
                    //if (count >= TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0))
                    if (TypeChangeDefault.NullToInt(dt.Rows[i]["iLimit"], 0) <= 0)
                    {
                        sb.AppendLine("<span>（报名已满）</span>");
                        sb = sb.Replace("{0}", "disabled");
                    }
                    else
                    {
                        sb = sb.Replace("{0}", "");
                    }
                }

                //备注
                if (dt.Rows[i]["cComment"].ToString().Length > 0)
                {
                    sb.AppendLine("<span><div class=\"projecttips\"><em></em>" + dt.Rows[i]["cComment"] + "</div></span>");
                }
                sb.AppendLine("</label></li>");
            }
            item = sb.ToString();

            if (model.dJoinBegin > DateTime.Now)
            {
                AlertHelper.JQAlertGo("报名未开始!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (DateTime.Now > Convert.ToDateTime(model.dJoinEnd.ToString()))
            {
                AlertHelper.JQAlertGo("报名已截止!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            //if (CurrentUser == null)
            //{
            //    Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            //    return;
            //}
            //iScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
            DataTable dtorder = new DB6.tblOrder().GetList("iStatus>=0 and iFromTpye=2 and cFromToID=" + sid + "and iTypeID=" + sid + " and idUser=" + idUser).Tables[0];
            string iStatus = string.Empty;
            if (dtorder.Rows.Count > 0)
            {
                Response.Redirect("/Competetion/OrderDetails.aspx?sid=" + sid + "&nav=2&orderid=" + dtorder.Rows[0]["cOrder_no"].ToString(), true);
            }
            if (CurrentUser == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();});</script>");
                return;
            }
        }
    }

    /// <summary>
    /// 获取中英文对照字典
    /// </summary>
    public static Dictionary<string, string> Getcn_en(string en)
    {
        string CacheKey = "GetVersionxb-" + en;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        objModel = null;
        if (objModel == null)
        {
            try
            {
                Dictionary<string, string> version = new Dictionary<string, string>();
                string xmlPath = HttpContext.Current.Server.MapPath("/XML/event.xml");
                XDocument doc = XDocument.Load(xmlPath);
                var language = en;
                var tipList = doc.Descendants("text");
                foreach (var item in tipList)
                {
                    version.Add(item.Element("id").Value, HTMLHelper.ZipHtml(item.Element(language).Value));
                }
                objModel = version;
                if (objModel != null)
                {
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }
            }
            catch { }
        }
        return (Dictionary<string, string>)objModel;
    }
}