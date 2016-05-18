using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Xml;
using Com.Alipay.Wap;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Data;

public partial class Pay_Score_wap_notify_url : System.Web.UI.Page
{
    Erun360.Common.ErrorLogFile log = new Erun360.Common.ErrorLogFile();
    protected void Page_Load(object sender, EventArgs e)
    {
        Dictionary<string, string> sPara = GetRequestPost();

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.VerifyNotify(sPara, Request.Form["sign"]);

            if (verifyResult)//验证成功
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码


                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

                //解密（如果是RSA签名需要解密，如果是MD5签名则下面一行清注释掉）
                sPara = aliNotify.Decrypt(sPara);

                //XML解析notify_data数据
                try
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml(sPara["notify_data"]);
                    //商户订单号
                    string order_no = xmlDoc.SelectSingleNode("/notify/out_trade_no").InnerText;
                    //支付宝交易号
                    string trade_no = xmlDoc.SelectSingleNode("/notify/trade_no").InnerText;
                    //交易状态
                    string trade_status = xmlDoc.SelectSingleNode("/notify/trade_status").InnerText;

                    if (trade_status == "TRADE_FINISHED")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        //注意：
                        //该种交易状态只在两种情况下出现
                        //1、开通了普通即时到账，买家付款成功后。
                        //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
                        //成功状态
                        DB1.tblShopping Bll = new DB1.tblShopping();
                        DataTable dt = Bll.GetList(" idOrder='" + order_no + "'").Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            string idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                            int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);//商品id
                            int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);//购买用户id
                            int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                            decimal iCost = TypeChangeDefault.NullToInt(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                            DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
                            if (mGood == null)
                            {
                                log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "积分商品不存在");
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
                                        disModel.cContent = "您在《<a target=\"_blank\" href=\"/infocenter/Rlist.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》中积分兑换成功！请您持续关注，谢谢！";
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
                                            mActivity.cTitle = "在《<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》商品中兑换成功！您也去看看呗<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">[查看]</a>！";
                                            mActivity.cBio = "";
                                            mActivity.dCreate = DateTime.Now;
                                            new DB2.tblActivity().Add(mActivity);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        log.SaveLogInfo(ex.Message.ToString(), "return_url---留言失败！");
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
                            else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no + "-----------" + idUser.ToString() + "----" + idGood.ToString(), "约跑活动已付款"); }
                        }
                        else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "积分商品已付款"); }
                        Response.Write("success");  //请不要修改或删除
                    }
                    else if (trade_status == "TRADE_SUCCESS")
                    {
                        //判断该笔订单是否在商户网站中已经做过处理
                        //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                        //如果有做过处理，不执行商户的业务程序

                        //注意：
                        //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
                        DB1.tblShopping Bll = new DB1.tblShopping();
                        DataTable dt = Bll.GetList(" idOrder='" + order_no + "'").Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            string idAlipay = dt.Rows[0]["idAlipay"].ToString().Trim();
                            int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);//商品id
                            int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);//购买用户id
                            int isuse = TypeChangeDefault.NullToInt(dt.Rows[0]["isuse"].ToString().Trim(), 0);//是否使用积分
                            decimal iCost = TypeChangeDefault.NullToInt(dt.Rows[0]["iCost"].ToString().Trim(), 0);//付款金额
                            DBM1.tblGoods mGood = new DB1.tblGoods().GetModel(idGood);
                            if (mGood == null)
                            {
                                log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "积分商品不存在");
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
                                        disModel.cContent = "您在《<a target=\"_blank\" href=\"/infocenter/Rlist.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》中积分兑换成功！请您持续关注，谢谢！";
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
                                            mActivity.cTitle = "在《<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">" + mGood.cName + "</a>》商品中兑换成功！您也去看看呗<a target=\"_blank\" href=\"/infocenter/Integral.aspx?uId=" + idUser + "&tablep=1\">[查看]</a>！";
                                            mActivity.cBio = "";
                                            mActivity.dCreate = DateTime.Now;
                                            new DB2.tblActivity().Add(mActivity);
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        log.SaveLogInfo(ex.Message.ToString(), "积分商品失败！");
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
                            else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no + "-----------" + idUser.ToString() + "----" + idGood.ToString(), "约跑活动已付款"); }
                        }
                        else { log.SaveLogInfo("订单号：" + order_no + "----支付宝交易号:" + trade_no, "积分商品已付款"); }

                        Response.Write("success");  //请不要修改或删除
                    }
                    else
                    {
                        Response.Write(trade_status);
                    }

                }
                catch (Exception exc)
                {
                    Response.Write(exc.ToString());
                }



                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

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
    public Dictionary<string, string> GetRequestPost()
    {
        int i = 0;
        Dictionary<string, string> sArray = new Dictionary<string, string>();
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
}
