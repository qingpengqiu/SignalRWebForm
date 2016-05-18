using System;
using System.Collections.Generic;
using DB6 = Erun360.BLL.DB6;
using System.Data;
using Erun360.Pay.Alipay.pc;
using Erun360.Pay.tenpayLib;
using Utils;
using System.Xml;
using System.Collections;
using DBM6 = Erun360.Model.DB6;
using System.Text;
using System.Web;
using Erun360.Pay.WxPayAPI;
using System.Text.RegularExpressions;
public partial class Competetion_payoff : PageBase
{
    public int sid = 0;//订单id 
    public int id = 0;//订单id 
    public string title = string.Empty;
    public string OrderNo = string.Empty;//订单号
    private int wdd = 0;//未付款订单
    private int jpmin = 25;//机票过期时间（单位分钟）
    private int ssmin = 120;//赛事过期时间
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        wdd = TypeChangeDefault.NullToInt(Request.QueryString["dd"], 0);
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        OrderNo = TypeChangeDefault.NullToString(Request.QueryString["order"], "");
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition modelrace = new DB6.tblRace_Competition().GetModel(sid);
            if (modelrace == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (modelrace.idUser != idUser || idUser != 100000002)
            {
                if (1 != modelrace.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            title = modelrace.cTitle;
            this.page_Title = title+"-订单支付-益跑赛事";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = modelrace.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + modelrace.cBanner + "\" alt=\"\"/>";
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder model = bll.GetModel(id);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (model.iStatus != 1)
            {
                AlertHelper.JQAlertGo("该订单已付款或者已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (model.cOrder_no != OrderNo)
            {
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
           
            ltlItem.Text = model.cItemName;
            ltlCost.Text = model.iCost.ToString();
            int min = 0;
            if (model.iFromTpye == 1)
            {
                if (wdd == 1)
                {
                    //单位分钟
                    if (model.iFromTpye == 3)//机票业务
                    {
                        min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                    }
                    else
                    { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
                }
                else
                {
                    DataTable dt = bll.GetList("cParentOrder='" + model.cOrder_no + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                    int count = dt.Rows.Count;
                    if (count == 0)
                    {
                        AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                        return;
                    }
                    int[] intArray = new int[count];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                        //单位分钟
                        if (iFromTpye == 3)//机票业务
                        {
                            intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                        }
                        else
                        {
                            intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), ssmin);
                        }
                    }
                    ArrayList list = new ArrayList(intArray);
                    list.Sort();
                    //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                    min = Convert.ToInt32(list[0]);//取最小值
                }

            }
            else
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            if (min == 0)
            {
                AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
            if (min > 60)
            {
                //;
                //Convert.ToInt32(Math.Ceiling((decimal)((decimal)min / (decimal)60)));
                ltlMax.Text = Convert.ToString(Math.Floor(min / 60.0)) + "小时" + Convert.ToString(Math.Floor(min % 60.0)) + "分钟";
            }
            else
                ltlMax.Text = min.ToString() + "分钟";

            string userAgent = Request.UserAgent;
            if (userAgent.ToLower().Contains("micromessenger"))
            {
                string pattern = @"MicroMessenger\/(\d+)";//MicroMessenger\/(\d+.)(\d+)  结果：MicroMessenger/6.2
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(pattern);
                System.Text.RegularExpressions.MatchCollection mc = regex.Matches(Request.UserAgent);
                int wxh = TypeChangeDefault.NullToInt(mc[0].Value.Replace("MicroMessenger/", ""), 0);//微信版本号               
                if (wxh < 5)//微信版本号小于5不允许微信支付
                {
                    AlertHelper.JQAlertGo("您的微信版本比较低，请升级后重试！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=2", false);
                    return;
                }
                wxpay.Visible = false;
                wxpay.Enabled = false;
                wapwxpay.Visible = true;
                wapwxpay.Enabled = true;
                Alipay.Visible = false;
                Alipay.Enabled = false;
                wapAlipay.Visible = true;
                wapAlipay.Enabled = true;

                JsApiPay jsApiPay = new JsApiPay(this);
                try
                {
                    //调用【网页授权获取用户信息】接口获取用户的openid和access_token
                    jsApiPay.GetOpenidAndAccessToken();

                    //获取收货地址js函数入口参数
                    //wxEditAddrParam = jsApiPay.GetEditAddressParameters();
                    ViewState["openid"] = jsApiPay.openid;
                }
                catch (Exception ex)
                {
                    //Response.Write("<span style='color:#FF0000;font-size:20px'>" + "页面加载出错，请重试" + "</span>");
                    Log.Info(this.GetType().ToString(), "页面加载出错，请重试(获取openid 失败)");
                }
            }
            else
            {
                System.Web.HttpBrowserCapabilities myBrowserCaps = Request.Browser;
                int isMobile = ((System.Web.Configuration.HttpCapabilitiesBase)myBrowserCaps).IsMobileDevice ? 1 : 0;
                if (isMobile == 1)
                {
                    wxpay.Visible = true;
                    wxpay.Enabled = true;
                    wapwxpay.Visible = false;
                    wapwxpay.Enabled = false;
                    Alipay.Visible = false;
                    Alipay.Enabled = false;
                    wapAlipay.Visible = true;
                    wapAlipay.Enabled = true;
                }
                else
                {
                    wxpay.Visible = true;
                    wxpay.Enabled = true;
                    wapwxpay.Visible = false;
                    wapwxpay.Enabled = false;
                    Alipay.Visible = true;
                    Alipay.Enabled = true;
                    wapAlipay.Visible = false;
                    wapAlipay.Enabled = false;
 
                }
            }
        }
    }
    /// <summary>
    /// 过期时间
    /// </summary>
    /// <param name="date1"></param>
    /// <param name="max">默认过期最大值（单位分钟）</param>
    /// <returns></returns>
    protected int deadline(DateTime date1, int max)
    {
        //DateTime date1 = model.dConfirmTime ?? DateTime.Now;
        DateTime date2 = new DB6.tblOrder().GetTime(0);
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm < 0 || mm > max)
        {
            return 0;
        }
        return max - mm;
    }
    //微信手机端支付
    protected void wapwxpay_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.dConfirmTime.ToString().Length == 0)
        {
            model.dConfirmTime = bll.GetTime(0);
            model.ID = id;
            bll.Update(model);
        }
        title = model.cFromToName;
        if (model.iStatus != 1)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.cOrder_no != OrderNo)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        int min = 0;
        double iCost = 0.00;
        if (model.iFromTpye == 1)
        {
            if (wdd == 1)
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            else
            {
                DataTable dt = bll.GetList("cParentOrder='" + model.cParentOrder + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                    }
                    else
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), ssmin);
                    }

