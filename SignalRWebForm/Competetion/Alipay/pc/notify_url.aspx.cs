using Erun360.Pay.Alipay.pc;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using DBM6 = Erun360.Model.DB6;
using DB6 = Erun360.BLL.DB6;
using System.Data;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Erun360.Model.DB6;
using System.Text;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Net;
using Newtonsoft.Json;
public partial class Competetion_Alipay_pc_notify_url : System.Web.UI.Page
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
                //商户订单号
                string out_trade_no = Request.Form["out_trade_no"];
                //支付宝交易号
                string trade_no = Request.Form["trade_no"];
                //交易状态
                string trade_status = Request.Form["trade_status"];

                if (Request.Form["trade_status"] == "TRADE_FINISHED")
                {
                    DB6.tblOrder bll = new DB6.tblOrder();
                    DataTable dtOrder = bll.GetList(1, "cOrder_no='" + out_trade_no + "'", "ID desc").Tables[0];
                    if (dtOrder.Rows.Count == 1)
                    {
                        int ID = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["ID"], 0);
                        int idRace = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iTypeID"], 0);
                        string iStatus = dtOrder.Rows[0]["iStatus"].ToString();

                        int idUser = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"], 0);
                        string passenger = dtOrder.Rows[0]["passenger"].ToString();
                        string cParentOrder = dtOrder.Rows[0]["cParentOrder"].ToString();
                        int iFromTpye = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iFromTpye"], 0);
                        string cContent = dtOrder.Rows[0]["iTypeName"].ToString() + "-" + dtOrder.Rows[0]["cItemName"].ToString();
                        if ("1" == iStatus)
                        {
                            DBM6.tblOrder model = new DBM6.tblOrder();
                            model.ID = ID;
                            model.iStatus = 2;
                            model.dPayTime = bll.GetTime(0);
                            model.cTrade_no = trade_no;
                            model.cMake1 = "支付宝扫码";
                            if (bll.Update(model))
                            {
                                if (iFromTpye == 1)//合并付款
                                {
                                    if (bll.UpdateList("select ID from tblOrder where cParentOrder='" + out_trade_no + "'"))
                                    {
                                        DataTable dt = bll.GetList("cParentOrder='" + out_trade_no + "'").Tables[0];
                                        if (dt.Rows.Count > 0)
                                        {
                                            for (int j = 0; j < dt.Rows.Count; j++)
                                            {
                                                passenger = dt.Rows[j]["passenger"].ToString();
                                                cParentOrder = dt.Rows[j]["cParentOrder"].ToString();
                                                iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[j]["iFromTpye"], 0);
                                                idRace = TypeChangeDefault.NullToInt(dt.Rows[j]["iTypeID"], 0);
                                                idUser = TypeChangeDefault.NullToInt(dt.Rows[j]["idUser"], 0);
                                                ID = TypeChangeDefault.NullToInt(dt.Rows[j]["ID"], 0);
                                                cContent = dt.Rows[j]["iTypeName"].ToString() + "-" + dt.Rows[j]["cItemName"].ToString();
                                                if (iFromTpye == 2)//赛事报名
                                                {
                                                    string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                                    string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetEventDetail(passenger, cParentOrder);
                                                    //报名赛事最低送10积分
                                                    int iScore = TypeChangeDefault.NullToInt(dt.Rows[j]["iScore"], 99);
                                                    if (iScore == 0)
                                                    {
                                                        new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, TypeChangeDefault.NullToDecimal(dt.Rows[j]["iCost"].ToString().Trim(), 0));
                                                    }
                                                }
                                                else if (iFromTpye == 3)//机票
                                                {
                                                    string Content = "您已成功购买了" + dt.Rows[j]["FlightDate"].ToString().Trim() + dt.Rows[j]["cItemName"].ToString().Trim() + "《" + dt.Rows[j]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购" + dt.Rows[j]["FlightDate"].ToString().Trim() + dt.Rows[j]["cItemName"].ToString().Trim() + "的" + dt.Rows[j]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetFlightDetail(ID);
                                                }
                                                else if (iFromTpye == 4)//酒店
                                                {
                                                    string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                                    string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetHotelDetail(passenger, cParentOrder);
                                                    //报名赛事最低送10积分

                                                }
                                                else if (iFromTpye == 5)//旅游
                                                {
                                                    if (cParentOrder.Trim().Length != 0)
                                                    {
                                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                    }
                                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetTourDetail(passenger, cParentOrder);
                                                }
                                                else if (iFromTpye == 8)//推荐装备
                                                {
                                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetEquipmentDetail(passenger, cParentOrder);
                                                }
                                                else if (iFromTpye == 9)//附属产品
                                                {
                                                    string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetAnnexDetail(passenger, cParentOrder);
                                                }
                                            }
                                        }
                                    }

                                }
                                else if (iFromTpye == 2)//赛事报名
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                    string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetEventDetail(passenger, cParentOrder);
                                    //报名赛事最低送10积分
                                    int iScore = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iScore"], 99);
                                    if (iScore == 0)
                                    {
                                        new DB1.tblIntegral().InsertScore(TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"].ToString().Trim(), 0), 200820001, 2, TypeChangeDefault.NullToDecimal(dtOrder.Rows[0]["iCost"].ToString().Trim(), 0));
                                    }
                                }
                                else if (iFromTpye == 3)//机票
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "《" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "的" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetFlightDetail(ID);
                                }
                                else if (iFromTpye == 4)//酒店
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                    string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetHotelDetail(passenger, cParentOrder);
                                    //报名赛事最低送10积分

                                }
                                else if (iFromTpye == 5)//旅游
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetTourDetail(passenger, cParentOrder);
                                }
                                else if (iFromTpye == 8)//推荐装备
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetEquipmentDetail(passenger, cParentOrder);
                                }
                                else if (iFromTpye == 9)//附属产品
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetAnnexDetail(passenger, cParentOrder);
                                }
                            }
                        }
                    }
                }
                else if (Request.Form["trade_status"] == "TRADE_SUCCESS")
                {
                    DB6.tblOrder bll = new DB6.tblOrder();
                    DataTable dtOrder = bll.GetList(1, "cOrder_no='" + out_trade_no + "'", "ID desc").Tables[0];
                    if (dtOrder.Rows.Count == 1)
                    {
                        int ID = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["ID"], 0);
                        int idRace = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iTypeID"], 0);
                        string iStatus = dtOrder.Rows[0]["iStatus"].ToString();

                        int idUser = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"], 0);
                        string passenger = dtOrder.Rows[0]["passenger"].ToString();
                        string cParentOrder = dtOrder.Rows[0]["cParentOrder"].ToString();
                        int iFromTpye = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iFromTpye"], 0);
                        string cContent = dtOrder.Rows[0]["iTypeName"].ToString() + "-" + dtOrder.Rows[0]["cItemName"].ToString();
                        if ("1" == iStatus)
                        {
                            DBM6.tblOrder model = new DBM6.tblOrder();
                            model.ID = ID;
                            model.iStatus = 2;
                            model.dPayTime = bll.GetTime(0);
                            model.cTrade_no = trade_no;
                            model.cMake1 = "支付宝扫码";
                            if (bll.Update(model))
                            {
                                if (iFromTpye == 1)//合并付款
                                {
                                    if (bll.UpdateList("select ID from tblOrder where cParentOrder='" + out_trade_no + "'"))
                                    {
                                        DataTable dt = bll.GetList("cParentOrder='" + out_trade_no + "'").Tables[0];
                                        if (dt.Rows.Count > 0)
                                        {
                                            for (int j = 0; j < dt.Rows.Count; j++)
                                            {
                                                passenger = dt.Rows[j]["passenger"].ToString();
                                                cParentOrder = dt.Rows[j]["cParentOrder"].ToString();
                                                iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[j]["iFromTpye"], 0);
                                                idRace = TypeChangeDefault.NullToInt(dt.Rows[j]["iTypeID"], 0);
                                                idUser = TypeChangeDefault.NullToInt(dt.Rows[j]["idUser"], 0);
                                                ID = TypeChangeDefault.NullToInt(dt.Rows[j]["ID"], 0);
                                                cContent = dt.Rows[j]["iTypeName"].ToString() + "-" + dt.Rows[j]["cItemName"].ToString();
                                                if (iFromTpye == 2)//赛事报名
                                                {
                                                    string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                                    string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetEventDetail(passenger, cParentOrder);
                                                    //报名赛事最低送10积分
                                                    int iScore = TypeChangeDefault.NullToInt(dt.Rows[j]["iScore"], 99);
                                                    if (iScore == 0)
                                                    {
                                                        new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, TypeChangeDefault.NullToDecimal(dt.Rows[j]["iCost"].ToString().Trim(), 0));
                                                    }
                                                }
                                                else if (iFromTpye == 3)//机票
                                                {
                                                    string Content = "您已成功购买了" + dt.Rows[j]["FlightDate"].ToString().Trim() + dt.Rows[j]["cItemName"].ToString().Trim() + "《" + dt.Rows[j]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购" + dt.Rows[j]["FlightDate"].ToString().Trim() + dt.Rows[j]["cItemName"].ToString().Trim() + "的" + dt.Rows[j]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetFlightDetail(ID);
                                                }
                                                else if (iFromTpye == 4)//酒店
                                                {
                                                    string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                                    string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetHotelDetail(passenger, cParentOrder);
                                                    //报名赛事最低送10积分

                                                }
                                                else if (iFromTpye == 5)//旅游
                                                {
                                                    if (cParentOrder.Trim().Length != 0)
                                                    {
                                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                                    }
                                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetTourDetail(passenger, cParentOrder);
                                                }
                                                else if (iFromTpye == 8)//推荐装备
                                                {
                                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetEquipmentDetail(passenger, cParentOrder);
                                                }
                                                else if (iFromTpye == 9)//附属产品
                                                {
                                                    string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                                    string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                                    AddDiscuss(idUser, Content, 100001183);
                                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                                    GetAnnexDetail(passenger, cParentOrder);
                                                }
                                            }
                                        }
                                    }

                                }
                                else if (iFromTpye == 2)//赛事报名
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                                    string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetEventDetail(passenger, cParentOrder);
                                    //报名赛事最低送10积分
                                    int iScore = TypeChangeDefault.NullToInt(dtOrder.Rows[0]["iScore"], 99);
                                    if (iScore == 0)
                                    {
                                        new DB1.tblIntegral().InsertScore(TypeChangeDefault.NullToInt(dtOrder.Rows[0]["idUser"].ToString().Trim(), 0), 200820001, 2, TypeChangeDefault.NullToDecimal(dtOrder.Rows[0]["iCost"].ToString().Trim(), 0));
                                    }
                                }
                                else if (iFromTpye == 3)//机票
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "《" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "》航班机票！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购" + dtOrder.Rows[0]["FlightDate"].ToString().Trim() + dtOrder.Rows[0]["cItemName"].ToString().Trim() + "的" + dtOrder.Rows[0]["iItemID"].ToString().Trim() + "航班机票！<a target=\"_blank\" href=\"/Flight/flightgroom.aspx\">[查看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetFlightDetail(ID);
                                }
                                else if (iFromTpye == 4)//酒店
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                                    string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetHotelDetail(passenger, cParentOrder);
                                    //报名赛事最低送10积分

                                }
                                else if (iFromTpye == 5)//旅游
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetTourDetail(passenger, cParentOrder);
                                }
                                else if (iFromTpye == 8)//推荐装备
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetEquipmentDetail(passenger, cParentOrder);
                                }
                                else if (iFromTpye == 9)//附属产品
                                {
                                    if (cParentOrder.Trim().Length != 0)
                                    {
                                        bll.UpdateStatusByOrder(cParentOrder.Trim());
                                    }
                                    string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                                    string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                                    AddDiscuss(idUser, Content, 100001183);
                                    AddFeed(idUser, ID, "44", FeedContent, "");
                                    GetAnnexDetail(passenger, cParentOrder);
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
    #region 购买旅游产品详情
    private static void GetTourDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tbltour_Detail>(passenger);
        DBM6.tbltour_Detail model = new DBM6.tbltour_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tbltour_Detail().Add(model);
    }
    #endregion
    #region 购买装备产品详情
    private static void GetEquipmentDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblEquipment_Detail>(passenger);
        DBM6.tblEquipment_Detail model = new DBM6.tblEquipment_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblEquipment_Detail().Add(model);
    }
    #endregion
    #region 购买酒店产品详情
    private static void GetHotelDetail(string passenger, string cParentOrder)
    {
        List<DBM6.tblHotel_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblHotel_Detail>>(passenger);
        foreach (DBM6.tblHotel_Detail x in userlist)
        {
            DBM6.tblHotel_Detail model = new DBM6.tblHotel_Detail
            {
                idCompete = x.idCompete,
                cCompetitionName = x.cCompetitionName,
                idItem = x.idItem,
                cItemName = x.cItemName,
                idUser = x.idUser,
                cFullname = x.cFullname,
                cGender = x.cGender,
                idBlood = x.idBlood,
                dBirthday = x.dBirthday,
                IdType = x.IdType,
                IdNo = x.IdNo,
                cNational = x.cNational,
                cMobile = x.cMobile,
                cMail = x.cMail,
                idCity = x.idCity,
                cCityname = x.cCityname,
                cAddress = x.cAddress,
                cZipcode = x.cZipcode,
                dCreate = new DB6.tblOrder().GetTime(0),
                //cParentOrder = x.cParentOrder,
                cOrder_no = x.cOrder_no,
                cMake = x.cMake,
                cMake1 = x.cMake1,
                cMake2 = x.cMake2,
                cMake3 = x.cMake3
            };
            model.cParentOrder = cParentOrder;
            new DB6.tblHotel_Detail().Add(model);
        } 
    }
    #endregion
    #region 购买附属产品详情
    private static void GetAnnexDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblAnnex_Detail>(passenger);
        DBM6.tblAnnex_Detail model = new DBM6.tblAnnex_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake = x.cMake,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblAnnex_Detail().Add(model);
    }
    #endregion
    #region 购买赛事详情
    private static void GetEventDetail(string passenger, string cParentOrder)
    {
        var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(passenger);
        DBM6.tblRace_Detail model = new DBM6.tblRace_Detail
        {
            idCompete = x.idCompete,
            cCompetitionName = x.cCompetitionName,
            idItem = x.idItem,
            cItemName = x.cItemName,
            idUser = x.idUser,
            csurname = x.csurname,
            cname = x.cname,
            cFullname = x.cFullname,
            cGender = x.cGender,
            idBlood = x.idBlood,
            dBirthday = x.dBirthday,
            IdType = x.IdType,
            IdNo = x.IdNo,
            cNational = x.cNational,
            cMobile = x.cMobile,
            cMail = x.cMail,
            idCity = x.idCity,
            cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            idEducation = x.idEducation,
            idOccupation = x.idOccupation,
            cEmergerContact = x.cEmergerContact,
            cPlace = x.cPlace,
            dIssue = x.dIssue,
            dExpiry = x.dExpiry,
            cFirst = x.cFirst,
            cresult = x.cresult,
            dCreate = new DB6.tblOrder().GetTime(0),
            cCloth = x.cCloth,
            cShoe = x.cShoe,
            cHealthUrl = x.cHealthUrl,
            cECG = x.cECG,
            cFinished = x.cFinished,
            cMake = x.cMake,
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            cMake3 = x.cMake3,
            cMake4 = x.cMake4
        };
        model.cParentOrder = cParentOrder;
        new DB6.tblRace_Detail().Add(model);
    }
    #endregion
    #region 购买机票详情表(插入更买成功的人的信息)
    private void GetFlightDetail(int IdFlight)
    {
        DBM6.tblOrder model = new DB6.tblOrder().GetModel(IdFlight);
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
                    detail.dCreateTime = new DB6.tblOrder().GetTime(0);
                    new DB6.tblFlight_Detail().Add(detail);
                }
            }
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
    #region 插入评论
    /// <summary>
    /// 插入评论
    /// </summary>
    /// <param name="idUser">接受消息人</param>
    /// <param name="IdCritic">发送消息人（一般是益跑赛事，100001183）</param>
    /// <param name="Content">评论内容（消息内容）</param>
    private static void AddDiscuss(int idUser, string Content, int IdCritic = 100001183)
    {
        DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
        DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(IdCritic);
        disModel.cContent = Content;//"您在《" + model.iTypeName + "-" + model.cItemName + "》中付款成功！请您持续关注！";
        disModel.idInfo = idUser;
        disModel.idUser = IdCritic;
        disModel.cLoginname = user.cNickName;
        disModel.dCreate = new DB6.tblOrder().GetTime(0);
        int imessage = disBll.Add(disModel);
        if (imessage > 0)
        {
            DBM3.tblMessage mMessage = new DBM3.tblMessage();
            mMessage.cId = IdCritic;
            mMessage.uId = idUser;
            mMessage.itype = 31;
            mMessage.idcode = imessage;
            new DB3.tblMessage().Add(mMessage);
        }
    }
    #endregion
    #region 插入活动记录表
    /// <summary>
    /// 插入活动记录表
    /// </summary>
    /// <param name="idUser">用户id</param>
    /// <param name="idBlog">对应记录id</param>
    /// <param name="idGroup">分类id</param>
    /// <param name="Content">内容</param>
    /// <param name="Bio">简介</param>
    private static void AddFeed(int idUser, int idBlog, string idGroup, string Content, string Bio)
    {
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(idUser);
        if (user != null)
        {
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = user.id;
            mActivity.cNickName = user.cNickName;
            mActivity.cAvatar = user.cAvatar;
            mActivity.idBlog = idBlog;
            mActivity.idGroup = idGroup;
            mActivity.cTitle = Content;
            mActivity.cBio = Bio;
            mActivity.dCreate = DateTime.Now;
            new DB2.tblActivity().Add(mActivity);
        }
    }
    #endregion
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