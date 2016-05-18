using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM4 = Erun360.Model.DB4;
using Erun360.Common;
using Com.Alipay;
using Utils;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Xml;
using System.Xml.Linq;
using System.Configuration;
public partial class Channels_Competetion_RacePay : PageBase
{
    DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
    public string cTitle = "";
    public string cType = "";
    public string iCost = "";
    public string idAlipay = "";
    private int idCompete = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (!IsPostBack)
        {
            DataSet ds = bllsales.GetList(" idorder='" + Request["orderid"].Trim() + "' and iduser=" + CurrentUser.uId);
            if (ds.Tables[0].Rows.Count > 0)
            {
                LabelTitle2.Text = ds.Tables[0].Rows[0]["cTitle"].ToString().Trim();
                LabelTitle.Text = ds.Tables[0].Rows[0]["cTitle"].ToString().Trim();
                Labeltype.Text = ds.Tables[0].Rows[0]["cType"].ToString().Trim();
                Labelcost.Text = ds.Tables[0].Rows[0]["iCost"].ToString().Trim();

                idAlipay = ds.Tables[0].Rows[0]["idAlipay"].ToString().Trim();

                idCompete = Convert.ToInt32(ds.Tables[0].Rows[0]["idSignUp"].ToString().Trim());
                DBM4.tblRACE_SIGNUP mSignUp = new DB4.tblRACE_SIGNUP().GetModel(idCompete);
                if (mSignUp != null)
                {
                    //if (DateTime.Now > mSignUp.dJoinEnd)
                    //{
                    //    Buttonpay.Enabled = false;
                    //    AlertHelper.JQAlertGo("报名截止无法付款，谢谢参与!", UrlHelper.BlogUrl((int)mSignUp.idBlog), false);
                    //    return;
                    //}
                    if (DateTime.Compare(DateTime.Now, TypeChangeDefault.NullToDateTime(mSignUp.dJoinEnd, DateTime.Now.AddDays(-1))) > 0)
                    {
                        AlertHelper.JQAlertGo("报名已过期请,选择其他的赛事！", "/Channels/Competetion/RaceList.aspx", false);
                        return;
                    }
                    int count = new DB4.tblRACE_SALES().GetRecordCount(" iState>1 and idSignUp=" + idCompete);
                    if (count >= mSignUp.iLimit)
                    {
                        AlertHelper.JQAlertGo("报名已满！", "/Channels/Competetion/RaceList.aspx", false);
                        return;
                    }
                    int state = new DB4.tblRACE_SALES().GetState(CurrentUser.uId, mSignUp.idCompete??0);
                    if (0 == state)
                    {
                        AlertHelper.JQAlert("正在审核中,请审核通过后付款！",false);
                        return;
                    }
                    else if (2 == state)
                    {
                        AlertHelper.JQAlert("您已报名！", false);
                        return;
                    }
                    else if (3 == state)
                    {
                        AlertHelper.JQAlert("您已组队！", false);
                        return;
                    }
                    else if (1 == state)
                    {
                        if ("0" == Labelcost.Text)
                        {
                            if (TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["iState"].ToString(), 0) >= 2)
                            {
                                AlertHelper.JQAlertGo("您已报名，请勿重复提交!", UrlHelper.BlogUrl((int)mSignUp.idBlog), false);
                                return;
                            }
                            DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
                            modelsales.iState = 2;
                            modelsales.dPay = DateTime.Now;
                            modelsales.id = Convert.ToInt32(ds.Tables[0].Rows[0]["id"].ToString().Trim());
                            bllsales.Update(modelsales);
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《<a target=\"_blank\" href=\"/blog/" + mSignUp.idBlog + ".aspx\">" + mSignUp.cTitle + "</a>》中报名成功！请您持续关注，谢谢！";
                                disModel.idInfo = Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString().Trim());
                                disModel.idUser = 100001183;
                                disModel.cLoginname = "益跑赛事";
                                // disModel.dCreate = DateTime.Now;
                                int imessage = disBll.Add(disModel);
                                if (imessage > 0)
                                {

                                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                    mMessage.cId = 100001183;
                                    mMessage.uId = Convert.ToInt32(ds.Tables[0].Rows[0]["idUser"].ToString().Trim());
                                    mMessage.itype = 31;
                                    mMessage.idcode = imessage;
                                    int test = new DB3.tblMessage().Add(mMessage);
                                }
                                DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                mActivity.idUser = CurrentUser.uId;
                                mActivity.cNickName = CurrentUser.cNickName;
                                mActivity.cAvatar = CurrentUser.cAvatar;
                                mActivity.idBlog = imessage;
                                mActivity.idGroup = "44";
                                mActivity.cTitle = "在《<a target=\"_blank\" href=\"/blog/" + mSignUp.idBlog + ".aspx\">" + mSignUp.cTitle + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + mSignUp.idCompete + "\">[参加]</a>！";
                                mActivity.cBio = "";
                                mActivity.dCreate = DateTime.Now;
                                new DB2.tblActivity().Add(mActivity);
                                //报名赛事最低送10积分
                                if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "0")
                                {
                                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                }
                                //if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "1")
                                //{
                                //    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840002, 4, TypeChangeDefault.NullToDecimal(mSignUp.iScore, 0), "赛事花费，项目" + mSignUp.id.ToString());
                                //}
                                //else
                                //{
                                //    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                //}
                            }
                            catch (Exception ex)
                            {

                            }
                            new DB4.tblAnnexLog().UpdateState(TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0), mSignUp.idCompete ?? 0, 2);
                            int idSignUp = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0);
                            DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idSignUp);
                            if (mSign != null)
                            {
                                if (mSign.iType == 3)
                                {
                                    //ltlgoteam.Text = "<a href=\"/Channels/Competetion/Team.aspx?id=" + mSign.idCompete + "&p=" + idSignUp + "\" class=\"goteam\" target=\"_blank\">加入团队</a>";
                                    AlertHelper.JQAlertGo("报名成功!快去组队吧", UrlHelper.BlogUrl((int)mSignUp.idBlog), true);
                                }
                                else
                                {
                                    AlertHelper.JQAlertGo("报名成功!", UrlHelper.BlogUrl((int)mSignUp.idBlog), true);
                                }
                            }
                            AlertHelper.JQAlertGo("报名成功!", UrlHelper.BlogUrl((int)mSignUp.idBlog), true);
                        }
                        else
                        {
                            Buttonpay.Enabled = true;
                            BtnAlipay.Enabled = true;
                        }
                    }
                }
                else
                {
                    AlertHelper.JQAlertGo("该订单不存在,选择其他的赛事！", "/Channels/Competetion/RaceList.aspx", false);
                }
            }
            else
            {
                
                AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/channels/competetion/RaceList.aspx", false);
                return;
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ////////////////////////////////////////////请求参数////////////////////////////////////////////
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable dt = bllsales.GetList(" idorder='" + Request["orderid"].Trim() + "' and iduser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM4.tblRACE_SALES model = new DBM4.tblRACE_SALES();
            model.dConfirm = DateTime.Now;
            model.id = Convert.ToInt32(dt.Rows[0]["id"].ToString().Trim());
            bllsales.Update(model);
        }
        else
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/channels/competetion/RaceList.aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Competetion']");//查找
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
        string out_trade_no = Request["orderid"].Trim();
        //商户网站订单系统中唯一订单号，必填

        //订单名称
        string subject = LabelTitle.Text;
        //必填

        //付款金额
        string total_fee = Labelcost.Text;
        //string total_fee = "0.01";
        //必填

        //订单描述

        string body = LabelTitle.Text;
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
    protected void BtnAlipay_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DataTable  dt = bllsales.GetList(" idorder='" + Request["orderid"].Trim() + "' and iduser=" + CurrentUser.uId).Tables[0];
        if (dt.Rows.Count > 0)
        {
            DBM4.tblRACE_SALES model = new DBM4.tblRACE_SALES();
            model.dConfirm = DateTime.Now;
            model.id = Convert.ToInt32(dt.Rows[0]["id"].ToString().Trim());
            bllsales.Update(model);
        }
        else
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/channels/competetion/RaceList.aspx", false);
            return;
        }
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
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
        string merchant_url = "/Channels/Competetion/RacePay.aspx?orderid=" + Request["orderid"].Trim();
        //用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数
        //卖家支付宝帐户
        string seller_email = "info@erun360.com";
        //必填
        //商户订单号
        string out_trade_no = Request["orderid"].Trim();
        //商户网站订单系统中唯一订单号，必填
        //订单名称
        string subject = LabelTitle.Text;
        //必填
        //付款金额        
        string total_fee = Labelcost.Text;
        //string total_fee = "0.01";
        //必填
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