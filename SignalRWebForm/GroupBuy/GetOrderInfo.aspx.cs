using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;

using Utils;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
using Com.Alipay;
using System.Xml;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Text;
using Erun360.Pay.WxPayAPI;
using Erun360.Pay.tenpayLib;
using DB6 = Erun360.BLL.DB6;
public partial class GroupBuy_GetOrderInfo : PageBase
{
    public string Result = string.Empty;
    public string idorder = string.Empty;
    public int idGood = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["idorder"] != null)
        {
            idorder = TypeChangeDefault.NullToString(Request.QueryString["idorder"].ToString(), "");
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (!IsPostBack)
        {
            DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);
                if (idUser != CurrentUser.uId)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/GroupBuy/Group.aspx?id=" + idGood, false);
                    return;
                }
                int iType = TypeChangeDefault.NullToInt(dt.Rows[0]["iType"].ToString().Trim(), 0);
                if (iType != 2)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                DBM1.tblGoods model = new DB1.tblGoods().GetModel(idGood);
                if (model == null)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iEntity != 1)
                {
                    idsboxt.Visible = false;
                    idaddress.Visible = false;
                }
                if (CurrentTime() < model.dBeginTime)
                {
                    AlertHelper.JQAlertGo("还没开始拼团，敬请关注！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (CurrentTime() > model.dEndTime)
                {
                    AlertHelper.JQAlertGo("拼团已结束，看看其他商品吧！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                if (model.iEntity != 1)
                {
                    idsboxt.Visible = false;
                    idaddress.Visible = false;
                }
                ltlImg.Text = "<img src=\"" + dt.Rows[0]["cImage"].ToString() + "\" alt=\"\"/>";
                ltlTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                ltlNum.Text = dt.Rows[0]["iBuyNum"].ToString();
                ltlColor.Text = dt.Rows[0]["cColor"].ToString() + "/" + dt.Rows[0]["cSize"].ToString();
                ltlSocre.Text = dt.Rows[0]["cScore"].ToString();
                ltlMoney.Text = dt.Rows[0]["fMoney"].ToString();
                ltlPrice.Text = dt.Rows[0]["iCost"].ToString();
                ltlAddress.Text = dt.Rows[0]["cCityname"].ToString() + dt.Rows[0]["cAddress"].ToString() + "  " + dt.Rows[0]["cMobile"].ToString() + "  " + dt.Rows[0]["cName"].ToString();
                ltlMark.Text = dt.Rows[0]["cMark1"].ToString();
                idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString(), 0);//商品id
                ltlidOrder.Text = idorder;

                int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额

                int state = TypeChangeDefault.NullToInt(dt.Rows[0]["iState"].ToString().Trim(), 0);
                if (state >= 2)
                {
                    AlertHelper.JQAlertGo("您已购买该商品！", "/GroupBuy/Group.aspx?id=" + idGood, false);
                    return;
                }
                if (ltlPrice.Text == "0.00")
                {
                    ToNOPay.Visible = true;
                    ToNOPay.Enabled = true;
                    topay.Visible = false;
                    topay.Enabled = false;
                    wxsmpay.Visible = false;
                    wxsmpay.Enabled = false;
                    wxpay.Visible = false;
                    wxpay.Enabled = false;
                }
                else
                {
                    ToNOPay.Visible = false;
                    ToNOPay.Enabled = false;
                    topay.Visible = true;
                    topay.Enabled = true;
                    waptourpay.Visible = true;
                    waptourpay.Enabled = true;
                    wxsmpay.Visible = true;
                    wxsmpay.Enabled = true;
                    wxpay.Visible = false;
                    wxpay.Enabled = false;
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
                return;
            }
            string userAgent = Request.UserAgent;
            if (userAgent.ToLower().Contains("micromessenger"))
            {
                string pattern = @"MicroMessenger\/(\d+)";//MicroMessenger\/(\d+.)(\d+)  结果：MicroMessenger/6.2
                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(pattern);
                System.Text.RegularExpressions.MatchCollection mc = regex.Matches(Request.UserAgent);
                int wxh = TypeChangeDefault.NullToInt(mc[0].Value.Replace("MicroMessenger/", ""), 0);//微信版本号
                Log.Info(this.GetType().ToString(), "微信版本号:" + wxh);
                if (wxh < 5)//微信版本号小于5不允许微信支付
                {
                    AlertHelper.JQAlertGo("您的微信不支持请，升级后重试！", "/GroupBuy/GetOrderInfo.aspx?idorder=" + idorder, false);
                    return;
                }
                double total_fee = TypeChangeDefault.NullToDouble(ltlPrice.Text, 0);//付款金额
                if (total_fee > 0.0)
                {

                    wxsmpay.Visible = false;
                    wxsmpay.Enabled = false;
                    wxpay.Visible = true;
                    wxpay.Enabled = true;
                    topay.Visible = false;
                    topay.Enabled = false;
                }
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

        }
    }
    protected void topay_Click(object sender, EventArgs e)
    {
        ////////////////////////////////////////////请求参数////////////////////////////////////////////
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM1.tblShopping mShop = new DBM1.tblShopping();

            mShop.dConfirm = CurrentTime();
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            new DB1.tblShopping().Update(mShop);
        }
        else
        {
            AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Tour']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        //支付类型
        string payment_type = "1";
        //必填，不能修改
        //服务器异步通知页面路径
        string notify_url = xmlNode["notify_url"].InnerText;
        //需http://格式的完整路径，不能加?id=123这类自定义参数

        //页面跳转同步通知页面路径
        string return_url = xmlNode["return_url"].InnerText;
        //需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

        //卖家支付宝帐户
        string seller_email = "info@erun360.com";
        //必填

        //商户订单号
        string out_trade_no = ltlidOrder.Text;
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        string subject = ltlTitle.Text;
        //必填

        //付款金额
        string total_fee = ltlPrice.Text;
        //string total_fee = "0.01";
        //必填

        //订单描述

        string body = ltlTitle.Text;
        //商品展示地址
        string show_url = xmlNode["show_url"].InnerText;
        //需以http://开头的完整路径，例如：http://www.xxx.com/myorder.html

        //防钓鱼时间戳
        string anti_phishing_key = "";
        //若要使用请调用类文件submit中的query_timestamp函数

        //客户端的IP地址
        string exter_invoke_ip = "";
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
        sParaTemp.Add("it_b_pay", "2h");//过期时间
        //建立请求
        string sHtmlText = Submit.BuildRequest(sParaTemp, "get", "确认");
        Response.Write(sHtmlText);
    }
    protected void ToNOPay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分  
            idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString(), 0);//商品id
            int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
            decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
            DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
            DBM1.tblShopping mShop = new DBM1.tblShopping();
            mShop.idAlipay = idorder;
            mShop.dPay = CurrentTime();
            mShop.iState = 2;
            int idcode = 0;
            if (mGood.iEntity == 0)
            {
                DataTable dtcode = new DB5.tblCode().GetList(1, "iValid=0", "id").Tables[0];
                if (dtcode.Rows.Count == 0)
                {
                    AlertHelper.JQAlertGo("兑换劵已售完，看看其他的！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                idcode = TypeChangeDefault.NullToInt(dtcode.Rows[0]["id"].ToString().Trim(), 0);
                mShop.cMark4 = dtcode.Rows[0]["idCode"].ToString();
            }
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            if (new DB1.tblShopping().Update(mShop))
            {

                try
                {
                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cContent = "您在《<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">" + mGood.cName + "</a>》中拼团成功！请您持续关注，谢谢！";
                    disModel.idInfo = idUser;
                    disModel.idUser = 100035871;
                    disModel.cLoginname = "益跑客服";
                    int imessage = disBll.Add(disModel);
                    if (imessage > 0)
                    {
                        DBM3.tblMessage mMessage = new DBM3.tblMessage();
                        mMessage.cId = 100035871;
                        mMessage.uId = idUser;
                        mMessage.itype = 31;
                        mMessage.idcode = imessage;
                        int test = new DB3.tblMessage().Add(mMessage);
                    }
                    DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(idUser);
                    if (model != null)
                    {
                        DBM2.tblActivity mActivity = new DBM2.tblActivity();
                        mActivity.idUser = model.id;
                        mActivity.cNickName = model.cNickName;
                        mActivity.cAvatar = model.cAvatar;
                        mActivity.idBlog = imessage;
                        mActivity.idGroup = "44";
                        mActivity.cTitle = "在《<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">" + mGood.cName + "</a>》中拼团成功！您也去看看呗<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">[查看]</a>！";
                        mActivity.cBio = "";
                        mActivity.dCreate = CurrentTime();
                        new DB2.tblActivity().Add(mActivity);

                    }
                }
                catch (Exception ex)
                {
                    AlertHelper.JQAlertGo("您拼团失败，请重新拼团！", "/GroupBuy/GroupList.aspx", false);
                    return;
                }
                //积分兑换劵更新状态
                if (idcode != 0)
                {
                    DBM5.tblCode mCode = new DBM5.tblCode();
                    mCode.id = idcode;
                    mCode.idGood = idGood;
                    mCode.cGoodName = mGood.cName;
                    mCode.cValue = mGood.fSellPrice;
                    mCode.iValid = 1;
                    mCode.dBuyTime = CurrentTime();
                    mCode.idUser = idUser;
                    new DB5.tblCode().Update(mCode);
                }
                //报名赛事最低送10积分            
                if (isuse == 0)
                {
                    new DB1.tblIntegral().InsertScore(idUser, 200850001, 5, iCost);
                }
            }
            AlertHelper.JQAlertGo("您已拼团成功，请持续关注！", "/Pay/Tour/TourPay.aspx?idorder=" + idorder, true);
            return;
        }
        else
        {
            AlertHelper.JQAlertGo("您已拼团失败，请重新拼团！", "/GroupBuy/GroupList.aspx", false);
            return;
        }
    }

    //手机支付接口
    protected void waptourpay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM1.tblShopping mShop = new DBM1.tblShopping();
            mShop.dConfirm = CurrentTime();
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            new DB1.tblShopping().Update(mShop);
        }
        else
        {
            AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Tour']");//查找
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
        string req_id = CurrentTime().ToString("yyyyMMddHHmmss");
        //必填，须保证每次请求都是唯一
        //req_data详细信息
        //服务器异步通知页面路径
        string notify_url = xmlNode["wapnotify_url"].InnerText;
        //需http://格式的完整路径，不允许加?id=123这类自定义参数
        //页面跳转同步通知页面路径
        string call_back_url = xmlNode["wapcall_back_url"].InnerText;
        //需http://格式的完整路径，不允许加?id=123这类自定义参数
        //操作中断返回地址
        string merchant_url = "/GroupBuy/GetOrderInfo.aspx?idorder=" + Request["idorder"].Trim();
        //用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数
        //卖家支付宝帐户
        string seller_email = "info@erun360.com";
        //必填
        //商户订单号
        string out_trade_no = Request["idorder"].Trim();
        //商户网站订单系统中唯一订单号，必填
        //订单名称
        string subject = ltlTitle.Text;
        //必填
        //付款金额        
        string total_fee = ltlPrice.Text;
        //string total_fee = "0.01";
        //请求业务参数详细
        string req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url><pay_expire>120</pay_expire></direct_trade_create_req>";
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
    protected void wxpay_Click(object sender, EventArgs e)
    {
        //string total_fee = "1";
        if (ViewState["openid"] != null)
        {
            string openid = ViewState["openid"].ToString();
            string url = "/weixinpay/JsApiPayPage.aspx?openid=" + openid + "&idorder=" + idorder;
            Response.Redirect(url);
        }
        else
        {
            Log.Info(this.GetType().ToString(), "页面缺少参数，请重试(获取openid 失败)");
        }
    }
    protected void wxsmpay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=2 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM1.tblShopping mShop = new DBM1.tblShopping();
            mShop.dConfirm = new DB6.tblOrder().GetTime(0);
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            new DB1.tblShopping().Update(mShop);
        }
        else
        {
            AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList.aspx", false);
            return;
        }
        int min = deadline(TypeChangeDefault.NullToDateTime(dt.Rows[0]["dConfirm"], CurrentTime()), 120);
        if (min <= 0)
        {
            AlertHelper.JQAlertGo("订单已过期，请重新购买！", "/GroupBuy/GroupList.aspx", false);
            return;
        }

        double iCost = 0.00;
        iCost = TypeChangeDefault.NullToDouble(ltlPrice.Text, 0);//(iCost * 100).ToString());//金额以分计算
        SignVerifyUtil Params = new SignVerifyUtil();
        //创建RequestHandler实例 
        Params.setParameter("appid", TenpayUtil.appid);
        Params.setParameter("body", dt.Rows[0]["cGoodName"].ToString());
        Params.setParameter("detail", dt.Rows[0]["cColor"].ToString() + "/" + dt.Rows[0]["cSize"].ToString());
        Params.setParameter("mch_id", TenpayUtil.partner);
        Params.setParameter("nonce_str", TenpayUtil.getNoncestr());
        Params.setParameter("notify_url", "http://www.erun360.com/weixinpay/wxNotifyUrl.aspx");
        Params.setParameter("out_trade_no", idorder);
        Params.setParameter("spbill_create_ip", Page.Request.UserHostAddress);
        Params.setParameter("total_fee", (iCost * 100).ToString());//金额以分计算
        Params.setParameter("time_start", CurrentTime().ToString("yyyyMMddHHmmss"));
        Params.setParameter("time_expire", CurrentTime().AddMinutes(min).ToString("yyyyMMddHHmmss"));
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
            Response.Redirect("/weixinpay/wxpay.aspx?order=" + idorder + "&parm=" + xmlNode["code_url"].InnerText);
        }
        else
        {
            if (string.IsNullOrWhiteSpace(TypeChangeDefault.NullToString(xmlNode["err_code_des"], "")))
            {
                AlertHelper.JQAlert(xmlNode["return_msg"].InnerText, false);
                return;
            }
            else
            {
                AlertHelper.JQAlert(xmlNode["err_code_des"].InnerText, false);
                return;
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
        DateTime date2 = new DB6.tblOrder().GetTime(0);
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm > max)
        {
            return 0;
        }
        return (max - mm) > 120 ? 120 : max - mm;
    }
}