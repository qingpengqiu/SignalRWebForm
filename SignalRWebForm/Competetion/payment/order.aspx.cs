using Erun360.Pay.Alipay.pc;
using Erun360.Pay.tenpayLib;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;

public partial class Competetion_payment_order : System.Web.UI.Page
{
    private int id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //int id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        //string idOrder = TypeChangeDefault.NullToString(Request.QueryString["order"], "");
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 91);
        string idOrder = TypeChangeDefault.NullToString(Request.QueryString["order"], "2015040900000001");
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("！", "/Channels/Competetion/RaceList.aspx", false);
            return;
        }
        Label4.Text = "订单号：" + model.cOrder_no;
        Label1.Text = "项目名称：" + model.iTypeName;
        Label2.Text = "项目类别：" + model.cItemName;
        Label5.Text = "购买数量：" + model.iBuyNum;
        Label3.Text = "项目金额：" + model.iCost.ToString() + "元";
       
    }
 
   
    //pc支付宝支付   
    protected void Alipay_Click(object sender, EventArgs e)
    {
        DBM6.tblOrder modelUpdate = new DBM6.tblOrder();
        modelUpdate.ID = id;
        modelUpdate.dConfirmTime = DateTime.Now;
        new DB6.tblOrder().Update(modelUpdate);

        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("订单失败！", "/Competetion/payment/order.aspx", false);
            return;
        }
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
        string subject = model.iTypeName +"-"+ model.cItemName;
        //付款金额
        //string total_fee = model.iCost.ToString();
        string total_fee = "0.01";
        //订单描述
        string body = model.iTypeName + "-" + model.cItemName;
        //商品展示地址
        string show_url = xmlNode["show_url"].InnerText;
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
    //微信支付
    protected void wxpay_Click(object sender, EventArgs e)
    {
        DBM6.tblOrder model1 = new DBM6.tblOrder();
        model1.ID = id;
        model1.dConfirmTime = DateTime.Now;
        new DB6.tblOrder().Update(model1);
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model == null)
        {
            AlertHelper.JQAlertGo("订单失败！", "/Competetion/payment/order.aspx", false);
            return;
        }
        SignVerifyUtil Params = new SignVerifyUtil();
        //创建RequestHandler实例 
        Params.setParameter("appid", TenpayUtil.appid);
        Params.setParameter("body", "native支付测试");
        Params.setParameter("mch_id", TenpayUtil.partner);
        Params.setParameter("nonce_str", TenpayUtil.getNoncestr());
        Params.setParameter("notify_url", "http://119.2.5.60/Competetion/payment/wxNotifyUrl.aspx");
        Params.setParameter("out_trade_no", model.cOrder_no);
        Params.setParameter("spbill_create_ip", Page.Request.UserHostAddress);// Page.Request.UserHostAddress
        Params.setParameter("total_fee", "1");
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
            Response.Redirect("/Competetion/payment/wxpay.aspx?parm=" + xmlNode["code_url"].InnerText);
        }
        else
        {
            AlertHelper.JQAlertGo(xmlNode["err_code_des"].InnerText, "/Competetion/payment/order.aspx", false);
            return;
            //Response.Write(xmlNode["err_code_des"].InnerText);
        }
    }
}
/*<return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg><appid><![CDATA[wxa72aaa07fef23e73]]></appid><mch_id><![CDATA[1237609802]]></mch_id><nonce_str><![CDATA[WPBtXlgSLRxf9xu9]]></nonce_str><sign><![CDATA[4923813B7710194CBBE5FAF2BFD77149]]></sign><result_code><![CDATA[SUCCESS]]></result_code><prepay_id><![CDATA[wx201504281431085cb69e34db0406727506]]></prepay_id><trade_type><![CDATA[NATIVE]]></trade_type><code_url><![CDATA[weixin://wxpay/bizpayurl?pr=7PNWOWq]]></code_url>
 * 
 * http://119.2.5.60/Competetion/payment/order.aspx
 * <return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg><appid><![CDATA[wxa72aaa07fef23e73]]></appid><mch_id><![CDATA[1237609802]]></mch_id><nonce_str><![CDATA[LzEWdPKYDj5LVaLG]]></nonce_str><sign><![CDATA[004E8DCD6A671AFE011CBC484AB2E9D1]]></sign><result_code><![CDATA[FAIL]]></result_code><err_code><![CDATA[ORDERPAID]]></err_code><err_code_des><![CDATA[该订单已支付]]></err_code_des>
 * 
 */