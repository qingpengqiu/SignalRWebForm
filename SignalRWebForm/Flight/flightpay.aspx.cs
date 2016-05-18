using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using System.Xml;
using Com.Alipay;
using Utils;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using Erun360.Model.DB6;
using System.Net;
public partial class Flight_flightpay : PageBase
{
    private string erunkey = "3nv40T4zChc=e360";//
    protected void Page_Load(object sender, EventArgs e)
    {
        string orderid = TypeChangeDefault.NullToString(Request["order"], "");// 
        int ID = TypeChangeDefault.NullToInt(Request["id"], 0);
        string wap = TypeChangeDefault.NullToString(Request["wap"], "1");//1手机支付 0pc支付
        ////////////////////////////////////////////请求参数////////////////////////////////////////////
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM6.tblOrder model = new DB6.tblOrder().GetModel(ID);
        if (model == null)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Flight/flightgroom.aspx", false);
            return;
        }
        if(model.iStatus!=1)
        {
            AlertHelper.JQAlertGo("该订单已过期，请重新报名!", "/Flight/flightgroom.aspx", false);
            return;
        }
        if (model.idUser != CurrentUser.uId)
        {
            AlertHelper.JQAlertGo("参数错误!", "/Flight/flightgroom.aspx", false);
            return;
        }
        if (model.cOrder_no != orderid)
        {
            AlertHelper.JQAlertGo("该订单不存在，请重新报名!", "/Flight/flightgroom.aspx", false);
            return;
        }

        DateTime date1 = model.dConfirmTime ?? DateTime.Now;
        DateTime date2 = DateTime.Now;
        // todo: 时间初始化
        TimeSpan timeSpan = date2 - date1;
        double ts = Math.Floor(timeSpan.TotalMinutes);//取整数3.9=3;
        int mm = TypeChangeDefault.NullToInt(ts, 0);
        if (mm < 0 || mm > 20)
        {
            AlertHelper.JQAlertGo("该订单超时过期，请重新订票!", "/Flight/flightgroom.aspx", false);
            return;
        }
        ////1.验证登陆
        //string reLoginValue = reLogin();
        //Return_Login_Value login = JsonDeserialize<Return_Login_Value>(reLoginValue);
        //if (login.status != "0")
        //{
        //    AlertHelper.JQAlertGo(reLoginValue, "/Flight/Flight_Search.aspx", false);
        //    return;
        //}
        //string Sid = "";//查询令牌值
        //string ItemId = "";//请求该次 Search 结果集中航班编号

        //if (Sid.Trim().Length == 0 || ItemId.Trim().Length == 0)
        //{
        //    AlertHelper.JQAlertGo("请求超时请刷新重试!", "/Flight/Flight_Search.aspx", false);
        //    return;
        //}
        ////2.验证舱位
        //string rePriceValue = rePrice(login.token, Sid, ItemId);
        //Return_Price_Value Price = JsonDeserialize<Return_Price_Value>(rePriceValue);
        //if (Price.status != "0")
        //{
        //    AlertHelper.JQAlertGo(rePriceValue, "/Flight/Flight_Search.aspx", false);
        //    return;
        //}
        ////剩余票数string用strVotes.Substring(strVotes.Length-1, 1)
        //string strVotes = Price.items.RemainingSeats;
        //int votes = TypeChangeDefault.NullToInt(strVotes.Substring(strVotes.Length - 1, 1), 0);
        ////订票人数
        //int iBuyNum = 0;//userlist.Count;
        //if (iBuyNum > votes)
        //{
        //    AlertHelper.JQAlertGo("票数不足", "/Flight/Flight_Search.aspx", false);
        //    return;
        //}
       
        //string jsonOrder = JsonSerializer<Flight_Order>(order);
        //string AesOrder = AESHelper.Encrypt(jsonOrder, erunkey);
        //string returnOrderValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Order.aspx", AesOrder, Encoding.UTF8);
        ////解密 订单返回结果
        //string aes_re_Order_Value = AESHelper.Decrypt(returnOrderValue, erunkey);
        //Return_Order_Value re_order = JsonDeserialize<Return_Order_Value>(aes_re_Order_Value);    //将json数据转化为对象类型并赋值给list
        //if (re_order.status == "0")
        //{


