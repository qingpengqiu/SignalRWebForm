<%@ WebHandler Language="C#" Class="Flight" %>

using System;
using System.Web;
using System.Web.SessionState;
using Erun360.Model.DB6;
using System.IO;
using System.Text;
using System.Runtime.Serialization.Json;
using Erun360.Common;
using System.Net;
using System.Collections.Generic;
using Erun360.Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Collections;
using System.Collections.Specialized;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DB1 = Erun360.BLL.DB1;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
public class Flight : IHttpHandler, IReadOnlySessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        if (context.Request["op"] != null)
        {
            string command = context.Request["op"].ToString();
            System.Reflection.MethodInfo method = this.GetType().GetMethod(command);
            if (method != null)
            {
                method.Invoke(this, new object[] { context });
            }
        }
    }
    private string erunkey = "3nv40T4zChc=e360";//
    private double percentum = 0;//价格百分比erun360_admin360
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
    //查询航班(Search)接口
    public void search(HttpContext context)
    {
        string result = string.Empty;
        string depCity = TypeChangeDefault.NullToString(context.Request["begin"], "PEK");//出发城市
        string arrCity = TypeChangeDefault.NullToString(context.Request["end"], "SHA");//到达城市
        string time = TypeChangeDefault.NullToDateTime(context.Request["time"], DateTime.Now.AddDays(4)).ToString("yyyy-MM-dd");//出发时间 
        string order = TypeChangeDefault.NullToString(context.Request["order"], "jg");//排序方式有2种，sj时间，jg价格
        string CacheKey = depCity + arrCity + time;
        object objModel = Erun360.Common.DataCache.GetCache(CacheKey);
        if (objModel == null)
        {
            //1.验证登陆
            string reLoginValue = reLogin();
            if (reLoginValue.Trim().Length == 0)
            {
                context.Response.Write("{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}");
                return;
            }
            Return_Login_Value login = JsonDeserialize<Return_Login_Value>(reLoginValue);
            if (login.status != "0")
            {
                context.Response.Write(reLoginValue);
                return;
            }
            Flight_Search secrch = new Flight_Search();
            secrch.token = login.token;
            secrch.depCity = depCity.ToUpper();
            secrch.arrCity = arrCity.ToUpper();
            secrch.depDate = time;
            string json_Search_where = JsonSerializer<Flight_Search>(secrch);
            string re_earch_Value = GetPage(@"http://cs.10lx.com:8081/OAFlight_Search.aspx", json_Search_where);
            Return_Search_Value secrch_msg = JsonDeserialize<Return_Search_Value>(re_earch_Value);
            //处理返回数据失败的问题60.26.244.153  
            if (secrch_msg.status != "0")
            {
                context.Response.Write(re_earch_Value);
                return;
            }
            objModel = re_earch_Value;
            if (objModel != null)
            {
                Erun360.Common.DataCache.SetCache(CacheKey, objModel, DateTime.Now.AddMinutes(2), TimeSpan.Zero);
            }
        }
        Return_Search_Value secrch_data = JsonConvert.DeserializeObject<Return_Search_Value>((string)objModel);
        List<Hashtable> flightInfoList = new List<Hashtable>();
        List<Items> itemsdetail = secrch_data.items;
        List<flight_Item> items = new List<flight_Item>();
        foreach (Items item in itemsdetail)
        {
            flight_Item flightinfo = new flight_Item();
            flightinfo.Id = item.Id;
            string[] hb = item.Airline.Split('|');
            //航班信息（航空公司+编号） 南方航空CZ3152
            flightinfo.Airline_No = hb[1].ToString();
            flightinfo.Airline_Name = hb[0].ToString() + item.FlightNo;
            //起降时间
            flightinfo.from_Time = item.D_Time;
            flightinfo.to_Time = item.A_Time;
            //起降机场(机场+航站楼) 首都机场T2
            flightinfo.from_Airport = item.D_City.Split('|')[0] + item.PortD;
            flightinfo.to_Airport = item.A_City.Split('|')[0] + item.PortA;
            flightinfo.HippingSpace = item.HippingSpace;
            flightinfo.AircraftType = item.AircraftType;
            flightinfo.Discount = item.Discount;//折扣
            flightinfo.RemainingSeats = item.RemainingSeats;//余票
            double cost = TypeChangeDefault.NullToDouble(item.Price, 0);//SettlementPrice//机票价格待定
            flightinfo.Price = TypeChangeDefault.NullToInt(Math.Ceiling(cost * percentum), 0) + (int)cost;
            items.Add(flightinfo);
        }
        ////利用匿名委托方式对list排序  
        items.Sort(delegate(flight_Item x, flight_Item y)
        {
            if (order == "sj")
                return x.from_Time.CompareTo(y.from_Time);
            else
                return x.Price.CompareTo(y.Price);
        });
        //序列化
        Hashtable flight = new Hashtable();
        flight.Add("status", secrch_data.status);
        flight.Add("msg", secrch_data.msg);
        flight.Add("Sid", secrch_data.Sid);
        flight.Add("items", items);//航空列表
        if (context.Session["CurrentUser"] == null)
        {
            flight.Add("login", 0);//航空列表
        }
        else
        {
            flight.Add("login", 1);//航空列表
        }
        flightInfoList.Add(flight);
        context.Response.Write(JsonConvert.SerializeObject(flightInfoList));
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

    //下单(Order)接口0成功，1用户未登录，2乘客数据信息不符合要求，3请求超时请刷新重试 ，4票数不足5
    public void order(HttpContext context)
    {
        string result = string.Empty;
        int DBXF = 20;//单个保险费用（元）
        int KDF = 2;//快递费 （统一费用2元）
        int oldid = TypeChangeDefault.NullToInt(context.Request["oldid"], 0);
        //积分抵扣默认积分抵扣0元 
        string JF = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["iScore"]), "");
        int iScore = TypeChangeDefault.NullToInt(context.Request["jf"], 500);//积分 0代表不使用积分，其他表示使用积分并表示使用的积分数
        int iMoney = TypeChangeDefault.NullToInt(context.Request["jg"], 5);//积分抵扣钱数       
        string cName = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["contactName"]), "");//联系人
        //string IdType = TypeChangeDefault.NullToString(context.Request["lx"], "IN");//证件类型
        //string IdNo = TypeChangeDefault.NullToString(context.Request["hm"], "");//证件号码
        string cMobile = TypeChangeDefault.NullToString(context.Request["contactTel"], "");//联系人电话 注: 座机如 01084413210
        //int idCity = TypeChangeDefault.NullToInt(context.Request["cid"], 0);//城市id
        //string cCityname = TypeChangeDefault.NullToString(context.Request["cnm"], "");//城市名称
        string cAddress = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["contactAdd"]), "");//联系人地址
        string cMail = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["email"]), "");//邮箱
        string remark = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["remark"]), "");//备注
        string Receipt = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["trip"]), "");//快递行程单（到付） 0不发快递，1发快递
        if (context.Session["CurrentUser"] == null)
        {
            result = "{\"msg\":\"您未登录，请登录\",\"status\":\"1\"}";
            context.Response.Write(result);
            return;
        }
        int bxNum = 0;//购买保险人数
        UserInfoModel CurrentUser = context.Session["CurrentUser"] as UserInfoModel;
        List<LinkMan> userlist = new List<LinkMan>();
        int numcoun = 0;
        LinkMan user = null;
        for (int i = 1; i <= 4; i++)
        {
            string firstname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["firstname" + i]), "");
            string lastname = TypeChangeDefault.NullToString(HttpUtility.UrlDecode(context.Request["lastname" + i]), "");
            string IdType = TypeChangeDefault.NullToString(context.Request["catdtype" + i], "");
            string IdNo = TypeChangeDefault.NullToString(context.Request["cardnum" + i], "");
            string Phone = TypeChangeDefault.NullToString(context.Request["iph" + i], "");
            string BX = TypeChangeDefault.NullToString(context.Request["bx" + i], "");
            if (numcoun != 0)
            {
                if (firstname.Trim().Length == 0 || lastname.Trim().Length == 0 || IdType.Trim().Length == 0 || IdNo.Trim().Length == 0)
                {
                    break;
                }
            }
            if (firstname.Trim().Length == 0 || lastname.Trim().Length == 0 || IdType.Trim().Length == 0 || IdNo.Trim().Length == 0)
            {
                result = "{\"msg\":\"乘客数据信息不符合要求\",\"status\":\"2\"}";
                context.Response.Write(result);
                return;
            }
            string name = string.Empty;
            if (IsChinese(firstname) && IsChinese(lastname))
            {
                name = firstname + lastname;
            }
            else if (IsEnglish(firstname) && IsEnglish(lastname))
            {
                name = firstname + "/" + lastname;
            }
            else
            {
                name = firstname + lastname;
                //result = "{\"msg\":\"乘客数据信息不符合要求\",\"status\":\"2\"}";
                //context.Response.Write(result);
                //return;
            }
            if (IdType == "IN")
            {
                if (!CheckIDCard18(IdNo))
                {
                    result = "{\"msg\":\"身份证验证失败\",\"status\":\"2\"}";
                    context.Response.Write(result);
                    return;
                }
            }
            user = new LinkMan();
            user.Name = name;
            user.IdType = IdType;
            user.IdNo = IdNo;
            user.Phone = Phone;
            if (BX == "on")
            {
                bxNum++;
            }
            user.Insurance = BX == "on" ? "1" : "0";
            userlist.Add(user);
            numcoun++;
            int puser = new DB6.tblPassenger().GetRecordCount("idUser=" + CurrentUser.uId + " and IdNo='" + IdNo + "'");

            if (puser == 0)
            {
                tblPassenger m_user = new tblPassenger();
                m_user.csurname = firstname;
                m_user.cname = lastname;
                m_user.cFullname = firstname + lastname;
                m_user.IdType = IdType;
                m_user.IdNo = IdNo;
                m_user.Phone = Phone;
                m_user.idUser = CurrentUser.uId;

                new DB6.tblPassenger().Add(m_user);
            }
        }
        string passenger = JsonSerializer(userlist); //乘客信息集合json 格式   
        //1.验证登陆
        string reLoginValue = reLogin();
        Return_Login_Value login = JsonDeserialize<Return_Login_Value>(reLoginValue);
        if (login.status != "0")
        {
            context.Response.Write(reLoginValue);
            return;
        }
        string Sid = TypeChangeDefault.NullToString(context.Request["Sid"], "");//查询令牌值
        string ItemId = TypeChangeDefault.NullToString(context.Request["ItemId"], "");//请求该次 Search 结果集中航班编号

        if (Sid.Trim().Length == 0 || ItemId.Trim().Length == 0)
        {
            result = "{\"msg\":\"请求超时请刷新重试 \",\"status\":\"3\"}";
            context.Response.Write(result);
            return;
        }
        //2.验证舱位
        string rePriceValue = rePrice(login.token, Sid, ItemId);
        Return_Price_Value Price = JsonDeserialize<Return_Price_Value>(rePriceValue);
        if (Price.status != "0")
        {
            context.Response.Write(rePriceValue);
            return;
        }
        //剩余票数string用strVotes.Substring(strVotes.Length-1, 1)
        string strVotes = Price.items.RemainingSeats;
        int votes = TypeChangeDefault.NullToInt(strVotes.Substring(strVotes.Length - 1, 1), 0);
        //订票人数
        int iBuyNum = userlist.Count;
        if (iBuyNum > votes)
        {
            result = "{\"msg\":\"票数不足\",\"status\":\"4\"}";
            context.Response.Write(result);
            return;
        }

        double cost = TypeChangeDefault.NullToDouble(Price.items.TicketPrice, 0);//机票价格+基建+燃油
        decimal fPrice = TypeChangeDefault.NullToInt(Math.Ceiling(cost * percentum), 0) + (int)cost;//成交价格（不包括积分兑换的钱数）

        fPrice = fPrice * iBuyNum;//实际支付价钱
        fPrice = fPrice + DBXF * bxNum;//每个人的保险费用

        if (Receipt == "on")
        {
            fPrice = fPrice + KDF;//快递行程单的钱数
        }
        decimal iCost = fPrice;//实际支付价钱，提交到支付宝的钱数       
        if (JF == "on")
        {
            //总积分
            int TotalScore = new DB1.tblMEMBER_HISTORY().GetScore("idUser =" + CurrentUser.uId, CurrentUser.uId);
            if (iScore > TotalScore)
            {
                result = "{\"msg\":\"积分不足\",\"status\":\"5\"}";
                context.Response.Write(result);
                return;
            }
            if (iScore > 0)
            {
                iCost = fPrice - iMoney;//实际支付价钱（减去积分抵扣钱数），提交到支付宝的钱数
            }
        }
        else
        {
            iScore = 0;
            iMoney = 0;
        }

        tblOrder model = new tblOrder();
        model.cFromToID = 1;//来源编码
        model.cFromToName = "益跑网";//来源名称        
        model.idUser = CurrentUser.uId;
        model.cNickName = CurrentUser.cNickName;//
        model.iFromTpye = 3;//来源类型（比如，交通，旅游，装备）
        model.iTypeID = 3001;//3001国内直达航班 //例如赛事编号
        model.iTypeName = "国内直达航班";// 例如赛事名称
        model.iItemID = Price.items.FlightNo;//例如赛事赛事项目编号
        model.cItemName = Price.items.D_City + "-" + Price.items.D_Time + "-" + Price.items.A_City + "-" + Price.items.A_Time;//例如赛事赛事项目名称
        model.iBuyNum = userlist.Count;//购买数量/订票人数

        model.iScore = iScore;
        model.iMoney = iMoney;
        model.fPrice = fPrice;
        model.iCost = iCost;
        model.cName = cName;
        //model.IdType = IdType;
        //model.IdNo = IdNo;
        model.cMobile = cMobile;
        //model.idCity = idCity;
        //model.cCityname = cCityname;
        model.cAddress = cAddress;
        model.cMail = cMail;
        model.passenger = passenger;
        model.cMake = remark;
        model.cItems = JsonSerializer(Price.items);

        model.iStatus = 1;//订单状态 未支付
        model.iReceipt = Receipt == "on" ? 1 : 0;
        model.FlightDate = Price.items.FlightDate;
        model.dConfirmTime = DateTime.Now;
        //提交订单成功
        Flight_Order order = new Flight_Order();
        order.token = login.token;
        order.Pid = Price.Pid;//根据令牌和航班号返回
        order.ItemId = ItemId;
        order.Passenger = userlist;
        order.IsSMS = false;
        order.contactName = cName;
        order.contactAdd = cAddress;
        order.contactTel = cMobile;
        order.remark = remark;
        //string erunkey = "3nv40T4zChc=e360";//
        string jsonOrder = JsonSerializer<Flight_Order>(order);
        string AesOrder = AESHelper.Encrypt(jsonOrder, erunkey);
        string returnOrderValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Order.aspx", AesOrder, Encoding.UTF8);
        //解密 订单返回结果
        string aes_re_Order_Value = AESHelper.Decrypt(returnOrderValue, erunkey);
        Return_Order_Value re_order = JsonDeserialize<Return_Order_Value>(aes_re_Order_Value);    //将json数据转化为对象类型并赋值给list
        if (re_order.status == "0")
        {

            model.dCreateTime = DateTime.Now;
            if (oldid == 0)
            {
                string orderid = new DB6.tblOrder().GetMaxOrderId("JP");
                if (orderid == "")
                {
                    orderid = "JP" + DateTime.Now.ToString("yyyyMMdd") + "000001";
                }
                else
                {
                    orderid = "JP" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
                }
                model.cOrder_no = orderid;
                model.cOid = re_order.Oid;
                model.cInfo = re_order.info;
                model.iCount = 0;
                int iNum = new DB6.tblOrder().Add(model);
                if (iNum > 0)
                {
                    //序列化
                    Hashtable order_ok = new Hashtable();
                    order_ok.Add("status", re_order.status);
                    order_ok.Add("msg", re_order.msg);
                    double re_cost = TypeChangeDefault.NullToDouble(Price.items.Price, 0);
                    decimal re_fPrice = TypeChangeDefault.NullToInt(Math.Ceiling(re_cost * percentum), 0) + (int)re_cost;
                    order_ok.Add("Price", re_fPrice);
                    order_ok.Add("AirportConstruction_FuelTax", Price.items.AirportConstruction_FuelTax);//航空列表
                    order_ok.Add("bx", DBXF * bxNum);//保险价格 TotalPrice
                    order_ok.Add("TotalPrice", iCost);
                    if (JF == "on")//扣积分
                    {
                        new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840004, 4, iScore, "机票" + orderid);
                        order_ok.Add("iScore", iScore + "积分抵扣" + iMoney + "元");
                    }
                    else
                        order_ok.Add("iScore", "");
                    if (Receipt == "on")//快递行程单
                    {
                        order_ok.Add("kdf", "快递行程单:（到付,手续费" + KDF + "元）");//快递行程单
                    }
                    else
                    { order_ok.Add("kdf", ""); }
                    order_ok.Add("orderid", orderid);
                    order_ok.Add("ID", iNum);
                    order_ok.Add("Sid", Sid);
                    order_ok.Add("ItemId", ItemId);
                    order_ok.Add("iCount", model.iCount);
                    context.Response.Write(JsonConvert.SerializeObject(order_ok));
                }
            }
            else
            {
                //下单(Order)接口0成功，1用户未登录，2乘客数据信息不符合要求，3请求超时请刷新重试 ，4票数不足,5积分不足,6无权修改订单,7修改订单次数超过限制
                tblOrder upmodel = new DB6.tblOrder().GetModel(oldid);
                if (upmodel == null)
                {
                    result = "{\"msg\":\"无权修改订单\",\"status\":\"6\"}";
                    context.Response.Write(result);
                    return;
                }
                if (CurrentUser.uId != upmodel.idUser)
                {
                    result = "{\"msg\":\"无权修改订单\",\"status\":\"6\"}";
                    context.Response.Write(result);
                    return;
                }

                if (upmodel.iStatus != 1)
                {
                    result = "{\"msg\":\"无权修改订单\",\"status\":\"6\"}";
                    context.Response.Write(result);
                    return;
                }
                if (upmodel.iCount >= 2)
                {
                    result = "{\"msg\":\"修改订单次数超过限制\",\"status\":\"7\"}";
                    context.Response.Write(result);
                    return;
                }
                model.cOid = re_order.Oid;
                model.cInfo = re_order.info;
                model.iCount = upmodel.iCount + 1;
                model.ID = oldid;
                new DB6.tblOrder().Update(model);
                //序列化
                Hashtable order_ok = new Hashtable();
                order_ok.Add("status", re_order.status);
                order_ok.Add("msg", re_order.msg);
                double re_cost = TypeChangeDefault.NullToDouble(Price.items.Price, 0);
                decimal re_fPrice = TypeChangeDefault.NullToInt(Math.Ceiling(re_cost * percentum), 0) + (int)re_cost;
                order_ok.Add("Price", re_fPrice);
                order_ok.Add("AirportConstruction_FuelTax", Price.items.AirportConstruction_FuelTax);//航空列表
                order_ok.Add("bx", DBXF);//保险价格 TotalPrice
                order_ok.Add("TotalPrice", iCost);
                if (JF == "on")//扣积分
                {
                    new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200840004, 4, iScore, "机票" + upmodel.cOrder_no);
                    order_ok.Add("iScore", iScore + "积分抵扣" + iMoney + "元");
                }
                else
                    order_ok.Add("iScore", "");
                if (Receipt == "on")//快递行程单
                {
                    order_ok.Add("kdf", "快递行程单:（到付,手续费" + KDF + "元）");//快递行程单
                }
                else
                { order_ok.Add("kdf", ""); }
                order_ok.Add("orderid", upmodel.cOrder_no);
                order_ok.Add("ID", oldid);
                order_ok.Add("Sid", Sid);
                order_ok.Add("ItemId", ItemId);
                order_ok.Add("iCount", model.iCount);
                context.Response.Write(JsonConvert.SerializeObject(order_ok));
            }

        }
        else
        {
            context.Response.Write(aes_re_Order_Value);
            return;
        }

    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    //判断是否为汉字
    public bool IsChinese(string CString)
    {
        return System.Text.RegularExpressions.Regex.IsMatch(CString, @"^[\u4e00-\u9fa5]+$");
    }
    /// <summary>
    /// 验证字符串是否是中文。
    /// </summary>
    /// <param name="checkedStr">需验证的字符串。</param>
    /// <param name="allMatch">是否完全匹配。当值为true时，全部是中文；当值为false时，仅含有中文。</param>
    /// <returns></returns>
    public static bool IsChinese(string checkedStr, bool allMatch)
    {
        string pattern;
        if (allMatch)
            pattern = @"^[\u4e00-\u9fa5]+$";
        else
            pattern = @"[\u4e00-\u9fa5]";
        if (Regex.IsMatch(checkedStr, pattern))
            return true;
        else
            return false;
    }
    /// <summary> 
    /// 如果输入的不是英文字母或者数字或者汉字，则返回false (@"^[\u4E00-\u9FFFA-Za-z0-9]+$");
    /// </summary> 
    /// <returns></returns> 
    private static bool IsEnglish(string input)
    {
        Regex regex = new Regex(@"^[A-Za-z]+$");
        return regex.IsMatch(input);
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
    /// <summary>
    /// 18位身份证验证
    /// </summary>
    /// <param name="Id">身份证号</param>
    /// <returns></returns>
    protected bool CheckIDCard18(string Id)
    {
        long n = 0;
        if (long.TryParse(Id.Remove(17), out n) == false || n < Math.Pow(10, 16) || long.TryParse(Id.Replace('x', '0').Replace('X', '0'), out n) == false)
        {
            return false;//数字验证
        }
        string address = "11x22x35x44x53x12x23x36x45x54x13x31x37x46x61x14x32x41x50x62x15x33x42x51x63x21x34x43x52x64x65x71x81x82x91";
        if (address.IndexOf(Id.Remove(2)) == -1)
        {
            return false;//省份验证
        }
        string birth = Id.Substring(6, 8).Insert(6, "-").Insert(4, "-");
        DateTime time = new DateTime();
        if (DateTime.TryParse(birth, out time) == false)
        {
            return false;//生日验证
        }
        string[] arrVarifyCode = ("1,0,x,9,8,7,6,5,4,3,2").Split(',');
        string[] Wi = ("7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2").Split(',');
        char[] Ai = Id.Remove(17).ToCharArray();
        int sum = 0;
        for (int i = 0; i < 17; i++)
        {
            sum += int.Parse(Wi[i]) * int.Parse(Ai[i].ToString());
        }
        int y = -1;
        Math.DivRem(sum, 11, out y);
        if (arrVarifyCode[y] != Id.Substring(17, 1).ToLower())
        {
            return false;//校验码验证
        }
        return true;//符合GB11643-1999标准
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
}