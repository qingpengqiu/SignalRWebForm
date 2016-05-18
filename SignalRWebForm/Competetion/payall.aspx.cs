using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Data;
using System.Text;
using System.Collections.Specialized;
using Newtonsoft.Json;
public partial class Competetion_payall : PageBase
{
    public int sid = 0;
    public string title = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        sid = TypeChangeDefault.NullToInt(Request.QueryString["sid"], 0);
        if (!IsPostBack)
        {
            DBM6.tblRace_Competition model = new DB6.tblRace_Competition().GetModel(sid);
            if (model == null)
            {
                AlertHelper.JQAlertGo("请选择赛事！", "/Competetion/SearchEvent.aspx", false);
                return;
            }
            int idUser = 0;
            if (CurrentUser != null)
            {
                idUser = CurrentUser.uId;
            }
            if (model.idUser != idUser || idUser != 100000002)
            {
                if (1 != model.iStatus)
                {
                    AlertHelper.JQAlertGo("该赛事已关闭！", "/Competetion/SearchEvent.aspx", false);
                    return;
                }
            }
            title = model.cTitle;
            this.page_Title = title+"-统一付款-益跑网赛事报名";
            this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
            this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
            ltlbanner.Text = model.cBanner.Trim().Length == 0 ? "" : "<img src=\"" + model.cBanner + "\"  alt=\"\"/>";

            if (CurrentUser == null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
                return;
            }
            DB6.tblOrder bll = new DB6.tblOrder();
            DataTable dt = bll.GetList(0, "iStatus=1 and idUser=" + CurrentUser.uId + " and cFromToID=" + sid + "", "iFromTpye").Tables[0];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int iFromTpye = TypeChangeDefault.NullToInt(dt.Rows[i]["iFromTpye"], 0);
                    if (iFromTpye == 2)
                    {
                        ltlbmh.Text = "<div class=\"annext\">报名费</div>";
                        ltlbm.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4>项目：" + dt.Rows[i]["cItemName"].ToString() + " <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 3)
                    {
                        ltljth.Text = "<div class=\"annext\">交通</div>";
                        ltljt.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4><div class=\"payalljp\"> <img src=\"/Html/images/small/CZ.gif\"><i>南方航空CZ3152	</i><em>13:00</em>首都机场T2 <br><i>空客321(中)	</i><em>16:20</em>宝安机场T3</div> 客人：Annie          Vivian          Davie          Peter  <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 4)
                    {
                        ltljdh.Text = "<div class=\"annext\">酒店</div>";

                        ltljd.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4>房型：" + dt.Rows[i]["cItemName"].ToString() + " <br>客人：";
                        List<DBM6.tblRace_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblRace_Detail>>(dt.Rows[i]["passenger"].ToString()); //乘客信息集合json 格式   
                        string name = string.Empty;
                        foreach (DBM6.tblRace_Detail p in userlist)
                        {
                            name += p.cFullname + "  ";
                        }
                        //var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(dt.Rows[i]["passenger"].ToString());
                        ltljd.Text += name + "<br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";

                        //ltljd.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4>房型：" + dt.Rows[i]["cItemName"].ToString() + " <br>客人：Vivian   Davie   Willim    Peter <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 5)
                    {
                        ltllyh.Text = "<div class=\"annext\">旅游</div>";

                        ltlly.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4>客人：Vivian   Davie   Willim    Peter <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 8)
                    {
                        ltlzbh.Text = "<div class=\"annext\">装备</div>";
                        var zb = JsonConvert.DeserializeObject<DBM6.tblEquipment_Item>(dt.Rows[i]["cItems"].ToString());
                        ltlzb.Text += "<div class=\"payall payallzb\"><h4>" + dt.Rows[i]["iTypeName"].ToString() + "</h4><img src=\"" + zb.cURL + "\"><br>颜色：黑 <br>尺寸：M <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\"  name=\"isSelect\" checked=\"checked\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 9)
                    {
                        ltlfjxh.Text = "<div class=\"annext\">附加项</div>";

                        ltlfjx.Text += "<div class=\"payall\"><h4>" + dt.Rows[i]["cItemName"].ToString() + "</h4>数量：" + dt.Rows[i]["iBuyNum"].ToString() + " <br>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><input type=\"checkbox\" checked=\"checked\"  name=\"isSelect\" value=\"" + dt.Rows[i]["ID"].ToString() + " \"></div>";
                    }
                    else if (iFromTpye == 1)//合并订单
                    {
                        ltlwfkh.Text = "<div class=\"annext\">未付款订单</div>";

                        ltlwfk.Text += "<div class=\"payall payallbutt\"><h4>" + dt.Rows[i]["cItemName"].ToString() + "</h4>价格：<em>&yen;</em><i>" + dt.Rows[i]["iCost"].ToString() + "</i><a href=\"/Competetion/payoff.aspx?sid=" + sid + "&nav=2&dd=1&id=" + dt.Rows[i]["ID"].ToString() + "&order=" + dt.Rows[i]["cOrder_no"].ToString() + "\" >去付款</a></div>";
                    }
                }
            }
            else
            {
                AlertHelper.JQAlertGo("你还没购买产品！", "/Competetion/EventDetails.aspx?sid=" + sid + "&nav=1", false);
                return;
            }
        }
    }
  
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
    protected void imgbtnpayall_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        string checkitem = TypeChangeDefault.NullToString(Request.Form["isSelect"], "0");
        if ("0" == checkitem)
        {
            AlertHelper.JQAlert("请选择付款项目！", false);
            return;
        }
        DB6.tblOrder bll = new DB6.tblOrder();
        string[] ca = checkitem.Split(',');
        if (ca.Length == 1)
        {
            DBM6.tblOrder model = bll.GetModel(TypeChangeDefault.NullToInt(checkitem.Trim(), 0));
            if (model == null)
            {
                AlertHelper.JQAlert("请选择付款项目！", false);
                return;
            }
            if (model.iCost == 0)
            {
                //金额为0
                if (model.iCost == 0)
                {
                    if (model.iStatus == 1)
                    {
                        bll.UpdateStatusById(model.ID, 2);
                        if (model.iFromTpye == 2)//赛事报名
                        {
                            int count = new DB6.tblRace_Detail().GetRecordCount("cOrder_no='" + model.cOrder_no + "'");
                            if (count == 0)
                            {
                                GetEventDetail(model.passenger, model.cParentOrder);
                            }
                        }
                        else if (model.iFromTpye == 4)//酒店
                        {
                            int count = new DB6.tblHotel_Detail().GetRecordCount("cOrder_no='" + model.cOrder_no + "'");
                            if (count == 0)
                            {
                                GetHotelDetail(model.passenger, model.cParentOrder);
                            }

                        }
                        else if (model.iFromTpye == 5)//旅游
                        {
                            int count = new DB6.tbltour_Detail().GetRecordCount("cOrder_no='" + model.cOrder_no + "'");
                            if (count == 0)
                            {
                                GetTourDetail(model.passenger, model.cParentOrder);
                            }
                        }
                        else if (model.iFromTpye == 8)//推荐装备
                        {
                            int count = new DB6.tblEquipment_Detail().GetRecordCount("cOrder_no='" + model.cOrder_no + "'");
                            if (count == 0)
                            {
                                GetEquipmentDetail(model.passenger, model.cParentOrder);
                            }

                        }
                        else if (model.iFromTpye == 9)//附属产品
                        {
                            int count = new DB6.tblAnnex_Detail().GetRecordCount("cOrder_no='" + model.cOrder_no + "'");
                            if (count == 0)
                            {
                                GetAnnexDetail(model.passenger, model.cParentOrder);
                            }
                        }
                    }
                }
                //model.iStatus = 2;
                //bll.Update(model);
                AlertHelper.JQAlertGo("您已付款成功!", "/Competetion/OrderDetails.aspx?sid=" + sid + "&nav=2&orderid=" + model.cOrder_no, false);
                return;
            }
            Response.Redirect("/Competetion/payoff.aspx?sid=" + sid + "&nav=2&id=" + model.ID + "&order=" + model.cOrder_no + "", true);
        }
        else
        {
            DBM6.tblRace_Competition modelRace = new DB6.tblRace_Competition().GetModel(sid);
            DataTable dt = bll.GetList("ID in(" + checkitem + ") and iStatus=1 and idUser=" + CurrentUser.uId + " and cFromToID=" + sid + "").Tables[0];
            string itemName = string.Empty;
            double iCost = 0.00;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                itemName += dt.Rows[i]["cItemName"].ToString() + "<em>|</em>";
                iCost += TypeChangeDefault.NullToDouble(dt.Rows[i]["iCost"], 0);
            }
            DBM6.tblOrder model = new DBM6.tblOrder
            {
                cFromToID = sid,
                cFromToName = modelRace.cTitle,
                idUser = CurrentUser.uId,
                cNickName = CurrentUser.cNickName,
                iFromTpye = 1,
                iTypeID = sid,
                iTypeName = modelRace.cTitle,
                iItemID = checkitem,
                cItemName = itemName,
                iBuyNum = 1,
                cParentOrder = "",
                iCount = 0,
                iReceipt = 0,
                dCreateTime = DateTime.Now,
                dConfirmTime = bll.GetMinTime(checkitem),
                FlightDate = Convert.ToDateTime(modelRace.dRaceBegin).ToString("yyyy-MM-dd"),
                cName = CurrentUser.cName,//当前用户信息
                IdType = "",
                IdNo = CurrentUser.cNationID,
                cMobile = CurrentUser.cMobile,
                cMail = CurrentUser.cMail,
                idCity = CurrentUser.idCity,
                cCityname = CurrentUser.cCityname,
                cAddress = CurrentUser.cAddress,
                iScore = 0,
                iMoney = 0,
                fPrice = TypeChangeDefault.NullToDecimal(iCost, 0),
                iCost = TypeChangeDefault.NullToDecimal(iCost, 0),
                iStatus = 1
            };
            if (model.iCost == 0)
            {
                model.iStatus = 2;
            }
            string orderid = bll.GetMaxOrderId("HB");
            if (orderid == "")
            {
                orderid = "HB" + DateTime.Now.ToString("yyyyMMdd") + "000001";
            }