                    iCost += TypeChangeDefault.NullToDouble(dt.Rows[i]["iCost"], 0);
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                min = Convert.ToInt32(list[0]);//取最小值
                if (model.iCost != TypeChangeDefault.NullToDecimal(iCost, 0))
                {
                    AlertHelper.JQAlertGo("该订单金额与支付金额不符，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
            }
        }
        else
        {
            //单位分钟
            if (model.iFromTpye == 3)//机票业务
            {
                min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);
            }
            else
            { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
        }
        if (min == 0)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        iCost = TypeChangeDefault.NullToDouble(model.iCost, 0);
        if (ViewState["openid"] != null)
        {
            string openid = ViewState["openid"].ToString();
            string url = "/weixinpay/JsApiPayall.aspx?openid=" + openid + "&sid=" + sid + "&id=" + id + "&order=" + OrderNo + "";
            Response.Redirect(url);
        }
        else
        {
            Log.Info(this.GetType().ToString(), "页面缺少参数，请重试(获取openid 失败)");
        }
    }
    //微信支付
    protected void wxpay_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.dConfirmTime.ToString().Length == 0)
        {
            model.dConfirmTime = bll.GetTime(0);
            model.ID = id;
            bll.Update(model);
        }
        title = model.cFromToName;
        if (model.iStatus != 1)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.cOrder_no != OrderNo)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        int min = 0;
        double iCost = 0.00;
        if (model.iFromTpye == 1)
        {
            if (wdd == 1)
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            else
            {
                DataTable dt = bll.GetList("cParentOrder='" + model.cParentOrder + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                    }
                    else
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), ssmin);
                    }

                    iCost += TypeChangeDefault.NullToDouble(dt.Rows[i]["iCost"], 0);
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                min = Convert.ToInt32(list[0]);//取最小值
                if (model.iCost != TypeChangeDefault.NullToDecimal(iCost, 0))
                {
                    AlertHelper.JQAlertGo("该订单金额与支付金额不符，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
            }
        }
        else
        {
            //单位分钟
            if (model.iFromTpye == 3)//机票业务
            {
                min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);
            }
            else
            { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
        }
        if (min == 0)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        iCost = TypeChangeDefault.NullToDouble(model.iCost, 0);
        SignVerifyUtil Params = new SignVerifyUtil();
        //创建RequestHandler实例 
        Params.setParameter("appid", TenpayUtil.appid);
        Params.setParameter("body", model.cFromToName);
        Params.setParameter("detail", HTMLHelper.NoHTML(model.cItemName));
        Params.setParameter("mch_id", TenpayUtil.partner);
        Params.setParameter("nonce_str", TenpayUtil.getNoncestr());
        Params.setParameter("notify_url", TenpayUtil.tenpay_notify);
        Params.setParameter("out_trade_no", OrderNo);
        Params.setParameter("spbill_create_ip", Page.Request.UserHostAddress);// 
        //Params.setParameter("spbill_create_ip", "119.2.5.60");// Page.Request.UserHostAddress
        Params.setParameter("total_fee", (iCost * 100).ToString());//金额以分计算
        Params.setParameter("time_start", DateTime.Now.ToString("yyyyMMddHHmmss"));
        Params.setParameter("time_expire", DateTime.Now.AddMinutes(min).ToString("yyyyMMddHHmmss"));
        Params.setParameter("trade_type", "NATIVE");
        string sign = Params.createSign(TenpayUtil.key);
        Params.setParameter("sign", sign);
        string WebUrl = @"https://api.mch.weixin.qq.com/pay/unifiedorder";//提交支付接口
        string xml = Params.parseXML();
        string Back_XML = Params.PostXml(WebUrl, xml);    //获取提交支付返回xml   
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.LoadXml(Back_XML);
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("xml");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        if (xmlNode["return_code"].InnerText == "SUCCESS" && xmlNode["result_code"].InnerText == "SUCCESS")
        {
            Response.Redirect("/Competetion/payoffwx.aspx?sid=" + sid + "&id=" + id + "&nav=2&order=" + OrderNo + "&parm=" + xmlNode["code_url"].InnerText);
        }
        else
        {
            if (string.IsNullOrWhiteSpace(TypeChangeDefault.NullToString(xmlNode["err_code_des"], "")))
            {
                AlertHelper.JQAlertGo(xmlNode["return_msg"].InnerText, "/Competetion/payoff.aspx?sid=" + sid + "&id=" + id + "&nav=2&order=" + OrderNo, false);
                return;
            }
            else
            {
                AlertHelper.JQAlertGo(xmlNode["err_code_des"].InnerText, "/Competetion/payoff.aspx?sid=" + sid + "&id=" + id + "&nav=2&order=" + OrderNo, false);
                return;
            }
        }
    }
    //支付宝支付
    protected void Alipay_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.dConfirmTime.ToString().Length == 0)
        {
            model.dConfirmTime = bll.GetTime(0);
            model.ID = id;
            bll.Update(model);
        }
        title = model.cFromToName;
        if (model.iStatus != 1)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.cOrder_no != OrderNo)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        int min = 0;
        double iCost = 0.00;
        if (model.iFromTpye == 1)
        {
            if (wdd == 1)
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            else
            {
                DataTable dt = bll.GetList("cParentOrder='" + model.cParentOrder + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)//机票业务
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                    }
                    else
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), 120);
                    }
                    iCost += TypeChangeDefault.NullToDouble(dt.Rows[i]["iCost"], 0);
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                min = Convert.ToInt32(list[0]);//取最小值
                if (model.iCost != TypeChangeDefault.NullToDecimal(iCost, 0))
                {
                    AlertHelper.JQAlertGo("该订单金额与支付金额不符，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
            }
        }
        else
        {
            //单位分钟
            if (model.iFromTpye == 3)//机票业务
            {
                min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

            }
            else
            { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
        }
        if (min == 0)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        iCost = TypeChangeDefault.NullToDouble(model.iCost, 0);
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/AliPay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Competetion']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        //支付类型
        string payment_type = "1";
        //服务器异步通知页面路径
        string notify_url = xmlNode["notify_url"].InnerText;
        //页面跳转同步通知页面路径
        string return_url = xmlNode["return_url"].InnerText;
        //卖家支付宝帐户
        string seller_email = "info@erun360.com";
        //商户订单号
        string out_trade_no = model.cOrder_no;
        //商户网站订单系统中唯一订单号，必填
        //订单名称
        string subject = model.cFromToName;
        //付款金额
        string total_fee = iCost.ToString();
        //string total_fee = "0.01";
        //订单描述
        string body = model.cItemName;
        //商品展示地址
        string show_url = xmlNode["show_url"].InnerText;
        //防钓鱼时间戳
        string anti_phishing_key = "";
        //若要使用请调用类文件submit中的query_timestamp函数
        //客户端的IP地址
        string exter_invoke_ip = Page.Request.UserHostAddress;
        //非局域网的外网IP地址，如：221.0.0.1
        ////////////////////////////////////////////////////////////////////////////////////////////////
        //把请求参数打包成数组
        SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
        sParaTemp.Add("partner", Config.Partner);
        sParaTemp.Add("_input_charset", Config.Input_charset.ToLower());
        sParaTemp.Add("service", "create_direct_pay_by_user");
        sParaTemp.Add("payment_type", payment_type);
        sParaTemp.Add("notify_url", notify_url);
        sParaTemp.Add("return_url", return_url);
        sParaTemp.Add("seller_email", seller_email);
        sParaTemp.Add("out_trade_no", out_trade_no);
        sParaTemp.Add("subject", subject);
        sParaTemp.Add("total_fee", total_fee);
        sParaTemp.Add("body", body);
        sParaTemp.Add("show_url", show_url);
        sParaTemp.Add("anti_phishing_key", anti_phishing_key);
        sParaTemp.Add("exter_invoke_ip", exter_invoke_ip);
        sParaTemp.Add("it_b_pay", min.ToString() + "m");
        //过期时间（分钟）设置未付款交易的超时时间，一旦超时，该笔交易就会自动被关闭。取值范围： 1m～15d。m-分钟， h-小时， d-天， 1c-当天无论交易何时创建，都在 0 点关闭）。该参数数值不接受小数点，如1.5h，可转换为 90m。该功能需要联系支付宝配置关闭时间。
        //建立请求
        string sHtmlText = Submit.BuildRequest(sParaTemp, "get", "确认");
        Response.Write(sHtmlText);
    }
    //支付宝手机端支付
    protected void wapAlipay_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.dConfirmTime.ToString().Length == 0)
        {
            model.dConfirmTime = bll.GetTime(0);
            model.ID = id;
            bll.Update(model);
        }
        title = model.cFromToName;
        if (model.iStatus != 1)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        if (model.cOrder_no != OrderNo)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        int min = 0;
        double iCost = 0.00;
        if (model.iFromTpye == 1)
        {
            if (wdd == 1)
            {
                //单位分钟
                if (model.iFromTpye == 3)//机票业务
                {
                    min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

                }
                else
                { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
            }
            else
            {
                DataTable dt = bll.GetList("cParentOrder='" + model.cParentOrder + "' and idUser=" + CurrentUser.uId + " and iStatus=1 ").Tables[0];
                int count = dt.Rows.Count;
                if (count == 0)
                {
                    AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
                int[] intArray = new int[count];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    //单位分钟
                    if (iFromTpye == 3)//机票业务
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), jpmin);

                    }
                    else
                    {
                        intArray[i] = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[i]["dConfirmTime"], bll.GetTime(0)), 120);
                    }
                    iCost += TypeChangeDefault.NullToDouble(dt.Rows[i]["iCost"], 0);
                }
                ArrayList list = new ArrayList(intArray);
                list.Sort();
                //int max = Convert.ToInt32(list[list.Count - 1]);//取最大值
                min = Convert.ToInt32(list[0]);//取最小值
                if (model.iCost != TypeChangeDefault.NullToDecimal(iCost, 0))
                {
                    AlertHelper.JQAlertGo("该订单金额与支付金额不符，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                    return;
                }
            }
        }
        else
        {
            //单位分钟
            if (model.iFromTpye == 3)//机票业务
            {
                min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), jpmin);

            }
            else
            { min = deadline(TypeChangeDefault.NullToDateTime(model.dConfirmTime, bll.GetTime(0)), ssmin); }
        }
        if (min == 0)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新选择!", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
            return;
        }
        iCost = TypeChangeDefault.NullToDouble(model.iCost, 0);
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/AliPay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Competetion']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);


        //支付宝网关地址
        string GATEWAY_NEW = "http://wappaygw.alipay.com/service/rest.htm?";

        ////////////////////////////////////////////调用授权接口alipay.wap.trade.create.direct获取授权码token////////////////////////////////////////////

        //返回格式
        string format = "xml";
        //必填，不需要修改

        //返回格式
        string v = "2.0";
        //必填，不需要修改

        //请求号
        string req_id = DateTime.Now.ToString("yyyyMMddHHmmss");
        //必填，须保证每次请求都是唯一

        //req_data详细信息

        //服务器异步通知页面路径
        string notify_url = xmlNode["wapnotify_url"].InnerText;
        //需http://格式的完整路径，不允许加?id=123这类自定义参数

        //页面跳转同步通知页面路径
        string call_back_url = xmlNode["wapcall_back_url"].InnerText;
        //需http://格式的完整路径，不允许加?id=123这类自定义参数

        //操作中断返回地址
        string merchant_url = xmlNode["show_url"].InnerText;
        //用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数

        //商户订单号
        string out_trade_no = OrderNo;
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        string subject = model.cFromToName;
        //必填

        //付款金额
        string total_fee = iCost.ToString();
        //必填
        //卖家支付宝帐户
        string seller_email = "info@erun360.com";
        //请求业务参数详细
        string req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url><pay_expire>" + min + "</pay_expire></direct_trade_create_req>";
        //必填

        //把请求参数打包成数组
        Dictionary<string, string> sParaTempToken = new Dictionary<string, string>();
        sParaTempToken.Add("partner", Com.Alipay.Wap.Config.Partner);
        sParaTempToken.Add("_input_charset", Com.Alipay.Wap.Config.Input_charset.ToLower());
        sParaTempToken.Add("sec_id", Com.Alipay.Wap.Config.Sign_type.ToUpper());
        sParaTempToken.Add("service", "alipay.wap.trade.create.direct");
        sParaTempToken.Add("format", format);
        sParaTempToken.Add("v", v);
        sParaTempToken.Add("req_id", req_id);
        sParaTempToken.Add("req_data", req_dataToken);

        //建立请求
        string sHtmlTextToken = Com.Alipay.Wap.Submit.BuildRequest(GATEWAY_NEW, sParaTempToken);
        //URLDECODE返回的信息
        Encoding code = Encoding.GetEncoding(Com.Alipay.Wap.Config.Input_charset);
        sHtmlTextToken = HttpUtility.UrlDecode(sHtmlTextToken, code);

        //解析远程模拟提交后返回的信息
        Dictionary<string, string> dicHtmlTextToken = Com.Alipay.Wap.Submit.ParseResponse(sHtmlTextToken);

        //获取token
        string request_token = dicHtmlTextToken["request_token"];

        ////////////////////////////////////////////根据授权码token调用交易接口alipay.wap.auth.authAndExecute////////////////////////////////////////////


        //业务详细
        string req_data = "<auth_and_execute_req><request_token>" + request_token + "</request_token></auth_and_execute_req>";
        //必填

        //把请求参数打包成数组
        Dictionary<string, string> sParaTemp = new Dictionary<string, string>();
        sParaTemp.Add("partner", Com.Alipay.Wap.Config.Partner);
        sParaTemp.Add("_input_charset", Com.Alipay.Wap.Config.Input_charset.ToLower());
        sParaTemp.Add("sec_id", Com.Alipay.Wap.Config.Sign_type.ToUpper());
        sParaTemp.Add("service", "alipay.wap.auth.authAndExecute");
        sParaTemp.Add("format", format);
        sParaTemp.Add("v", v);
        sParaTemp.Add("req_data", req_data);

        //建立请求
        string sHtmlText = Com.Alipay.Wap.Submit.BuildRequest(GATEWAY_NEW, sParaTemp, "get", "确认");
        Response.Write(sHtmlText);

    }

    /// <summary>  
    /// 判断手机用户UserAgent  
    /// </summary>  
    /// <returns></returns>  
    private bool IsMobile()
    {
        //System.Web.HttpBrowserCapabilities myBrowserCaps = Request.Browser;
        //int isMobile = ((System.Web.Configuration.HttpCapabilitiesBase)myBrowserCaps).IsMobileDevice ? 1 : 0;
        HttpContext context = HttpContext.Current;
        if (context != null)
        {
            HttpRequest request = context.Request;
            if (request.Browser.IsMobileDevice)
                return true;

            string MobileUserAgent = System.Configuration.ConfigurationManager.AppSettings["MobileUserAgent"];
            Regex MOBILE_REGEX = new Regex(MobileUserAgent);
            if (string.IsNullOrEmpty(request.UserAgent) || MOBILE_REGEX.IsMatch(request.UserAgent.ToLower()))
                return true;
        }
        return false;
    }
}