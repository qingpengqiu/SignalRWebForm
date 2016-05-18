using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using Utils;
using System.Net;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;
using Erun360.Model.DB6;
public partial class Flight_Orderdetail : PageBase
{
    string keys = "3nv40T4zChc=e360";//
    public string outhtml = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        int ID = TypeChangeDefault.NullToInt(Request["id"], 0);
        DBM6.tblOrder model = new DB6.tblOrder().GetModel(ID);
        if (model == null)
        {
            AlertHelper.JQAlertGo("提交错误!", "/infocenter/Rlist.aspx?uId=0&tablep=3", false);
            return;
        }
        if (model.idUser != CurrentUser.uId)
        {
            AlertHelper.JQAlertGo("访问受限!", "/infocenter/Rlist.aspx?uId=0&tablep=3", false);
            return;
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
            #region 订单详细(Detail)接口
            string resultdetail = "{\"token\":\"" + login.token + "\",\"info\":\""+model.cInfo+"\"}";

            //string jsonPay = JsonHelper.JsonSerializer<Pay>(pay);
            string Aesdetail = AESHelper.Encrypt(resultdetail, keys);
            string returnDetailValue = PostWebRequest(@"http://cs.10lx.com:8081/OAFlight_Detail.aspx", Aesdetail, Encoding.UTF8);
            string resultDetail = AESHelper.Decrypt(returnDetailValue, keys);
            Return_Pay_Value Order_Detail = JsonDeserialize<Return_Pay_Value>(resultDetail);
            if (Order_Detail.status == "0")
            {
                ltlstatus.Text = Order_Detail.OrderStatus;
                ltlorder.Text = model.cOrder_no;
                ltltime.Text = model.dConfirmTime.ToString();
                ltlcost.Text = model.iCost.ToString();
                ltlpnr.Text = Order_Detail.Pnr;
                ltloldPnr.Text = Order_Detail.OldPnr;
                Items items = JsonDeserialize<Items>(model.cItems);
                ltlhk.Text = "<div class=\"fddt\"><i>" + model.FlightDate + "</i>" + items.D_City + " → " + items.A_City + "</div>";
                ltlhk.Text += "<div class=\"fdxl\"><i>" + items.Airline.Split('|')[0] + items.FlightNo + "</i><em>" + items.D_Time + "</em>" + items.D_City + items.PortD + "<br><i>"+items.AircraftType+"</i><em>" + items.A_Time + "</em>" + items.A_City + items.PortA + "<img src=\"/Html/images/small/" + items.Airline.Split('|')[1] + ".gif\"></div>";

                List<Order_LinkMan> Order_userlist = Order_Detail.passenger;//乘客信息集合json 格式   
                foreach (Order_LinkMan p in Order_userlist)
                {
                    ltlck.Text += "<div class=\"ckinfo\"><i>姓名：" + p.Name + "</i><em>" + IdNoName(p.CredentialsType) + "：" + p.CredentialsNumber + "</em>手机号：" + p.Phone + "票号:" + p.TicketNumber + "<br></div>";
                }
                List<LinkMan> userlist = JsonDeserialize<List<LinkMan>>(model.passenger); //乘客信息集合json 格式   
                foreach (LinkMan p in userlist)
                {
                    //缺少判断单个用户是否购买保险
                    if (p.Insurance == "1")
                        ltlbx.Text += "<div class=\"bxinfo\">被保人：" + p.Name + "&nbsp;&nbsp;</div>";
                }
                if (1 == model.iReceipt)
                {
                    ltlxcd.Text += "行程单（到付）";
                }
                ltllxr.Text += "<div class=\"xcdinfo\">姓名：" + model.cName + "&nbsp;&nbsp;手机号码：" + model.cMobile + "&nbsp;&nbsp;联系地址：" + model.cAddress + "&nbsp;&nbsp;备注：" + model.cMake + "</div>";
            }
            else
            {
                AlertHelper.JQAlertGo("查看失败,请重试!", "/infocenter/Rlist.aspx?uId=0&tablep=3", false);
                return;
            }

            //outhtml = resultDetail;
            //Response.Write(resultDetail);
            #endregion
        }
        else
        {
            AlertHelper.JQAlertGo("查看失败,请重试!", "/infocenter/Rlist.aspx?uId=0&tablep=3", false);
            return;
        }
    }
    private string IdNoName(string IdType)
    {
        string IdTypeName = string.Empty;
        switch (IdType)
        {
            case "PP": IdTypeName = "护照"; break;
            case "GA": IdTypeName = "港澳通行证"; break;
            case "TW": IdTypeName = "台湾通行证"; break;
            case "TB": IdTypeName = "台胞证"; break;
            case "HX": IdTypeName = "回乡证"; break;
            case "HY": IdTypeName = "国际海员证"; break;
            case "IN": IdTypeName = "身份证"; break;           
            default:
                break;
        }
        return IdTypeName;
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