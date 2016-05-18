using Com.Alipay;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using System.Web.Script.Serialization;
using Erun360.Model.DB6;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using System.Net;
using System.Data;
public partial class Pay_Flight_notify_url : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SortedDictionary<string, string> sPara = GetRequestPost();
        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.Verify(sPara, Request.Form["notify_id"], Request.Form["sign"]);
            if (verifyResult)//验证成功
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码
                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表
                //商户订单号
                string out_trade_no = Request.Form["out_trade_no"];
                //支付宝交易号
                string trade_no = Request.Form["trade_no"];
                //交易状态
                string trade_status = Request.Form["trade_status"];
                if (Request.Form["trade_status"] == "TRADE_FINISHED")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序

                    //注意：
                    //该种交易状态只在两种情况下出现
                    //1、开通了普通即时到账，买家付款成功后。
                    //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
                    DB6.tblOrder bll = new DB6.tblOrder();
                    DataTable dt = bll.GetList("cOrder_no='" + out_trade_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        int ID = TypeChangeDefault.NullToInt(dt.Rows[0]["ID"].ToString().Trim(), 0);
                        DBM6.tblOrder model = bll.GetModel(ID);
                        if (model != null)
                        {
                            //Items items = JsonDeserialize<Items>(model.cItems);

                            int idUser = model.idUser ?? 0;
                            if (2 != model.iStatus)
                            {
                                model.dPayTime = DateTime.Now;
                                model.cTrade_no = trade_no;
                                model.iStatus = 2;
                                model.ID = ID;
                                if (bll.Update(model))
                                {
                                    try
                                    {
                                        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                        disModel.cContent = "您已成功购买了" + dt.Rows[0]["FlightDate"].ToString().Trim() + dt.Rows[0]["cItemName"].ToString().Trim() + "《" + dt.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                        disModel.idInfo = idUser;
                                        disModel.idUser = 100001183;
                                        disModel.cLoginname = "益跑赛事";
                                        // disModel.dCreate = DateTime.Now;
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

                                        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);
                                        if (user != null)
                                        {
                                            DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                            mActivity.idUser = user.id;
                                            mActivity.cNickName = user.cNickName;
                                            mActivity.cAvatar = user.cAvatar;
                                            mActivity.idBlog = imessage;
                                            mActivity.idGroup = "51";
                                            mActivity.cTitle = "成功订购" + dt.Rows[0]["FlightDate"].ToString().Trim() + dt.Rows[0]["cItemName"].ToString().Trim() + "的" + dt.Rows[0]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/Flight_Search.aspx\">[查看]</a>！";
                                            mActivity.cBio = "";
                                            mActivity.dCreate = DateTime.Now;
                                            new DB2.tblActivity().Add(mActivity);
                                        }
                                        Flight_User erunuser = new Flight_User();
                                        erunuser.userName = "erun360";
                                        erunuser.password = "erun_360_admin";
                                        erunuser.cdKey = "3nv40T4zChc=e360";
                                        string jsonPerson = JsonSerializer<Flight_User>(erunuser);
                                        string re_login_Value = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Token.aspx", jsonPerson, Encoding.UTF8);
                                        Return_Login_Value login = JsonDeserialize<Return_Login_Value>(re_login_Value);
                                        if (login.status == "0")
                                        {
                                            Flight_Pay pay = new Flight_Pay();
                                            pay.token = login.token;
                                            pay.oid = model.cOid;
                                            pay.info = model.cInfo;
                                            string jsonPay = JsonSerializer<Flight_Pay>(pay);
                                            string AesPay = AESHelper.Encrypt(jsonPay, "3nv40T4zChc=e360");
                                            string returnPayValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Pay.aspx", AesPay, Encoding.UTF8);
                                            string resultPay = AESHelper.Decrypt(returnPayValue, "3nv40T4zChc=e360");
                                            Return_Pay_Value re_pay = JsonDeserialize<Return_Pay_Value>(resultPay);
                                            if (re_pay.status == "0")
                                            {
                                                List<LinkMan> userlist = JsonDeserialize<List<LinkMan>>(model.passenger); //乘客信息集合json 格式   
                                                foreach (LinkMan p in userlist)
                                                {
                                                    tblFlight_Detail detail = new tblFlight_Detail();
                                                    detail.OrderId = model.cInfo;
                                                    detail.Segment = model.cItems;
                                                    detail.ContactPeople = model.cName;
                                                    detail.ContactPhoneNumber = model.cMobile;
                                                    detail.ContactAddress = model.cAddress;
                                                    detail.cOrder_no = model.cOrder_no;
                                                    detail.idUser = model.idUser;
                                                    detail.cNickName = model.cNickName;
                                                    detail.FlightDate = model.FlightDate;
                                                    detail.cname = p.Name;
                                                    detail.cPhone = p.Phone;
                                                    detail.IdType = p.IdType;
                                                    detail.IdNo = p.IdNo;
                                                    detail.cInsurance = TypeChangeDefault.NullToInt(p.Insurance, 0);
                                                    detail.dCreateTime = DateTime.Now;
                                                    new DB6.tblFlight_Detail().Add(detail);
                                                } 
                                            }
                                        }
                                    }
                                    catch (Exception ex)
                                    {

                                        //log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
                                    }
                                }
                            }
                        }
                    }
                }
                else if (Request.Form["trade_status"] == "TRADE_SUCCESS")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序

                    //注意：
                    //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
                    DB6.tblOrder bll = new DB6.tblOrder();
                    DataTable dt = bll.GetList("cOrder_no='" + out_trade_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        int ID = TypeChangeDefault.NullToInt(dt.Rows[0]["ID"].ToString().Trim(), 0);
                        DBM6.tblOrder model = bll.GetModel(ID);
                        if (model != null)
                        {
                            //Items items = JsonDeserialize<Items>(model.cItems);

                            int idUser = model.idUser ?? 0;
                            if (2 != model.iStatus)
                            {
                                model.dPayTime = DateTime.Now;
                                model.cTrade_no = trade_no;
                                model.iStatus = 2;
                                model.ID = ID;
                                if (bll.Update(model))
                                {
                                    try
                                    {
                                        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                        disModel.cContent = "您已成功购买了" + dt.Rows[0]["FlightDate"].ToString().Trim() + dt.Rows[0]["cItemName"].ToString().Trim() + "《" + dt.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                        disModel.idInfo = idUser;
                                        disModel.idUser = 100001183;
                                        disModel.cLoginname = "益跑赛事";
                                        // disModel.dCreate = DateTime.Now;
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

                                        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);
                                        if (user != null)
                                        {
                                            DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                            mActivity.idUser = user.id;
                                            mActivity.cNickName = user.cNickName;
                                            mActivity.cAvatar = user.cAvatar;
                                            mActivity.idBlog = imessage;
                                            mActivity.idGroup = "51";
                                            mActivity.cTitle = "成功订购" + dt.Rows[0]["cItemName"].ToString().Trim() + "的" + dt.Rows[0]["iItemID"].ToString().Trim() + "航班！<a target=\"_blank\" href=\"/Flight/Flight_Search.aspx\">[查看]</a>！";
                                            mActivity.cBio = "";
                                            mActivity.dCreate = DateTime.Now;
                                            new DB2.tblActivity().Add(mActivity);
                                        }
                                        Flight_User erunuser = new Flight_User();
                                        erunuser.userName = "erun360";
                                        erunuser.password = "erun_360_admin";
                                        erunuser.cdKey = "3nv40T4zChc=e360";
                                        string jsonPerson = JsonSerializer<Flight_User>(erunuser);
                                        string re_login_Value = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Token.aspx", jsonPerson, Encoding.UTF8);
                                        Return_Login_Value login = JsonDeserialize<Return_Login_Value>(re_login_Value);
                                        if (login.status == "0")
                                        {
                                            Flight_Pay pay = new Flight_Pay();
                                            pay.token = login.token;
                                            pay.oid = model.cOid;
                                            pay.info = model.cInfo;
                                            string jsonPay = JsonSerializer<Flight_Pay>(pay);
                                            string AesPay = AESHelper.Encrypt(jsonPay, "3nv40T4zChc=e360");
                                            string returnPayValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Pay.aspx", AesPay, Encoding.UTF8);
                                            string resultPay = AESHelper.Decrypt(returnPayValue, "3nv40T4zChc=e360");
                                            Return_Pay_Value re_pay = JsonDeserialize<Return_Pay_Value>(resultPay);
                                            if (re_pay.status == "0")
                                            {
                                                List<LinkMan> userlist = JsonDeserialize<List<LinkMan>>(model.passenger); //乘客信息集合json 格式   
                                                foreach (LinkMan p in userlist)
                                                {
                                                    tblFlight_Detail detail = new tblFlight_Detail();
                                                    detail.OrderId = model.cInfo;
                                                    detail.Segment = model.cItems;
                                                    detail.ContactPeople = model.cName;
                                                    detail.ContactPhoneNumber = model.cMobile;
                                                    detail.ContactAddress = model.cAddress;
                                                    detail.cOrder_no = model.cOrder_no;
                                                    detail.idUser = model.idUser;
                                                    detail.cNickName = model.cNickName;
                                                    detail.FlightDate = model.FlightDate;
                                                    detail.cname = p.Name;
                                                    detail.cPhone = p.Phone;
                                                    detail.IdType = p.IdType;
                                                    detail.IdNo = p.IdNo;
                                                    detail.cInsurance = TypeChangeDefault.NullToInt(p.Insurance, 0);
                                                    detail.dCreateTime = DateTime.Now;
                                                    new DB6.tblFlight_Detail().Add(detail);
                                                } 

                                            }
                                        }
                                    }
                                    catch (Exception ex)
                                    {

                                        //log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {

                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                Response.Write("success");  //请不要修改或删除

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                Response.Write("fail");
            }
        }
        else
        {
            Response.Write("无通知参数");
        }
    }

    /// <summary>
    /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public SortedDictionary<string, string> GetRequestPost()
    {
        int i = 0;
        SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.Form;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], Request.Form[requestItem[i]]);
        }

        return sArray;
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
}