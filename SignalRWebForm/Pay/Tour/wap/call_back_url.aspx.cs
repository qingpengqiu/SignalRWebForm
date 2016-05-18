using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using Com.Alipay.Wap;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Data;
public partial class Pay_Tour_wap_call_back_url : System.Web.UI.Page
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
                string out_trade_no = Request.QueryString["out_trade_no"];
                //支付宝交易号
                string trade_no = Request.QueryString["trade_no"];
                //交易状态
                string result = Request.QueryString["result"];
                DB1.tblShopping Bll = new DB1.tblShopping();
                DataTable dt = Bll.GetList(" idOrder='" + out_trade_no + "'").Tables[0];
                if (dt.Rows.Count > 0)
                {
                    idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                    cTitle = dt.Rows[0]["cGoodName"].ToString().Trim();
                    int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);//商品id
                    int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);//购买用户id
                    int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                    iCost = TypeChangeDefault.NullToDecimal(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额 
                    DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
                    if (mGood == null)
                    {
                        log.SaveLogInfo("订单号：" + out_trade_no + "----支付宝交易号:" + trade_no, "商品订单不存在");
                    }
                    if (string.IsNullOrEmpty(idAlipay))
                    {
                        DBM1.tblShopping mShop = new DBM1.tblShopping();
                        mShop.idAlipay = trade_no;
                        mShop.dPay = DateTime.Now;
                        mShop.iState = 2;
                        int idcode = 0;
                        if (mGood.iEntity == 0)
                        {
                            DataTable dtcode = new DB5.tblCode().GetList(1, "iValid=0", "id").Tables[0];
                            idcode = TypeChangeDefault.NullToInt(dtcode.Rows[0]["id"].ToString().Trim(), 0);
                            mShop.cMark4 = dtcode.Rows[0]["idCode"].ToString();
                        }
                        mShop.id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);
                        if (new DB1.tblShopping().Update(mShop))
                        {
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《<a target=\"_blank\" href=\"/infocenter/Rlist.aspx?uId=" + idUser + "&tablep=0\">" + mGood.cName + "</a>》中拼团成功！请您持续关注，谢谢！";
                                disModel.idInfo = idUser;
                                disModel.idUser = 100035871;
                                disModel.cLoginname = "益跑客服";
                                int imessage = disBll.Add(disModel);
                                if (imessage > 0)
                                {
                                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                    mMessage.cId = 100035871;
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
                                    mActivity.cTitle = "在《<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">" + mGood.cName + "</a>》中拼团成功！您也去看看呗<a target=\"_blank\" href=\"/GroupBuy/Group.aspx?id=" + idGood + "\">[查看]</a>！";
                                    mActivity.cBio = "";
                                    mActivity.dCreate = DateTime.Now;
                                    new DB2.tblActivity().Add(mActivity);
                                }
                            }
                            catch (Exception ex)
                            {

                            }
                            //报名赛事最低送10积分
                            if (isuse == 0)
                            {
                                new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, iCost);
                            }
                            //积分兑换劵更新状态
                            if (idcode != 0)
                            {
                                DBM5.tblCode mCode = new DBM5.tblCode();
                                mCode.id = idcode;
                                mCode.idGood = idGood;
                                mCode.cGoodName = mGood.cName;
                                mCode.cValue = mGood.fSellPrice;
                                mCode.iValid = 1;
                                mCode.dBuyTime = DateTime.Now;
                                mCode.idUser = idUser;
                                new DB5.tblCode().Update(mCode);
                            }
                        }
                    }
                    else { log.SaveLogInfo("订单号：" + out_trade_no + "----支付宝交易号:" + trade_no + "-----------" + idUser.ToString() + "----" + idGood.ToString(), "商品订单已付过款"); }
                }
                else { log.SaveLogInfo("订单号：" + out_trade_no + "----支付宝交易号:" + trade_no, "商品订单不存在"); }
                stringresult = "付款成功";
                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                stringresult = "验证失败";
                log.SaveLogInfo(Request.ToString(), "拼团失败");
            }
        }
        else
        {
            stringresult = "无返回参数";
            log.SaveLogInfo("无返回参数", "拼团失败");
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