using Com.Alipay;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Data;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Text;

public partial class infocenter_RacePay : PageBase
{
    private int idRace = 0;
    public string img = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (!IsPostBack)
        {
            DBM4.tblRACE_ACTIVITY model = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
            if (model == null)
            {
                AlertHelper.JQAlertGo("该活动不存在!", "/infocenter/ClubSearch.aspx", false);
                return;
            }
            if (DateTime.Now < model.dJoinBegin)
            {
                AlertHelper.JQAlertGo("该活动还没开始报名，敬请关注！", "/infocenter/ClubSearch.aspx", false);
                return;
            }
            if (DateTime.Now > model.dJoinEnd)
            {
                AlertHelper.JQAlertGo("报名已截止，看看其他活动！", "/infocenter/ClubSearch.aspx", false);
                return;
            }
            string idOrder = new DB4.tblRACE_JOIN().GetidOrder(idRace, CurrentUser.uId);
            ltlidOrder.Text = idOrder;
            ltlTitle.Text = model.cTitle;
            //ltlPrice.Text = model.iFee.ToString();
            img = model.cImage;
            DataTable dt = new DB4.tblRACE_JOIN().GetList("idActivity=" + idRace + " and idUser=" + CurrentUser.uId).Tables[0];
            if (dt.Rows.Count > 0)
            {
                int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                decimal iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                int state = TypeChangeDefault.NullToInt(dt.Rows[0]["iStatus"].ToString().Trim(), 0);
                ltlPrice.Text = dt.Rows[0]["iCost"].ToString().Trim();
                if (state >= 2)
                {
                    AlertHelper.JQAlertGo("您已加入该活动！", "/race/" + idRace + ".aspx", false);
                    return;
                }
                else if (state == 1)
                {
                    if (ltlPrice.Text == "0.00")
                    {
                        topay.Visible = false;
                        topay.Enabled = false;
                        DBM4.tblRACE_JOIN mJoin = new DBM4.tblRACE_JOIN();
                        mJoin.idAlipay = idOrder;
                        mJoin.dPay = DateTime.Now;
                        mJoin.iStatus = 2;
                        mJoin.id = id;
                        if (new DB4.tblRACE_JOIN().Update(mJoin))
                        {
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">" + model.cTitle + "</a>》约跑中付款成功！请您持续关注，谢谢！";
                                disModel.idInfo = idUser;
                                disModel.idUser = 100001183;
                                disModel.cLoginname = "益跑赛事";
                                disModel.dCreate = DateTime.Now;
                                int imessage = disBll.Add(disModel);
                                if (imessage > 0)
                                {

                                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                    mMessage.cId = 100001183;
                                    mMessage.uId = idUser;
                                    mMessage.itype = 31;
                                    mMessage.idcode = imessage;
                                    int test = new DB3.tblMessage().Add(mMessage);
                                }
                                DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                mActivity.idUser = idUser;
                                mActivity.cNickName = CurrentUser.cNickName;
                                mActivity.cAvatar = CurrentUser.cAvatar;
                                mActivity.idBlog = imessage;
                                mActivity.idGroup = "44";
                                mActivity.cTitle = "在《<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">" + model.cTitle + "</a>》约跑中报名成功！邀请您<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">[参加]</a>！";
                                mActivity.cBio = "";
                                mActivity.dCreate = DateTime.Now;
                                new DB2.tblActivity().Add(mActivity);
                                ////报名赛事最低送10积分
                                //if (isuse == 0)
                                //{
                                //    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200820001, 2, iCost);
                                //}
                                // 报名约跑积分
                                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810017, 1, 0);
                            }
                            catch (Exception ex)
                            {

                            }
                            AlertHelper.JQAlertGo("您已成功报名,请持续关注！", "/race/" + idRace + ".aspx", true);
                            return;
                        }
                    }
                }
                else
                {
                    AlertHelper.JQAlertGo("您还没报名该活动!", "/race/" + idRace + ".aspx", false);
                    return;
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您还没报名!", "/race/" + idRace + ".aspx", false);
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
        DataTable dt = new DB4.tblRACE_JOIN().GetList("idActivity=" + idRace + " and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            DBM4.tblRACE_JOIN mJoin = new DBM4.tblRACE_JOIN();
            mJoin.dCreate = DateTime.Now;
            mJoin.id = id;
            new DB4.tblRACE_JOIN().Update(mJoin);
        }
        else
        {
            AlertHelper.JQAlertGo("您还没报名该活动!", "/race/" + idRace + ".aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Race']");//查找
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
    //手机支付接口
    protected void wapracepay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = new DB4.tblRACE_JOIN().GetList("idActivity=" + idRace + " and idUser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
            DBM4.tblRACE_JOIN mJoin = new DBM4.tblRACE_JOIN();
            mJoin.dCreate = DateTime.Now;
            mJoin.id = id;
            new DB4.tblRACE_JOIN().Update(mJoin);
        }
        else
        {
            AlertHelper.JQAlertGo("您还没报名该活动!", "/race/" + idRace + ".aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Race']");//查找
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
        string merchant_url = xmlNode["wapcall_back_url"].InnerText;
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