            else
            {
                orderid = "HB" + DateTime.Now.ToString("yyyyMMdd") + (Convert.ToInt32(orderid.Substring(orderid.Length - 6, 6)) + 1).ToString().PadLeft(6, '0');
            }
            model.cOrder_no = orderid;
            model.passenger = "";
            model.cItems = JsonConvert.SerializeObject(modelRace);

            int result = bll.Add(model);
            if (result > 0)
            {
                string[] items = checkitem.Split(',');
                for (int i = 0; i < items.Length; i++)
                {
                    //合并付款订单置过期，避免多个订单同时支付
                    DBM6.tblOrder child = bll.GetModel(TypeChangeDefault.NullToInt(items[i], 0));
                    if (child != null)
                    {
                        if (child.cParentOrder.Trim().Length != 0)
                        {
                            bll.UpdateStatusByOrder(child.cParentOrder);
                        }
                        //金额为0
                        if (child.iCost == 0)
                        {
                            if (child.iStatus == 1)
                            {
                                bll.UpdateStatusById(child.ID, 2);
                                if (child.iFromTpye == 2)//赛事报名
                                {
                                    int count = new DB6.tblRace_Detail().GetRecordCount("cOrder_no='" + child.cOrder_no + "'");
                                    if (count == 0)
                                    {
                                        GetEventDetail(child.passenger, child.cParentOrder);
                                    }
                                }
                                else if (child.iFromTpye == 4)//酒店
                                {
                                    int count = new DB6.tblHotel_Detail().GetRecordCount("cOrder_no='" + child.cOrder_no + "'");
                                    if (count == 0)
                                    {
                                        GetHotelDetail(child.passenger, child.cParentOrder);
                                    }

                                }
                                else if (child.iFromTpye == 5)//旅游
                                {
                                    int count = new DB6.tbltour_Detail().GetRecordCount("cOrder_no='" + child.cOrder_no + "'");
                                    if (count == 0)
                                    {
                                        GetTourDetail(child.passenger, child.cParentOrder);
                                    }
                                }
                                else if (child.iFromTpye == 8)//推荐装备
                                {
                                    int count = new DB6.tblEquipment_Detail().GetRecordCount("cOrder_no='" + child.cOrder_no + "'");
                                    if (count == 0)
                                    {
                                        GetEquipmentDetail(child.passenger, child.cParentOrder);
                                    }

                                }
                                else if (child.iFromTpye == 9)//附属产品
                                {
                                    int count = new DB6.tblAnnex_Detail().GetRecordCount("cOrder_no='" + child.cOrder_no + "'");
                                    if (count == 0)
                                    {
                                        GetAnnexDetail(child.passenger, child.cParentOrder);
                                    }
                                }
                            }
                        }

                    }
                }
                bll.UpdateParentOrder(checkitem, orderid);
                if (model.iCost == 0)
                {
                    AlertHelper.JQAlertGo("您已付款成功!", "/Competetion/OrderDetails.aspx?sid=" + sid + "&nav=2&orderid=" + model.cOrder_no, false);
                }
                else
                {
                    Response.Redirect("/Competetion/payoff.aspx?sid=" + sid + "&nav=2&id=" + result + "&order=" + orderid + "", true);
                }
            }
            else
            {
                AlertHelper.JQAlert("提交失败！", false);
                return;
            }
        }
    }
}