using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Data;
using System.Collections;
using Com.Alipay;
using System.Xml;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Text;
public partial class GroupBuy_IOrder : PageBase
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
            DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=1 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);
                if (idUser != CurrentUser.uId)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/GroupBuy/IntegRallist.aspx", false);
                    return;
                }
                int iType = TypeChangeDefault.NullToInt(dt.Rows[0]["iType"].ToString().Trim(), 0);
                if (iType != 1)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/GroupBuy/IntegRallist.aspx", false);
                    return;
                }
                DBM1.tblGoods model = new DB1.tblGoods().GetModel(idGood);
                if (model == null)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/IntegRallist.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("该商品不存在或已过期！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                if (model.iEntity != 1)
                {
                    idsboxt.Visible = false;
                    idaddress.Visible = false;
                }
                if (DateTime.Now < model.dBeginTime)
                {
                    AlertHelper.JQAlertGo("还没开始兑换，敬请关注！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                if (DateTime.Now > model.dEndTime)
                {
                    AlertHelper.JQAlertGo("兑换已结束，看看其他商品吧！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                ltlImg.Text = "<img src=\"" + dt.Rows[0]["cImage"].ToString() + "\" alt=\"\"/>";
                ltlTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                ltlNum.Text = dt.Rows[0]["iBuyNum"].ToString();
                ltlColor.Text = dt.Rows[0]["cColor"].ToString() + "/" + dt.Rows[0]["cSize"].ToString();
                if (dt.Rows[0]["iCost"].ToString() == "0.00")
                {
                    ltlSorce.Text = dt.Rows[0]["cScore"].ToString() + "积分";
                }
                else
                {
                    ltlSorce.Text = dt.Rows[0]["cScore"].ToString() + "积分+";
                    ltlPrice.Text = dt.Rows[0]["iCost"].ToString();
                    ltlTip.Text = "元";
                    ltlwarn.Text = "(请于2小时之内完成付款)";
                }

                ltlAddress.Text = dt.Rows[0]["cCityname"].ToString() + dt.Rows[0]["cAddress"].ToString() + "  " + dt.Rows[0]["cMobile"].ToString() + "  " + dt.Rows[0]["cName"].ToString();
                ltlMark.Text = dt.Rows[0]["cMark1"].ToString();
                idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString(), 0);//商品id
                ltlidOrder.Text = idorder;                
                int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分

                if (idUser != CurrentUser.uId)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                int state = TypeChangeDefault.NullToInt(dt.Rows[0]["iState"].ToString().Trim(), 0);
                if (state >= 2)
                {
                    AlertHelper.JQAlertGo("您已成功兑换该商品！", "/infocenter/Rlist.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                if (dt.Rows[0]["iCost"].ToString() == "0.00")
                {
                    ToNOPay.Visible = true;
                    ToNOPay.Enabled = true;
                    topay.Visible = false;
                    topay.Enabled = false;
                }
                else
                {
                    ToNOPay.Visible = false;
                    ToNOPay.Enabled = false;
                    topay.Visible = true;
                    topay.Enabled = true;
                    wapsorcepay.Visible = true;
                    wapsorcepay.Enabled = true;
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您的订单不存在,请重新选择！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                return;
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
         DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=1 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
         if (dt.Rows.Count > 0)
         {
             DBM1.tblShopping mShop = new DBM1.tblShopping();
             mShop.dConfirm = DateTime.Now;
             mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
             new DB1.tblShopping().Update(mShop);
         }
         else
         {
             AlertHelper.JQAlertGo("您的订单不存在,请重新选择！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
             return;
         }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Score']");//查找
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
        int jf = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);        
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=1 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
            idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString(), 0);//商品id
            int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
            decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
            DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
            DBM1.tblShopping mShop = new DBM1.tblShopping();
            mShop.idAlipay = idorder;
            mShop.dPay = DateTime.Now;
            mShop.iState = 2;
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            int idcode = 0;
            if (mGood.iEntity == 0)
            {
                DataTable dtcode = new DB5.tblCode().GetList(1, "iValid=0 ", "id").Tables[0];
                if (dtcode.Rows.Count == 0)
                {
                    AlertHelper.JQAlertGo("兑换劵已售完，看看其他的！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
                    return;
                }
                idcode = TypeChangeDefault.NullToInt(dtcode.Rows[0]["id"].ToString().Trim(), 0);
                mShop.cMark4 = dtcode.Rows[0]["idCode"].ToString();
            }
            if (new DB1.tblShopping().Update(mShop))
            {               
                try
                {
                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                    disModel.cContent = "您在《<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》中积分兑换成功！请您持续关注，谢谢！";
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
                        mActivity.cTitle = "在《<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》商品中兑换成功！您也去看看呗<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">[查看]</a>！";
                        mActivity.cBio = "";
                        mActivity.dCreate = DateTime.Now;
                        new DB2.tblActivity().Add(mActivity);
                    }
                }
                catch (Exception ex)
                {
                    AlertHelper.JQAlertGo("兑换失败，重新兑换！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
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
                    mCode.dBuyTime = DateTime.Now;
                    mCode.idUser = idUser;
                    new DB5.tblCode().Update(mCode); 
                }
                //报名赛事最低送10积分
                if (isuse == 0)
                {
                    new DB1.tblIntegral().InsertScore(idUser, 200850001, 5, iCost);
                }
            }
            AlertHelper.JQAlertGo("您已兑换成功，请持续关注！", "/Pay/Score/ScorePay.aspx?idorder=" + idorder, true);
            return;
        }
        else
        {
            AlertHelper.JQAlertGo("您已兑换失败，请重新兑换！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
            return;
        }
    }
    //手机支付接口
    protected void wapsorcepay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB1.tblShopping().GetList("iState=1 and iType=1 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM1.tblShopping mShop = new DBM1.tblShopping();
            mShop.dConfirm = DateTime.Now;
            mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            new DB1.tblShopping().Update(mShop);
        }
        else
        {
            AlertHelper.JQAlertGo("您的订单不存在,请重新选择！", "/infocenter/Integral.aspx?uId=" + CurrentUser.uId + "&tablep=1", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Score']");//查找
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
        string merchant_url = "/GroupBuy/IOrder.aspx?idorder=" + Request["idorder"].Trim();
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
}