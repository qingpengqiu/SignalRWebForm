using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Newtonsoft.Json;
using System.Text;
using Utils;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DB3 = Erun360.BLL.DB3;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using Erun360.Model.DB6;
public partial class Admin_RaceJionStatus : PageBase
{
    public int id = 0;//记录id
    private int idRace = 0;//赛事id
    private int idItem = 0;//项目id
    public int iFromTpye = 2;//订单类型
    public int idUser = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);
        iFromTpye = TypeChangeDefault.NullToInt(Request.QueryString["iFromTpye"], 2);
        if (!IsPostBack)
        {
            DB6.tblOrder bll = new DB6.tblOrder();
            DBM6.tblOrder mOrder = bll.GetModel(id);
            if (mOrder != null)
            {
                idUser = mOrder.idUser ?? 0;
                if (iFromTpye == 2)
                {
                    var model = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(mOrder.passenger);
                    name.Value = model.cFullname;
                    mobile.Value = TypeChangeDefault.NullToString(model.cMobile, "");
                    email.Value = TypeChangeDefault.NullToString(model.cMail, "");
                    cCityname.Value = TypeChangeDefault.NullToString(model.cCityname, "");
                    address.Value = TypeChangeDefault.NullToString(model.cAddress, "");

                    string[] Contact = TypeChangeDefault.NullToString(model.cEmergerContact, "").Trim().Split('|');
                    if (Contact.Length > 1)
                    {
                        emerger.Value = Contact[0];
                        emermobile.Value = Contact[1];
                    }

                    //附件
                    StringBuilder sbFileup = new StringBuilder();
                    if (model.cHealthUrl != null)
                    {
                        if (model.cHealthUrl.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                        }

                    }
                    if (model.cECG != null)
                    {
                        if (model.cECG.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            ltlbz1.Text = model.cECG;
                        }
                    }
                    if (model.cFinished != null)
                    {
                        if (model.cFinished.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            ltlbz2.Text = model.cFinished;
                        }
                    }

                    if (model.cMake != null)
                    {
                        if (model.cMake.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            ltlbz3.Text = model.cMake;
                        }
                    }

                    if (model.cMake1 != null)
                    {
                        if (model.cMake1.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            ltlbz4.Text = model.cMake1;
                        }
                    }

                    if (model.cMake2 != null)
                    {
                        if (model.cMake2.Contains(GetDir(model.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + model.cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else
                        {
                            ltlbz5.Text = model.cMake2;
                        }
                    }
                    ltlImg.Text = sbFileup.ToString();
                }
                else if (iFromTpye == 4)//酒店
                {
                    StringBuilder sbFileup = new StringBuilder();
                    List<DBM6.tblHotel_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblHotel_Detail>>(mOrder.passenger);
                    foreach (DBM6.tblHotel_Detail x in userlist)
                    {
                        sbFileup.Append(x.cFullname + ",");
                    }
                    name.Value = mOrder.cName;
                    mobile.Value = TypeChangeDefault.NullToString(mOrder.cMobile, "");
                    email.Value = TypeChangeDefault.NullToString(mOrder.cMail, "");
                    //cCityname.Value = TypeChangeDefault.NullToString(mOrder.cCityname, "");
                    address.Value = TypeChangeDefault.NullToString(mOrder.cAddress, "");
                    beizu.Value = TypeChangeDefault.NullToString(mOrder.cMake2, "");
                    idlxr.Visible = false;
                    idyx.Visible = false;
                    cCityname.Visible = false;
                }
                else if (iFromTpye == 5)//旅游
                {
                    var model = JsonConvert.DeserializeObject<DBM6.tbltour_Detail>(mOrder.passenger);
                    name.Value = model.cFullname;
                    mobile.Value = TypeChangeDefault.NullToString(model.cMobile, "");
                    address.Value = TypeChangeDefault.NullToString(model.cAddress, "");
                    beizu.Value = TypeChangeDefault.NullToString(model.cMake2, "");
                    idlxr.Visible = false;
                    idyx.Visible = false;
                    cCityname.Visible = false;
                }
                else if (iFromTpye == 8)//推荐装备
                {
                    var model = JsonConvert.DeserializeObject<DBM6.tblEquipment_Detail>(mOrder.passenger);
                    name.Value = model.cFullname;
                    mobile.Value = TypeChangeDefault.NullToString(model.cMobile, "");
                    idlxr.Visible = false;
                    idyx.Visible = false;
                    cCityname.Visible = false;
                    //email.Value = TypeChangeDefault.NullToString(model.cMail, "");                   
                    //cCityname.Value = TypeChangeDefault.NullToString(model.cCityname, "");
                    address.Value = TypeChangeDefault.NullToString(model.cAddress, "");
                    beizu.Value = TypeChangeDefault.NullToString(model.cMake2, "");
                }
                else if (iFromTpye == 9)//附属产品
                {
                    var model = JsonConvert.DeserializeObject<DBM6.tblAnnex_Detail>(mOrder.passenger);
                    name.Value = model.cFullname;
                    mobile.Value = TypeChangeDefault.NullToString(model.cMobile, "");
                    email.Value = TypeChangeDefault.NullToString(model.cMail, "");
                    cCityname.Value = TypeChangeDefault.NullToString(model.cCityname, "");
                    address.Value = TypeChangeDefault.NullToString(model.cAddress, "");
                    idlxr.Visible = false;
                    beizu.Visible = false;
                }

                state.SelectedValue = mOrder.iStatus.ToString();
                cRemark1.Value = mOrder.cMake3;
                ltlorder.Text = mOrder.cOrder_no;
            }
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if ((CurrentUser.uId != 100001183 && CurrentUser.uId != 100055041) && CurrentUser.idMemberStyle != 99)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        int iStatus = TypeChange.NullToInt(state.SelectedValue, -1);//默认已过期 
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder mOrder = bll.GetModel(id);
        if (mOrder != null)
        {
            string cContent = mOrder.iTypeName + "-" + mOrder.cItemName;
            idUser = mOrder.idUser ?? 0;
            if (mOrder.iStatus < 2 && mOrder.iStatus > -1)//未付款
            {
                if (iFromTpye == 2)
                {
                    DBM6.tblRace_Item modelItem = new DB6.tblRace_Item().GetModel(int.Parse(mOrder.iItemID));
                    if (modelItem != null)
                    {
                        //审核 只能状态只能从0置到1，0到2，0到-1
                        if (modelItem.iAudit == 1)//审核
                        {
                            if (mOrder.iStatus == 0 && iStatus == 1)//审核到待付款
                            {
                                // 20160427  审核项目：审核通过后，扣除库存量，并且库存量不能
                                DBM6.tblRace_Item racemodel = new DB6.tblRace_Item().GetModel(TypeChangeDefault.NullToInt(mOrder.iItemID, 0));
                                if (racemodel != null)
                                {
                                    if (racemodel.iLimit > 0)
                                    {
                                        mOrder.ID = id;
                                        mOrder.iStatus = 1;
                                        //mOrder.dConfirmTime = bll.GetTime(0);
                                        mOrder.cMake3 = cRemark1.Value.Trim();
                                        bll.Update(mOrder);
                                        //bll.UpdateStatusById(id, 1);//审核到待付款  
                                        // 20160427  审核项目：审核通过后，扣除库存量，并且库存量不能 begin
                                        racemodel.iLimit = racemodel.iLimit - mOrder.iBuyNum;
                                        new DB6.tblRace_Item().Update(racemodel);
                                        //end
                                        string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》报名中已通过审核！<a target=\"_blank\" href=\"/Competetion/payoff.aspx?sid=" + idRace + "&id=" + id + "&nav=2&order=" + mOrder.cOrder_no + "\">去付款</a>，谢谢！";
                                        AddDiscuss(idUser, Content, CurrentUser.uId);
                                    }
                                    else
                                    {
                                        AlertHelper.JQAlert("审核人数已达到限制", false);
                                        return;
                                    }
                                }
                                else
                                {
                                    AlertHelper.JQAlertGo("审核项目不存在", "RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, false);
                                }

                            }
                            else if (mOrder.iStatus == 0 && iStatus == -1)//审核到已过期
                            {
                                mOrder.ID = id;
                                mOrder.iStatus = -1;
                                mOrder.cMake3 = cRemark1.Value.Trim();
                                bll.Update(mOrder);
                                //expire(id);//做过期处理
                            }
                            //else if (mOrder.iStatus == 0 && iStatus == 2)//审核到已付款
                            //{
                            //    mOrder.ID = id;
                            //    mOrder.iStatus = 2;
                            //    mOrder.dConfirmTime = bll.GetTime(0);
                            //    mOrder.dPayTime = bll.GetTime(0);
                            //    mOrder.cMake3 = cRemark1.Value.Trim() + "-手动处理";
                            //    if (bll.Update(mOrder))
                            //    {
                            //        //付款成功处理
                            //        //父订单号置过期
                            //        if (mOrder.cParentOrder.Trim().Length != 0)
                            //        {
                            //            bll.UpdateStatusByOrder(mOrder.cParentOrder.Trim());
                            //        }
                            //        if (iFromTpye == 2)//赛事报名
                            //        {
                            //            string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEventDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //            if (mOrder.iScore == 0)
                            //            {
                            //                new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, mOrder.iCost ?? 0);
                            //            }
                            //        }
                            //        else if (iFromTpye == 4)//酒店
                            //        {
                            //            string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetHotelDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //        }
                            //        else if (iFromTpye == 5)//旅游
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetTourDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 8)//推荐装备
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEquipmentDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 9)//附属产品
                            //        {

                            //            string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetAnnexDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //    }

                            //}
                            //else if (mOrder.iStatus == 1 && iStatus == 2)//待付款到已付款
                            //{
                            //    mOrder.ID = id;
                            //    mOrder.iStatus = 2;
                            //    mOrder.dPayTime = bll.GetTime(0);
                            //    mOrder.cMake3 = cRemark1.Value.Trim() + "-手动处理";
                            //    if (bll.Update(mOrder))
                            //    {
                            //        //付款成功处理
                            //        //父订单号置过期
                            //        if (mOrder.cParentOrder.Trim().Length != 0)
                            //        {
                            //            bll.UpdateStatusByOrder(mOrder.cParentOrder.Trim());
                            //        }
                            //        if (iFromTpye == 2)//赛事报名
                            //        {
                            //            string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEventDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //            if (mOrder.iScore == 0)
                            //            {
                            //                new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, mOrder.iCost ?? 0);
                            //            }
                            //        }
                            //        else if (iFromTpye == 4)//酒店
                            //        {
                            //            string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetHotelDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //        }
                            //        else if (iFromTpye == 5)//旅游
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetTourDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 8)//推荐装备
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEquipmentDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 9)//附属产品
                            //        {

                            //            string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetAnnexDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //    }

                            //}
                            else if (mOrder.iStatus == 1 && iStatus == -1)//待付款到过期
                            {
                                if (bll.UpdateStatusById(id, -1))
                                {
                                    expire(id);//做过期处理
                                }
                            }
                        }
                        else
                        {
                            //不是审核项目 只能状态只能从1置到2，1到-1
                            //if (mOrder.iStatus == 1 && iStatus == 2)//待付款到已付款
                            //{
                            //    mOrder.ID = id;
                            //    mOrder.iStatus = 2;
                            //    mOrder.dPayTime = bll.GetTime(0);
                            //    mOrder.cMake3 = cRemark1.Value.Trim() + "-手动处理";
                            //    if (bll.Update(mOrder))
                            //    {
                            //        //付款成功处理
                            //        //父订单号置过期
                            //        if (mOrder.cParentOrder.Trim().Length != 0)
                            //        {
                            //            bll.UpdateStatusByOrder(mOrder.cParentOrder.Trim());
                            //        }
                            //        if (iFromTpye == 2)//赛事报名
                            //        {
                            //            string Content = "您在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《<a target=\"_blank\" href=\"/Competetion/EventDetails.aspx?sid=" + idRace + "&nav=1\">" + cContent + "</a>》中报名成功！邀请您<a target=\"_blank\" href=\"/Competetion/projects.aspx?sid=" + idRace + "&nav=2\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEventDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //            if (mOrder.iScore == 0)
                            //            {
                            //                new DB1.tblIntegral().InsertScore(idUser, 200820001, 2, mOrder.iCost ?? 0);
                            //            }
                            //        }
                            //        else if (iFromTpye == 4)//酒店
                            //        {
                            //            string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                            //            string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetHotelDetail(mOrder.passenger, mOrder.cParentOrder);
                            //            //报名赛事最低送10积分

                            //        }
                            //        else if (iFromTpye == 5)//旅游
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetTourDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 8)//推荐装备
                            //        {
                            //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetEquipmentDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //        else if (iFromTpye == 9)//附属产品
                            //        {

                            //            string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                            //            string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                            //            AddDiscuss(idUser, Content, CurrentUser.uId);
                            //            AddFeed(idUser, id, "44", FeedContent, "");
                            //            GetAnnexDetail(mOrder.passenger, mOrder.cParentOrder);
                            //        }
                            //    }

                            //}
                            //else 
                            if (mOrder.iStatus == 1 && iStatus == -1)//待付款到过期
                            {
                                if (bll.UpdateStatusById(id, -1))
                                {
                                    expire(id);//做过期处理
                                }
                            }
                        }//不是审核项目
                    }
                }
                else
                {
                    //不是审核项目 只能状态只能从1置到2，1到-1
                    //if (mOrder.iStatus == 1 && iStatus == 2)//待付款到已付款
                    //{
                    //    mOrder.ID = id;
                    //    mOrder.iStatus = 2;
                    //    mOrder.dPayTime = bll.GetTime(0);
                    //    mOrder.cMake3 = cRemark1.Value.Trim() + "-手动处理";
                    //    if (bll.Update(mOrder))
                    //    {
                    //        //付款成功处理
                    //        //父订单号置过期
                    //        if (mOrder.cParentOrder.Trim().Length != 0)
                    //        {
                    //            bll.UpdateStatusByOrder(mOrder.cParentOrder.Trim());
                    //        }
                    //        if (iFromTpye == 4)//酒店
                    //        {
                    //            string Content = "您在《" + cContent + "》中付款成功！请您持续关注，谢谢！";
                    //            string FeedContent = "在《" + cContent + "》中购买成功！邀请您<a target=\"_blank\" href=\"Competetion/hotel.aspx?sid=" + idRace + "&nav=4\">[参加]</a>！";
                    //            AddDiscuss(idUser, Content, CurrentUser.uId);
                    //            AddFeed(idUser, id, "44", FeedContent, "");
                    //            GetHotelDetail(mOrder.passenger, mOrder.cParentOrder);
                    //            //报名赛事最低送10积分

                    //        }
                    //        else if (iFromTpye == 5)//旅游
                    //        {
                    //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                    //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/tour.aspx?sid=" + idRace + "&nav=5\">[去看看]</a>！";
                    //            AddDiscuss(idUser, Content, CurrentUser.uId);
                    //            AddFeed(idUser, id, "44", FeedContent, "");
                    //            GetTourDetail(mOrder.passenger, mOrder.cParentOrder);
                    //        }
                    //        else if (iFromTpye == 8)//推荐装备
                    //        {
                    //            string Content = "您已成功购买了《" + cContent + "》产品！请您持续关注，谢谢！";
                    //            string FeedContent = "成功订购《" + cContent + "》产品！您也<a target=\"_blank\" href=\"/Competetion/equipment.aspx?sid=" + idRace + "&nav=8\">[去看看]</a>！";
                    //            AddDiscuss(idUser, Content, CurrentUser.uId);
                    //            AddFeed(idUser, id, "44", FeedContent, "");
                    //            GetEquipmentDetail(mOrder.passenger, mOrder.cParentOrder);
                    //        }
                    //        else if (iFromTpye == 9)//附属产品
                    //        {

                    //            string Content = "您已成功购买了《" + cContent.TrimEnd('-') + "》产品！请您持续关注，谢谢！";
                    //            string FeedContent = "成功订购《" + cContent.TrimEnd('-') + "》产品！您也<a target=\"_blank\" href=\"/Competetion/annex.aspx?sid=" + idRace + "&nav=9\">[去看看]</a>！";
                    //            AddDiscuss(idUser, Content, CurrentUser.uId);
                    //            AddFeed(idUser, id, "44", FeedContent, "");
                    //            GetAnnexDetail(mOrder.passenger, mOrder.cParentOrder);
                    //        }
                    //    }

                    //}
                    //else 
                    if (mOrder.iStatus == 1 && iStatus == -1)//待付款到过期
                    {
                        if (bll.UpdateStatusById(id, -1))
                        {
                            expire(id);//做过期处理
                        }
                    }
                }
            }
            else if (mOrder.iStatus == -1)
            {
                mOrder.ID = id;
                mOrder.cMake3 = cRemark1.Value.Trim();
                bll.Update(mOrder);
            }
        }
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "#a" + id, true);
    }
    //过期处理
    protected void expire(int id)
    {
        DB6.tblOrder bll = new DB6.tblOrder();
        DBM6.tblOrder model = bll.GetModel(id);
        if (model.iFromTpye == 2)
        {
            DBM6.tblRace_Item racemodel = new DB6.tblRace_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblRace_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 4)
        {
            DBM6.tblHotel_Item racemodel = new DB6.tblHotel_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblHotel_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 8)
        {
            DBM6.tblEquipment_Item racemodel = new DB6.tblEquipment_Item().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iLimit = racemodel.iLimit + model.iBuyNum;
            new DB6.tblEquipment_Item().Update(racemodel);
        }
        else if (model.iFromTpye == 9)
        {
            DBM6.tblAnnex racemodel = new DB6.tblAnnex().GetModel(TypeChangeDefault.NullToInt(model.iItemID, 0));
            racemodel.iNum = racemodel.iNum + model.iBuyNum;
            new DB6.tblAnnex().Update(racemodel);
        }
        //未付款退还积分
        if (model.iScore > 0)
        {
            new DB1.tblIntegral().InsertScore(model.idUser ?? 0, 200830003, 3, model.iScore ?? 0, "没付款返还积分值订单号：" + model.cOrder_no);
        }
        DBM6.tblOrder child = bll.GetModel(TypeChangeDefault.NullToInt(id, 0));
        if (child != null)
        {
            if (child.cParentOrder.Trim().Length != 0)
            {
                bll.UpdateStatusByOrder(child.cParentOrder);
            }
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
            //cGender = x.cGender,
            //idBlood = x.idBlood,
            //dBirthday = x.dBirthday,
            //IdType = x.IdType,
            //IdNo = x.IdNo,
            //cNational = x.cNational,
            cMobile = x.cMobile,
            //cMail = x.cMail,
            //idCity = x.idCity,
            //cCityname = x.cCityname,
            cAddress = x.cAddress,
            //cZipcode = x.cZipcode,
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
            //cGender = x.cGender,
            //idBlood = x.idBlood,
            //dBirthday = x.dBirthday,
            //IdType = x.IdType,
            //IdNo = x.IdNo,
            //cNational = x.cNational,
            cMobile = x.cMobile,
            //cMail = x.cMail,
            //idCity = x.idCity,
            //cCityname = x.cCityname,
            cAddress = x.cAddress,
            cZipcode = x.cZipcode,
            dCreate = new DB6.tblOrder().GetTime(0),
            //cParentOrder = x.cParentOrder,
            cOrder_no = x.cOrder_no,
            //cMake = x.cMake,
            //cMake1 = x.cMake1,
            cMake2 = x.cMake2,
            //cMake3 = x.cMake3
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
            DBM6.tblHotel_Detail model = new tblHotel_Detail
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
            mActivity.dCreate = new DB6.tblOrder().GetTime(0);
            new DB2.tblActivity().Add(mActivity);
        }
    }
    #endregion
}