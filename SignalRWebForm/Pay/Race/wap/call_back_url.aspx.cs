using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using DB4 = Erun360.BLL.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM4 = Erun360.Model.DB4;
using Com.Alipay.Wap;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Data;
public partial class Pay_Race_wap_call_back_url : System.Web.UI.Page
{
    Erun360.Common.ErrorLogFile log = new Erun360.Common.ErrorLogFile();
    public string cTitle = "";
    public string cType = "";
    public decimal iCost = 0;
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
                string order_no = Request.QueryString["out_trade_no"];
                //支付宝交易号
                string trade_no = Request.QueryString["trade_no"];
                //交易状态
                string result = Request.QueryString["result"];
                if ("success" == result.ToLower())
                {
                    //成功状态
                    DB4.tblRACE_JOIN Bll = new DB4.tblRACE_JOIN();
                    DataTable dt = Bll.GetList(" idorder='" + order_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                        int idRace = TypeChangeDefault.NullToInt(dt.Rows[0]["idActivity"].ToString().Trim(), 0);//约跑id
                        int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);//报名用户id
                        int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                        iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额

                        if (string.IsNullOrEmpty(idAlipay))
                        {
                            DBM4.tblRACE_JOIN mJoin = new DBM4.tblRACE_JOIN();
                            mJoin.idAlipay = trade_no;
                            mJoin.dPay = DateTime.Now;
                            mJoin.iStatus = 2;
                            mJoin.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
                            if (new DB4.tblRACE_JOIN().Update(mJoin))
                            {
                                DBM4.tblRACE_ACTIVITY mRace = new DB4.tblRACE_ACTIVITY().GetModel(idRace);
                                if (mRace == null)
                                {
                                    stringresult = "约跑活动不存在";
                                    log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "约跑活动不存在");
                                    return;
                                }
                                cTitle = mRace.cTitle;
                                try
                                {
                                    DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                    DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                    disModel.cContent = "您在《《<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">" + mRace.cTitle + "</a>》约跑中付款成功！请您持续关注，谢谢！";
                                    disModel.idInfo = idUser;
                                    disModel.idUser = 100001183;
                                    disModel.cLoginname = "益跑赛事";
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
                                    DBM1.tblMEMBER model = new DB1.tblMEMBER().GetModel(idUser);
                                    if (model != null)
                                    {
                                        DBM2.tblActivity mActivity = new DBM2.tblActivity();
                                        mActivity.idUser = model.id;
                                        mActivity.cNickName = model.cNickName;
                                        mActivity.cAvatar = model.cAvatar;
                                        mActivity.idBlog = imessage;
                                        mActivity.idGroup = "44";
                                        mActivity.cTitle = "在《<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">" + mRace.cTitle + "</a>》约跑中报名成功！邀请您<a target=\"_blank\" href=\"/race/" + idRace + ".aspx\">[参加]</a>！";
                                        mActivity.cBio = "";
                                        mActivity.dCreate = DateTime.Now;
                                        new DB2.tblActivity().Add(mActivity);

                                        //new DB1.tblIntegral().InsertScore(idUser, 200810017, 1, 0);
                                        //报名赛事最低送10积分
                                        if (isuse == 0)
                                        {
                                            new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, iCost, 0);
                                        }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
                                }
                            }
                        }
                        else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no + "-----------" + idUser.ToString() + "----" + idRace.ToString(), "约跑活动已付款"); }
                    }
                    else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "约跑活动已付款"); }
                    stringresult = "付款成功";
                }
                else
                {
                    stringresult = "支付失败";
                    log.SaveLogInfo(Request.ToString(), "约跑活动报名失败");
                }
                //打印页面
                //Response.Write("验证成功<br />");

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                stringresult = "验证失败";
                log.SaveLogInfo(Request.ToString(), "约跑活动验证失败");
                //Response.Write("验证失败");
            }
        }
        else
        {
            stringresult = "无返回参数";
            log.SaveLogInfo(Request.ToString(), "约跑活动无返回参数");
            //Response.Write("无返回参数");
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