        //}
        //else
        //{
        //    context.Response.Write(aes_re_Order_Value);
        //    return;
        //}
        if (wap == "0")
        {
            pc_pay(model, 18 - mm);
        }
    }
    //登陆验证(Token)接口
    private string reLogin()
    {
        Flight_User erunuser = new Flight_User();
        erunuser.userName = "erun360";
        erunuser.password = "erun_360_admin";
        erunuser.cdKey = erunkey;
        string jsonPerson = JsonSerializer<Flight_User>(erunuser);
        string re_login_Value = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Token.aspx", jsonPerson, Encoding.UTF8);
        return re_login_Value;
    }
    /// <summary>
    /// 舱位验证(Price)  接口说明
    /// </summary>
    /// <param name="sid">查询令牌值</param>
    /// <param name="id">航班编号</param>
    /// <returns></returns>
    private string rePrice(string token, string sid, string id)
    {
        Flight_Price price = new Flight_Price();
        price.token = token;
        price.Sid = sid;
        price.ItemId = id;
        string jsonPrice = JsonSerializer<Flight_Price>(price);
        string rtn_Price_Value = GetPage(@"http://cs.10lx.com:8081/OAFlight_Price.aspx", jsonPrice);
        //Return_Price_Value Price = JsonDeserialize<Return_Price_Value>(rtn_Price_Value);
        return rtn_Price_Value;
    }
    //求离最近发表时间的函数
    public string DateStringFromNow(DateTime dt)
    {
        TimeSpan
        span = DateTime.Now - dt;
        if (span.TotalDays > 60)
        {
            return
            dt.ToShortDateString();
        }
        else if (span.TotalDays > 30)
        {

            return "1个月前";
        }
        else if (span.TotalDays > 14)
        {
            return
            "2周前";
        }
        else if (span.TotalDays > 7)
        {
            return "1周前";
        }

        else if (span.TotalDays > 1)
        {
            return string.Format("{0}天前",
            (int)Math.Floor(span.TotalDays));
        }
        else if (span.TotalHours > 1)
        {
            return string.Format("{0}小时前", (int)Math.Floor(span.TotalHours));
        }
        else if (span.TotalMinutes > 1)
        {
            return string.Format("{0}分钟前", (int)Math.Floor(span.TotalMinutes));
        }
        else if (span.TotalSeconds >= 1)
        {
            return string.Format("{0}秒前",
            (int)Math.Floor(span.TotalSeconds));
        }

        else
        {
            return "1秒前";

        }
    }

    #region 序列化JSON序列化和反序列化辅助类
    /// <summary>
    /// JSON序列化
    /// </summary>
    public static string JsonSerializer<T>(T t)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream();
        ser.WriteObject(ms, t);
        string jsonString = Encoding.UTF8.GetString(ms.ToArray());
        ms.Close();
        return jsonString;
    }
    /// <summary>
    /// JSON反序列化
    /// </summary>
    public static T JsonDeserialize<T>(string jsonString)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
        T obj = (T)ser.ReadObject(ms);
        return obj;
    }
    #endregion
    private void pc_pay(DBM6.tblOrder model, int mm)
    {

        
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Pay.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("paylist/pay[id='Flight']");//查找
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
        //Items items = JsonDeserialize<Items>(model.cItems);
        //商户订单号
        string out_trade_no = model.cOrder_no;
        //商户网站订单系统中唯一订单号，必填
        //订单名称
        string subject =model.FlightDate+"--"+ model.cItemName + "--" + model.iItemID;
        //必填

        //付款金额
        string total_fee = model.iCost.ToString();
        //string total_fee = "0.01";
        //必填
        //订单描述
        string body = model.FlightDate + "--" + model.cItemName + "--" + model.iItemID;
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
        sParaTemp.Add("it_b_pay", mm + "m");//过期时间
        //建立请求
        string sHtmlText = Submit.BuildRequest(sParaTemp, "get", "确认");
        Response.Write(sHtmlText);
    }
    #region post 请求
    public string GetPage(string posturl, string postData)
    {
        Stream outstream = null;
        Stream instream = null;
        StreamReader sr = null;
        HttpWebResponse response = null;
        HttpWebRequest request = null;
        Encoding encoding = System.Text.Encoding.GetEncoding("utf-8");
        byte[] data = encoding.GetBytes(postData);
        // 准备请求...
        try
        {
            // 设置参数
            request = WebRequest.Create(posturl) as HttpWebRequest;
            CookieContainer cookieContainer = new CookieContainer();
            request.CookieContainer = cookieContainer;
            request.AllowAutoRedirect = true;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;
            outstream = request.GetRequestStream();
            outstream.Write(data, 0, data.Length);
            outstream.Close();
            //发送请求并获取相应回应数据
            response = request.GetResponse() as HttpWebResponse;
            //直到request.GetResponse()程序才开始向目标网页发送Post请求
            instream = response.GetResponseStream();
            sr = new StreamReader(instream, encoding);
            //返回结果网页（html）代码
            string content = sr.ReadToEnd();
            string err = string.Empty;
            return content;
        }
        catch (Exception ex)
        {
            string err = ex.Message;
            return string.Empty;
        }
    }
    private string PostWebRequest(string postUrl, string paramData, Encoding dataEncode)
    {

        string ret = string.Empty;
        System.Net.WebClient WebClientObj = new System.Net.WebClient();
        try
        {
            byte[] byteArray = dataEncode.GetBytes(paramData); //转化
            HttpWebRequest webReq = (HttpWebRequest)WebRequest.Create(new Uri(postUrl));
            webReq.Method = "POST";
            webReq.ContentType = "application/x-www-form-urlencoded";

            webReq.ContentLength = byteArray.Length;
            Stream newStream = webReq.GetRequestStream();
            newStream.Write(byteArray, 0, byteArray.Length);//写入参数
            newStream.Close();
            HttpWebResponse response = (HttpWebResponse)webReq.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream(), Encoding.Default);
            ret = sr.ReadToEnd();
            sr.Close();
            response.Close();
            newStream.Close();
        }
        catch (Exception ex)
        {
            return string.Empty;
        }
        return ret;
    }
    #endregion
}