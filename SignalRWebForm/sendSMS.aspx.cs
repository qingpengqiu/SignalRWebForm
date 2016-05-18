using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class sendSMS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtNum.Text = "13522968082";
            //txtNum.Text = "13522968082,13717811099,18511583497,13811209300";
            //txtcom.Text = "【商讯达】您的短信验证码是：9f973m，3分钟内有效";//"您的验证码是：" + GetCheckCode(6) + "，3分钟内有效。如非您本人操作，可忽略本消息。"; 
            txtcom.Text = "您的验证码是：" + SMS.GetCheckCode(6) + "，3分钟内有效，如非您本人操作，可忽略本消息。【益跑网】";
            //txtcom.Text = "尊敬的会员，11月30日比赛期间（7:30-13:45），北京城区天气以晴为主，风力不大，气温19～28℃，能见度大于10公里。请选手们做好防寒降温措施，赛时及时补充水分。理性参赛，量力而行。（退订回T）【益跑赛事】";
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string mobile = txtNum.Text.Trim();
        string con = txtcom.Text.Trim(); //"【微米】您的验证码是：610912，3分钟内有效。如非您本人操作，可忽略本消息。";
        //操作二：获得单个节点的值
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/SMS.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("sms/send[id='SendSms']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        string un = xmlNode["userid"].InnerText;
        string pwd = xmlNode["psd"].InnerText;
        string url = xmlNode["url"].InnerText;

        //lbstate.Text = SMS.HttpGet(url, "mobile=" + mobile + "&msg=" + HttpUtility.UrlEncode(con, Encoding.GetEncoding("GB2312")) + "&un=" + un + "&pwd=" + pwd);
        lbstate.Text = SMS.HttpPost(url, "mobile=" + mobile + "&msg=" + HttpUtility.UrlEncode(con, Encoding.GetEncoding("GB2312")) + "&un=" + un + "&pwd=" + pwd);
       
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string mobile = txtNum.Text.Trim();
        string con = txtcom.Text.Trim(); //"【微米】您的验证码是：610912，3分钟内有效。如非您本人操作，可忽略本消息。";
        string uid = "bjypw"; //"Lv1EE6UniscU";
        string pas = "b45c3f";//"pcrajp4c";
        //string url = "http://api.weimi.cc/2/sms/send.html";
        //string url = "http://si.800617.com:4400/SendSmsGroups.aspx?un=xxxx&pwd=xxxx&mobile=xxxxxxxxxxx,xxxxxxxxxxx,xxxxxxxxxxx,xxxxxxxxxxx&msg=xxxx";
        string url = "http://si.800617.com:4400/SendSmsGroups.aspx";
        //byte[] byteArray = Encoding.UTF8.GetBytes("mob=" + mobile + "&con=" + con + "&uid=" + uid + "&pas=" + pas + "&type=json");
        byte[] byteArray = Encoding.GetEncoding("GB2312").GetBytes("mobile=" + mobile + "&msg=" + con + "&un=" + uid + "&pwd=" + pas);
        HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(new Uri(url));
        webRequest.Method = "POST";
        webRequest.ContentType = "application/x-www-form-urlencoded";
        webRequest.ContentLength = byteArray.Length;
        Stream newStream = webRequest.GetRequestStream();
        newStream.Write(byteArray, 0, byteArray.Length);
        newStream.Close();
        HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
        StreamReader php = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("gb2312"));
        string Message = php.ReadToEnd();
        lbstate.Text = Message;
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string mobile = txtNum.Text.Trim();
        string con = txtcom.Text.Trim(); //"【微米】您的验证码是：610912，3分钟内有效。如非您本人操作，可忽略本消息。";
        string uid = "bjypw"; //"Lv1EE6UniscU";
        string pas = "b45c3f";//"pcrajp4c";
        //string url = "http://api.weimi.cc/2/sms/send.html";
        //string url = "http://si.800617.com:4400/SendLenSmsGroups.aspx?un=xxxx&pwd=xxxx&mobile=xxxxxxxxxxx,xxxxxxxxxxx,xxxxxxxxxxx,xxxxxxxxxxx&msg=xxxx";
        string url = "http://si.800617.com:4400/SendLenSmsGroups.aspx";
        //byte[] byteArray = Encoding.UTF8.GetBytes("mob=" + mobile + "&con=" + con + "&uid=" + uid + "&pas=" + pas + "&type=json");
        byte[] byteArray = Encoding.GetEncoding("GB2312").GetBytes("mobile=" + mobile + "&msg=" + con + "&un=" + uid + "&pwd=" + pas);
        HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(new Uri(url));
        webRequest.Method = "POST";
        webRequest.ContentType = "application/x-www-form-urlencoded";
        webRequest.ContentLength = byteArray.Length;
        Stream newStream = webRequest.GetRequestStream();
        newStream.Write(byteArray, 0, byteArray.Length);
        newStream.Close();
        HttpWebResponse response = (HttpWebResponse)webRequest.GetResponse();
        StreamReader php = new StreamReader(response.GetResponseStream(), Encoding.GetEncoding("gb2312"));
        string Message = php.ReadToEnd();
        lbstate.Text = Message;
    }
}