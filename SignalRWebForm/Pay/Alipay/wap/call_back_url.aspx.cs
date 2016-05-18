using Com.Alipay.Wap;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM4 = Erun360.Model.DB4;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
/// <summary>
/// 功能：页面跳转同步通知页面
/// 版本：3.3
/// 日期：2012-07-10
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// ///////////////////////页面功能说明///////////////////////
/// 该页面可在本机电脑测试
/// 可放入HTML等美化页面的代码、商户业务逻辑程序代码
/// 该页面可以使用ASP.NET开发工具调试，也可以使用写文本函数LogResult进行调试
/// </summary>
public partial class Pay_Alipay_wap_call_back_url : System.Web.UI.Page
{
    Erun360.Common.ErrorLogFile log = new Erun360.Common.ErrorLogFile();
    DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
    DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
    public string cTitle = "";
    public string cType = "";
    public string iCost = "";
    public string idAlipay = "";
    public string stringresult = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Dictionary<string, string> sPara = GetRequestGet();

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.VerifyReturn(sPara, Request.QueryString["sign"]);

            if (verifyResult)//验证成功
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码
                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表
                //商户订单号
                string out_trade_no = Request.QueryString["out_trade_no"];
                //支付宝交易号
                string trade_no = Request.QueryString["trade_no"];
                //交易状态
                string result = Request.QueryString["result"];
                if ("success" == result.ToLower())
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    DataSet ds = bllsales.GetList(" idorder='" + out_trade_no + "'");
                    cTitle = ds.Tables[0].Rows[0]["cTitle"].ToString().Trim();
                    cType = ds.Tables[0].Rows[0]["cType"].ToString().Trim();
                    iCost = ds.Tables[0].Rows[0]["iCost"].ToString().Trim();
                    idAlipay = ds.Tables[0].Rows[0]["idAlipay"].ToString().Trim();
                    int idSignUp = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idSignUp"].ToString().Trim(), 0);
                    if (ds.Tables[0].Rows[0]["idAlipay"].ToString().Trim() == "")
                    {
                        modelsales.idAlipay = trade_no;
                        modelsales.iState = 2;
                        modelsales.dPay = DateTime.Now;
                        modelsales.id = Convert.ToInt32(ds.Tables[0].Rows[0]["id"].ToString().Trim());
                        if (bllsales.Update(modelsales))
                        {
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《" + cTitle + "》中付款成功！请您持续关注，谢谢！";
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
                                int uId = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString(), 0);//团队id
                                int idRace = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idSignUp"].ToString(), 0);//团队id
                                DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idRace);
                                DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(uId);
                                if (model != null && mSign != null)
                                {
                                    DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                    mActivity.idUser = model.id;
                                    mActivity.cNickName = model.cNickName;
                                    mActivity.cAvatar = model.cAvatar;
                                    mActivity.idBlog = imessage;
                                    mActivity.idGroup = "44";
                                    mActivity.cTitle = "在《<a target=\"_blank\" href=\"/blog/" + mSign.idBlog + ".aspx\">" + mSign.cTitle + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Channels/Competetion/RaceProject.aspx?idcompete=" + mSign.idCompete + "\">[参加]</a>！";
                                    mActivity.cBio = "";
                                    mActivity.dCreate = DateTime.Now;
                                    new DB2.tblActivity().Add(mActivity);

                                    //更新附属产品状态                            
                                    new DB4.tblAnnexLog().UpdatePayState(TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0), idSignUp, 2);
                                    //报名赛事最低送10积分
                                    if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "0")
                                    {
                                        if (492 != idRace)
                                        {
                                            new DB1.tblIntegral().InsertScore(TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0), 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                        }
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
                            }
                        }
                        stringresult = "支付成功";
                    }
                    else
                    {
                        stringresult = "支付成功";
                        DBM4.tblRACE_SIGNUP mSign = new DB4.tblRACE_SIGNUP().GetModel(idSignUp);
                        if (mSign != null)
                        {
                            if (mSign.iType == 3)
                            {
                                ltlgoteam.Text = "<a href=\"/Channels/Competetion/Team.aspx?id=" + mSign.idCompete + "&p=" + idSignUp + "\" class=\"goteam\" target=\"_blank\">加入团队</a>";
                            }
                        }
                    }
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序
                }
                else
                {
                    stringresult = "支付失败";
                    log.SaveLogInfo(Request.ToString(), "报名失败");
                }
                //打印页面
                //Response.Write("验证成功<br />");
                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                //Response.Write("验证失败");
                stringresult = "验证失败";
                log.SaveLogInfo(Request.ToString(), "wap验证失败");
            }
        }
        else
        {
            stringresult = "无返回参数";
            log.SaveLogInfo(Request.ToString(), "无返回参数");
        }
    }

    /// <summary>
    /// 获取支付宝GET过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public Dictionary<string, string> GetRequestGet()
    {
        int i = 0;
        Dictionary<string, string> sArray = new Dictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.QueryString;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], Request.QueryString[requestItem[i]]);
        }

        return sArray;
    }

}