﻿using Erun360.Pay.Alipay.wap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// 功能：手机网页支付接口接入页
/// 版本：3.3
/// 日期：2012-07-05
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// /////////////////注意///////////////////////////////////////////////////////////////
/// 如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
/// 1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
/// 2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
/// 3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
/// 
/// 如果不想使用扩展功能请把扩展功能参数赋空值。
/// </summary>
public partial class Competetion_Alipay_wap_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void BtnAlipay_Click(object sender, EventArgs e)
    {
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
        string notify_url = "http://商户网关地址/WS_WAP_PAYWAP-CSHARP-UTF-8/notify_url.aspx";
        //需http://格式的完整路径，不允许加?id=123这类自定义参数

        //页面跳转同步通知页面路径
        string call_back_url = "http://127.0.0.1:64704/WS_WAP_PAYWAP-CSHARP-UTF-8/call_back_url.aspx";
        //需http://格式的完整路径，不允许加?id=123这类自定义参数

        //操作中断返回地址
        string merchant_url = "http://127.0.0.1:64704/WS_WAP_PAYWAP-CSHARP-UTF-8/xxxxx.aspx";
        //用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数

        //商户订单号
        string out_trade_no = WIDout_trade_no.Text.Trim();
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        string subject = WIDsubject.Text.Trim();
        //必填

        //付款金额
        string total_fee = WIDtotal_fee.Text.Trim();
        //必填

        //请求业务参数详细
        string req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + Config.Seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url></direct_trade_create_req>";
        //必填

        //把请求参数打包成数组
        Dictionary<string, string> sParaTempToken = new Dictionary<string, string>();
        sParaTempToken.Add("partner", Config.Partner);
        sParaTempToken.Add("_input_charset", Config.Input_charset.ToLower());
        sParaTempToken.Add("sec_id", Config.Sign_type.ToUpper());
        sParaTempToken.Add("service", "alipay.wap.trade.create.direct");
        sParaTempToken.Add("format", format);
        sParaTempToken.Add("v", v);
        sParaTempToken.Add("req_id", req_id);
        sParaTempToken.Add("req_data", req_dataToken);

        //建立请求
        string sHtmlTextToken = Submit.BuildRequest(GATEWAY_NEW, sParaTempToken);
        //URLDECODE返回的信息
        Encoding code = Encoding.GetEncoding(Config.Input_charset);
        sHtmlTextToken = HttpUtility.UrlDecode(sHtmlTextToken, code);

        //解析远程模拟提交后返回的信息
        Dictionary<string, string> dicHtmlTextToken = Submit.ParseResponse(sHtmlTextToken);

        //获取token
        string request_token = dicHtmlTextToken["request_token"];

        ////////////////////////////////////////////根据授权码token调用交易接口alipay.wap.auth.authAndExecute////////////////////////////////////////////


        //业务详细
        string req_data = "<auth_and_execute_req><request_token>" + request_token + "</request_token></auth_and_execute_req>";
        //必填

        //把请求参数打包成数组
        Dictionary<string, string> sParaTemp = new Dictionary<string, string>();
        sParaTemp.Add("partner", Config.Partner);
        sParaTemp.Add("_input_charset", Config.Input_charset.ToLower());
        sParaTemp.Add("sec_id", Config.Sign_type.ToUpper());
        sParaTemp.Add("service", "alipay.wap.auth.authAndExecute");
        sParaTemp.Add("format", format);
        sParaTemp.Add("v", v);
        sParaTemp.Add("req_data", req_data);

        //建立请求
        string sHtmlText = Submit.BuildRequest(GATEWAY_NEW, sParaTemp, "get", "确认");
        Response.Write(sHtmlText);

    }
}