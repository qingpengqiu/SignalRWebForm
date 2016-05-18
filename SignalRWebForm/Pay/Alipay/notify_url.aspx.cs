using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Com.Alipay;
using Erun360.Common;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Pay_Alipay_notify_url : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DB4.tblRACE_SALES bllsales = new DB4.tblRACE_SALES();
        DBM4.tblRACE_SALES modelsales = new DBM4.tblRACE_SALES();
        Erun360.Common.ErrorLogFile log = new Erun360.Common.ErrorLogFile();
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
                    DataSet ds = bllsales.GetList(" idorder='" + out_trade_no + "'");
                    if (ds.Tables[0].Rows[0]["idAlipay"].ToString().Trim() == "")
                    {
                        modelsales.idAlipay = trade_no;
                        modelsales.iState = 2;
                        modelsales.dPay = DateTime.Now;
                        modelsales.id = Convert.ToInt32(ds.Tables[0].Rows[0]["id"].ToString().Trim());

                        int uId = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString(), 0);//团队id
                        if (bllsales.Update(modelsales))
                        {
                            log.SaveLogInfo(Request.ToString(), "報名成功");
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《" + ds.Tables[0].Rows[0]["cTitle"].ToString().Trim() + "》中付款成功！请您持续关注，谢谢！";
                                disModel.idInfo = uId;
                                disModel.idUser = 100001183;
                                disModel.cLoginname = "益跑赛事";
                                // disModel.dCreate = DateTime.Now;
                                int imessage = disBll.Add(disModel);
                                if (imessage > 0)
                                {
                                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                                    mMessage.cId = 100001183;
                                    mMessage.uId = uId;
                                    mMessage.itype = 31;
                                    mMessage.idcode = imessage;
                                    int test = new DB3.tblMessage().Add(mMessage);
                                }
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
                                    new DB4.tblAnnexLog().UpdatePayState(TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0), TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idSignUp"].ToString().Trim(), 0), 2);
                                    //报名赛事最低送10积分
                                    if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "0")//不使用积分根据价格送积分
                                    {
                                        if (492 != idRace)
                                        {
                                            new DB1.tblIntegral().InsertScore(uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                        }
                                    }                                    
                                    //if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "1")
                                    //{
                                    //    new DB1.tblIntegral().InsertScore(uId, 200840002, 4, TypeChangeDefault.NullToDecimal(mSign.iScore, 0), "赛事花费，项目" + mSign.id.ToString());
                                    //}
                                    //else
                                    //{
                                    //    new DB1.tblIntegral().InsertScore(uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                    //}
                                }
                            }
                            catch (Exception ex)
                            {
                                log.SaveLogInfo(ex.Message.ToString(), "notify_url--1--留言失败！");
                            }

                        }
                    }
                    //注意：
                    //该种交易状态只在两种情况下出现
                    //1、开通了普通即时到账，买家付款成功后。
                    //2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
                }
                else if (Request.Form["trade_status"] == "TRADE_SUCCESS")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序
                    DataSet ds = bllsales.GetList(" idorder='" + out_trade_no + "'");
                    if (ds.Tables[0].Rows[0]["idAlipay"].ToString().Trim() == "")
                    {
                        modelsales.idAlipay = trade_no;
                        modelsales.iState = 2;
                        modelsales.dPay = DateTime.Now;
                        modelsales.id = Convert.ToInt32(ds.Tables[0].Rows[0]["id"].ToString().Trim());
                        int uId = TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString(), 0);//团队id
                        if (bllsales.Update(modelsales))
                        {
                            try
                            {
                                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                                disModel.cContent = "您在《" + ds.Tables[0].Rows[0]["cTitle"].ToString().Trim() + "》中付款成功！请您持续关注，谢谢！";
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
                                    mActivity.cTitle = "在《<a target=\"_blank\" href=\"/blog/" + mSign.idBlog + ".aspx\">" + mSign.cTitle + "</a>》中报名成功！邀请您参加！";
                                    mActivity.cBio = "";
                                    mActivity.dCreate = DateTime.Now;
                                    new DB2.tblActivity().Add(mActivity);
                                    new DB4.tblAnnexLog().UpdatePayState(TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idUser"].ToString().Trim(), 0), TypeChangeDefault.NullToInt(ds.Tables[0].Rows[0]["idSignUp"].ToString().Trim(), 0), 2);
                                    //报名赛事最低送10积分，使用积分报名不另送积分
                                    if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "0")
                                    {
                                        new DB1.tblIntegral().InsertScore(uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                    }
                                    //if (ds.Tables[0].Rows[0]["cRemark5"].ToString() == "1")
                                    //{
                                    //    new DB1.tblIntegral().InsertScore(uId, 200840002, 4, TypeChangeDefault.NullToDecimal(mSign.iScore, 0), "赛事花费，项目" + mSign.id.ToString());
                                    //}
                                    //else
                                    //{
                                    //    new DB1.tblIntegral().InsertScore(uId, 200820001, 2, TypeChangeDefault.NullToDecimal(ds.Tables[0].Rows[0]["iCost"].ToString().Trim(), 0));
                                    //}
                                }
                            }
                            catch (Exception ex)
                            {
                                log.SaveLogInfo(ex.Message.ToString(), "notify_url--2--留言失败！");
                            }

                        }
                    }
                    else
                    { log.SaveLogInfo(ds.Tables[0].Rows[0]["cName"].ToString() + ds.Tables[0].Rows[0]["idUser"].ToString(), ds.Tables[0].Rows[0]["idSignUp"].ToString() + "重复提交" + out_trade_no + "--" + trade_no); }
                    //注意：
                    //该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
                }
                else
                {
                    log.SaveLogInfo(Request.ToString(), "報名失敗");
                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                Response.Write("success");  //请不要修改或删除

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                Response.Write("fail");
                log.SaveLogInfo(Request.ToString(), "報名失敗");
            }
        }
        else
        {
            Response.Write("无通知参数");
            log.SaveLogInfo(Request.ToString(), "无通知参数");
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

}