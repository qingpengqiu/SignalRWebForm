using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using System.Data;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using Newtonsoft.Json;
using System.Text;
using System.IO;
using System.Data.OleDb;
using System.Xml;

public partial class Admin_RaceJion : PageBase
{
    public int idRace = 0;//赛事id
    public int iFromTpye = 2;//订单类型
    public int idItem = 0;//装备下的项目
    public int idItemrSmall = 0;//项目类别
    DB6.tblRace_Competition bll = new DB6.tblRace_Competition();
    DB6.tblOrder bllOrder = new DB6.tblOrder();
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
        idRace = TypeChangeDefault.NullToInt(Request.QueryString["idRace"], 0);
        iFromTpye = TypeChangeDefault.NullToInt(Request.QueryString["iFromTpye"], 2);
        idItem = TypeChangeDefault.NullToInt(Request.QueryString["idItem"], 0);

        if (!IsPostBack)
        {
            BindRace();
            if (idRace == 0)
            {
                //idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
                idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
            }
            DDLRace.Value = idRace.ToString();
            if (iFromTpye == 2)
            {
                rblFromTpye.Items[0].Selected = true;
                iFromTpye = TypeChangeDefault.NullToInt(rblFromTpye.SelectedValue, 0);
            }
            BindItem(iFromTpye, idRace);
            rblFromTpye.ClearSelection();
            rblFromTpye.Items.FindByValue(iFromTpye.ToString()).Selected = true;
            if (idItem != 0)
            {
                //BindItemSmall(iFromTpye, idItem);
                //rblItem.Items[0].Selected = true;
                //idItem = TypeChangeDefault.NullToInt(rblItem.SelectedValue, 0);
                rblItem.ClearSelection();
                rblItem.Items.FindByValue(idItem.ToString()).Selected = true;
                BindData(idRace, iFromTpye, idItem);
            }
            //BindItem(iFromTpye, idRace);
            //rblItem.ClearSelection();
            //rblItem.Items.FindByValue(rblItem.ToString()).Selected = true;
            //BindData(idRace, idItem);
        }
    }
    //绑定赛事
    private void BindRace()
    {
        DataTable dt = bll.GetList(0, "iStatus=1", "id desc").Tables[0];
        DDLRace.DataSource = dt;
        DDLRace.DataTextField = "cTitle";
        DDLRace.DataValueField = "id";
        DDLRace.DataBind();
    }
    //绑定项目
    private void BindItem(int iFromTpye, int idRace)
    {
        if (iFromTpye == 2)
        {
            DB6.tblRace_Item bllitem = new DB6.tblRace_Item();
            DataTable dt = bllitem.GetList(0, "idCompete=" + idRace, "id").Tables[0];
            BindCtrlData(rblItem, dt, "cItemName", "id");
        }
        else if (iFromTpye == 4)//酒店
        {
            DB6.tblHotel bllitem = new DB6.tblHotel();
            DataTable dt = bllitem.GetList(0, "idCompete=" + idRace, "id").Tables[0];
            BindCtrlData(rblItem, dt, "cName", "id");
        }
        else if (iFromTpye == 5)//旅游
        {
            DB6.tbltour bllitem = new DB6.tbltour();
            DataTable dt = bllitem.GetList(0, "idCompete=" + idRace, "id").Tables[0];
            BindCtrlData(rblItem, dt, "cName", "id");
        }
        else if (iFromTpye == 8)//装备
        {
            DB6.tblEquipment bllitem = new DB6.tblEquipment();
            DataTable dt = bllitem.GetList(0, "idCompete=" + idRace, "id").Tables[0];
            BindCtrlData(rblItem, dt, "cName", "id");
        }
        else if (iFromTpye == 9)//附加项
        {
            DB6.tblAnnex bllitem = new DB6.tblAnnex();
            DataTable dt = bllitem.GetList(0, "idCompete=" + idRace, "id").Tables[0];
            BindCtrlData(rblItem, dt, "cName", "id");
        }
    }
    //绑定项目下小项
    private void BindItemSmall(int iFromTpye, int idItem)
    {
        if (iFromTpye == 4)//酒店
        {
            DB6.tblHotel_Item bllitem = new DB6.tblHotel_Item();
            DataTable dt = bllitem.GetList(0, "idHotel=" + idItem, "id").Tables[0];
            BindCtrlData(rblitemSmall, dt, "cItemName", "id");
        }
        else if (iFromTpye == 5)//旅游
        {
            DB6.tbltour_Item bllitem = new DB6.tbltour_Item();
            DataTable dt = bllitem.GetList(0, "idEquipment=" + idItem, "id").Tables[0];
            BindCtrlData(rblitemSmall, dt, "cItemName", "id");
        }
        else if (iFromTpye == 8)//装备
        {
            DB6.tblEquipment_Item bllitem = new DB6.tblEquipment_Item();
            DataTable dt = bllitem.GetList(0, "idEquipment=" + idItem, "id").Tables[0];
            BindCtrlData(rblitemSmall, dt, "cItemName", "id");
        }

    }
    private void BindCtrlData(RadioButtonList Ctl, DataTable dt, string name, string id)
    {
        Ctl.DataSource = dt;
        Ctl.DataTextField = name;
        Ctl.DataValueField = id;
        Ctl.DataBind();
    }
    private void BindData(int cFromToID, int iFromTpye, int idItem)
    {
        DataTable dt = new DataTable();
        if (iFromTpye == 2)
        {
            dt = bllOrder.GetList(0, "iFromTpye=" + iFromTpye + " and cFromToID=" + cFromToID + " and iTypeID=" + cFromToID + " and iItemID=" + idItem, "dConfirmTime desc,iStatus desc").Tables[0];
        }
        else if (iFromTpye == 9)
        {
            dt = bllOrder.GetList(0, "iFromTpye=" + iFromTpye + " and cFromToID=" + cFromToID + " and iItemID=" + idItem, "dConfirmTime desc,iStatus desc").Tables[0];
        }
        else
        {
            dt = bllOrder.GetList(0, "iFromTpye=" + iFromTpye + " and cFromToID=" + cFromToID + " and iTypeID=" + idItem, "dConfirmTime desc,iStatus desc").Tables[0];
        }
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }
    protected void DDLRace_SelectedIndexChanged(object sender, EventArgs e)
    {
        //idRace = TypeChangeDefault.NullToInt(DDLRace.SelectedValue, 0);
        idRace = TypeChangeDefault.NullToInt(DDLRace.Value, 0);
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye);
    }
    protected void rblFromTpye_SelectedIndexChanged(object sender, EventArgs e)
    {
        iFromTpye = TypeChangeDefault.NullToInt(rblFromTpye.SelectedValue, 2);
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye);
    }
    protected void rblItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        idItem = TypeChangeDefault.NullToInt(rblItem.SelectedValue, 0);
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem);
    }
    protected void rblitemSmall_SelectedIndexChanged(object sender, EventArgs e)
    {
        idItemrSmall = TypeChangeDefault.NullToInt(rblitemSmall.SelectedValue, 0);
        Response.Redirect("RaceJion.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&idItemrSmall=" + idItemrSmall);
    }
    protected string GetBMinfo(string id)
    {
        StringBuilder sb = new StringBuilder();
        StringBuilder sbFileup = new StringBuilder();
        DBM6.tblOrder model = bllOrder.GetModel(TypeChangeDefault.NullToInt(id, 0));
        if (model != null)
        {
            if (model.iStatus >= 2)
            {
                if (model.iFromTpye == 2)
                {
                    DataTable dt = new DB6.tblRace_Detail().GetList("cOrder_no='" + model.cOrder_no + "'").Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["cCloth"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["cFullname"], "") + "</td>");
                        sb.AppendFormat("<td>{0}</td>", TypeChangeDefault.NullToString(dt.Rows[0]["cGender"], "") == "0" ? "男" : "女");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["IdNo"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["cMobile"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["cMail"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[0]["cCityname"], "") + TypeChangeDefault.NullToString(dt.Rows[0]["cAddress"], "") + "</td>");
                        //附件
                        string cHealthUrl = TypeChangeDefault.NullToString(dt.Rows[0]["cHealthUrl"].ToString(), "");
                        string cECG = TypeChangeDefault.NullToString(dt.Rows[0]["cECG"].ToString(), "");
                        string cFinished = TypeChangeDefault.NullToString(dt.Rows[0]["cFinished"].ToString(), "");
                        string cMake = TypeChangeDefault.NullToString(dt.Rows[0]["cMake"].ToString(), "");
                        string cMake1 = TypeChangeDefault.NullToString(dt.Rows[0]["cMake1"].ToString(), "");
                        string cMake2 = TypeChangeDefault.NullToString(dt.Rows[0]["cMake2"].ToString(), "");
                        string idCompete = TypeChangeDefault.NullToString(dt.Rows[0]["idCompete"].ToString(), "0");
                        string idUser = TypeChangeDefault.NullToString(dt.Rows[0]["idUser"].ToString(), "0");
                        if (dt.Rows[0]["cHealthUrl"] != null)
                        {
                            if (cHealthUrl.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cHealthUrl.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        if (cECG != null)
                        {
                            if (cECG.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cECG.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        if (cFinished != null)
                        {
                            if (cFinished.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cFinished.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        if (cMake != null)
                        {
                            if (cMake.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cMake.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        if (cMake1 != null)
                        {
                            if (cMake1.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cMake1.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        if (cMake2 != null)
                        {
                            if (cMake2.Contains(GetDir(idCompete)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                            else if (cMake2.Contains(GetDir(idUser)))
                            {
                                sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                            }
                        }
                        sb.AppendLine("<td>" + sbFileup.ToString() + "</td>");
                    }
                }
                else if (model.iFromTpye == 4)
                {
                    sb.AppendLine("<td>" + model.cName + "</td>");
                    sb.AppendLine("<td>" + model.cMobile + "</td>");
                    sb.AppendLine("<td>" + model.cMail + "</td>");
                    sb.AppendLine("<td>" + model.cMake2 + "</td>");
                    DataTable dt = new DB6.tblHotel_Detail().GetList("cOrder_no='" + model.cOrder_no + "'").Tables[0];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sbFileup.Append(TypeChangeDefault.NullToString(dt.Rows[i]["cFullname"], "") + ",");
                    }
                    sb.AppendLine("<td>" + sbFileup.ToString().TrimEnd(',') + "</td>");
                }
                else if (model.iFromTpye == 5)
                {
                    DataTable dt = new DB6.tbltour_Detail().GetList("cOrder_no='" + model.cOrder_no + "'").Tables[0];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cFullname"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cMobile"], "") + "</td>");
                    }
                }
                else if (model.iFromTpye == 8)
                {
                    DataTable dt = new DB6.tblEquipment_Detail().GetList("cOrder_no='" + model.cOrder_no + "'").Tables[0];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cFullname"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cMobile"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cAddress"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cMake2"], "") + "</td>");
                    }
                }
                else if (model.iFromTpye == 9)
                {
                    DataTable dt = new DB6.tblAnnex_Detail().GetList("cOrder_no='" + model.cOrder_no + "'").Tables[0];
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cFullname"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cMobile"], "") + "</td>");
                        sb.AppendLine("<td>" + TypeChangeDefault.NullToString(dt.Rows[i]["cCityname"], "") + TypeChangeDefault.NullToString(dt.Rows[i]["cMobile"], "") + "</td>");
                    }
                }
            }
            else
            {
                if (model.iFromTpye == 2)
                {
                    var x = JsonConvert.DeserializeObject<DBM6.tblRace_Detail>(model.passenger);
                    sb.AppendLine("<td>" + x.cCloth + "</td>");
                    sb.AppendLine("<td>" + x.cFullname + "</td>");
                    sb.AppendFormat("<td>{0}</td>", x.cGender == "0" ? "男" : "女");
                    sb.AppendLine("<td>" + x.IdNo + "</td>");
                    sb.AppendLine("<td>" + x.cMobile + "</td>");
                    sb.AppendLine("<td>" + x.cMail + "</td>");
                    sb.AppendLine("<td>" + x.cCityname + x.cAddress + "</td>");

                    if (x.cHealthUrl != null)
                    {
                        if (x.cHealthUrl.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cHealthUrl.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cHealthUrl + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }
                    if (x.cECG != null)
                    {
                        if (x.cECG.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cECG.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cECG + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }
                    if (x.cFinished != null)
                    {
                        if (x.cFinished.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cFinished.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cFinished + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }

                    if (x.cMake != null)
                    {
                        if (x.cMake.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cMake.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cMake + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }

                    if (x.cMake1 != null)
                    {
                        if (x.cMake1.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cMake1.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cMake1 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }

                    if (x.cMake2 != null)
                    {
                        if (x.cMake2.Contains(GetDir(x.idCompete.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + x.cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                        else if (x.cMake2.Contains(GetDir(x.idUser.ToString())))
                        {
                            sbFileup.AppendFormat("<a target='_blank' href='" + @"http://img.erun360.com/Utility/Uploads/" + x.cMake2 + "'><img src='/Html/images/img_icon.png'/></a>");
                        }
                    }

                    sb.AppendLine("<td>" + sbFileup.ToString() + "</td>");
                }
                else if (model.iFromTpye == 4)
                {
                    sb.AppendLine("<td>" + model.cName + "</td>");
                    sb.AppendLine("<td>" + model.cMobile + "</td>");
                    sb.AppendLine("<td>" + model.cMail + "</td>");
                    sb.AppendLine("<td>" + model.cMake2 + "</td>");
                    List<DBM6.tblHotel_Detail> userlist = JsonConvert.DeserializeObject<List<DBM6.tblHotel_Detail>>(model.passenger);
                    foreach (DBM6.tblHotel_Detail x in userlist)
                    {
                        sbFileup.Append(x.cFullname + ",");
                    }
                    sb.AppendLine("<td>" + sbFileup.ToString().TrimEnd(',') + "</td>");
                }
                else if (model.iFromTpye == 5)
                {
                    var x = JsonConvert.DeserializeObject<DBM6.tbltour_Detail>(model.passenger);
                    sb.AppendLine("<td>" + x.cFullname + "</td>");
                    sb.AppendLine("<td>" + x.cMobile + "</td>");
                }
                else if (model.iFromTpye == 8)
                {
                    var x = JsonConvert.DeserializeObject<DBM6.tblEquipment_Detail>(model.passenger);
                    sb.AppendLine("<td>" + x.cFullname + "</td>");
                    sb.AppendLine("<td>" + x.cMobile + "</td>");
                    sb.AppendLine("<td>" + x.cAddress + "</td>");
                    sb.AppendLine("<td>" + x.cMake2 + "</td>");
                }
                else if (model.iFromTpye == 9)
                {
                    var x = JsonConvert.DeserializeObject<DBM6.tblAnnex_Detail>(model.passenger);
                    sb.AppendLine("<td>" + x.cFullname + "</td>");
                    sb.AppendLine("<td>" + x.cMobile + "</td>");
                    sb.AppendLine("<td>" + x.cCityname + x.cAddress + "</td>");
                }
            }
        }
        return sb.ToString();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Header)
        {
            if (e.Item.FindControl("ltlNav") != null)
            {
                Literal ltlnav = e.Item.FindControl("ltlNav") as Literal;
                if (iFromTpye == 2)
                {
                    ltlnav.Text = "<td>尺码</td><td>姓名</td><td>性别</td><td>证件号码</td><td>联系方式</td><td>邮箱</td><td>城市</td><td>附件</td>";
                }
                else if (iFromTpye == 4)
                {
                    ltlnav.Text = "<td>姓名</td><td>联系方式</td><td>邮箱</td><td>备注</td><td>订单人员</td>";
                }
                else if (iFromTpye == 5)
                {
                    ltlnav.Text = "<td>姓名</td><td>联系方式</td>";
                }
                else if (iFromTpye == 8)
                {
                    ltlnav.Text = "<td>姓名</td><td>联系方式</td><td>地址</td><td>备注</td>";
                }
                else if (iFromTpye == 9)
                {
                    ltlnav.Text = "<td>姓名</td><td>联系方式</td><td>地址</td>";
                }
            }
        }
    }

    protected string GetUserInfo(string id)
    {
        StringBuilder sb = new StringBuilder();
        DBM6.tblOrder model = bllOrder.GetModel(TypeChangeDefault.NullToInt(id, 0));
        if (model != null)
        {
            if (model.iStatus >= 2)
            {
                if (model.iFromTpye == 2)
                {
                    sb.AppendLine("<a href=\"RaceJionEdit.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改用户信息</a>");
                }
                else if (model.iFromTpye == 4)//酒店
                {
                    sb.AppendLine("<a href=\"RaceJionHotelEdit.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改用户信息</a>");
                }
                else if (model.iFromTpye == 5)//旅游
                {
                    sb.AppendLine("<a href=\"RaceJionotherEdit.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改用户信息</a>");
                }
                else if (model.iFromTpye == 8)//推荐装备
                {
                    sb.AppendLine("<a href=\"RaceJionotherEdit.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改用户信息</a>");
                }
                else if (model.iFromTpye == 9)//附属产品
                {
                    sb.AppendLine("<a href=\"RaceJionotherEdit.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改用户信息</a>");
                }

            }
            else
            {
                sb.AppendLine("<a href=\"RaceJionStatus.aspx?idRace=" + idRace + "&iFromTpye=" + iFromTpye + "&idItem=" + idItem + "&id=" + id + "\" target=\"_self\">修改状态</a>");

            }
        }

        return sb.ToString();
    }
    //导出用户信息
    protected void btnExecl_Click(object sender, EventArgs e)
    {
        string name = DateTime.Now.ToString("yyyyMMddhhmmss");
        string filePath = Server.MapPath(string.Format("~/Admin/Template/{0}.xls", name));
        try
        {
            DataTable dt = new DataTable();
            StringBuilder sbcn = new StringBuilder();
            StringBuilder sben = new StringBuilder();
            if (iFromTpye == 2)
            {
                DB6.tblRace_Detail bll = new DB6.tblRace_Detail();
                sbcn.Append("[赛事名称],[项目名称],[姓名],[性别],[血型],[出生日期],[证件类型],[证件号码],[联系方式]");
                sbcn.Append(",[邮箱],[城市],[地址],[邮编],[职业],[学历],[紧急联系人],[国籍],[尺码],[鞋号]");
                sbcn.Append(",[体检证明],[位置1],[位置2],[位置3],[位置4],[位置5],[护照签发地点],[签发日期],[有效期至],[订单号],[付款时间],[用户编号],[组队编号]");
                //sbcn.Append(",[审核批注]");
                //sbcn.Append(",[交易号],[使用积分],[审核批注],[价格]");

                sben.Append("@cCompetitionName,@cItemName,@cFullname,@cGender,@idBlood,@dBirthday,@IdType,@IdNo,@cMobile");
                sben.Append(",@cMail,@cCityname,@cAddress,@cZipcode,@idOccupation,@idEducation,@cEmergerContact,@cNational,@cCloth,@cShoe");
                sben.Append(",@cHealthUrl,@cECG,@cFinished,@cMake,@cMake1,@cMake2,@cPlace,@dIssue,@dExpiry,@cOrder_no,@dCreate,@idUser,@idTeam ");
                //sben.Append(",@postil");
                //sben.Append(",@cTrade_no,@iScore,@cMake3,@iCost");
                if (idItem > 0)
                {
                    dt = bll.GetList(0, "idCompete=" + idRace + " and idItem=" + idItem, "dCreate").Tables[0];
                }
                else
                {
                    dt = bll.GetList(0, "idCompete=" + idRace, "dCreate").Tables[0];
                }
                File.Copy(Server.MapPath("~/Admin/Template/bmexecl.xls"), filePath);
                // 使用OleDb驱动程序连接到副本
                OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
                using (conn)
                {
                    conn.Open();
                    // 增加记录
                    foreach (DataRow item in dt.Rows)
                    {
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                        cmd.Parameters.AddWithValue("@cCompetitionName", item["cCompetitionName"].ToString());
                        cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                        cmd.Parameters.AddWithValue("@cFullname", item["cFullname"].ToString());
                        if (item["cGender"].ToString() == "0")
                        { cmd.Parameters.AddWithValue("@cGender", "男"); }
                        else { cmd.Parameters.AddWithValue("@cGender", "女"); }

                        if (item["idBlood"].ToString() == "0")
                        { cmd.Parameters.AddWithValue("@idBlood", "A"); }
                        else if (item["idBlood"].ToString() == "1")
                        { cmd.Parameters.AddWithValue("@idBlood", "B"); }
                        else if (item["idBlood"].ToString() == "2")
                        { cmd.Parameters.AddWithValue("@idBlood", "O"); }
                        else if (item["idBlood"].ToString() == "3")
                        { cmd.Parameters.AddWithValue("@idBlood", "AB"); }
                        else
                        { cmd.Parameters.AddWithValue("@idBlood", "其他"); }
                        cmd.Parameters.AddWithValue("@dBirthday", TypeChangeDefault.NullToDateTime(item["dBirthday"].ToString(), DateTime.Now).ToString("yyyy-MM-dd"));
                        if (item["IdType"].ToString() == "1")
                        { cmd.Parameters.AddWithValue("@IdType", "身份证"); }
                        else if (item["IdType"].ToString() == "2")
                        { cmd.Parameters.AddWithValue("@IdType", "军官证"); }
                        else if (item["IdType"].ToString() == "3")
                        { cmd.Parameters.AddWithValue("@IdType", "户口本"); }
                        else if (item["IdType"].ToString() == "4")
                        { cmd.Parameters.AddWithValue("@IdType", "其他"); }
                        else
                        { cmd.Parameters.AddWithValue("@IdType", "未选择"); }

                        cmd.Parameters.AddWithValue("@IdNo", item["IdNo"].ToString());
                        cmd.Parameters.AddWithValue("@cMobile", item["cMobile"].ToString());


                        cmd.Parameters.AddWithValue("@cMail", item["cMail"].ToString());
                        cmd.Parameters.AddWithValue("@cCityname", item["cCityname"].ToString());
                        cmd.Parameters.AddWithValue("@cAddress", item["cAddress"].ToString());
                        cmd.Parameters.AddWithValue("@cZipcode", item["cZipcode"].ToString());

                        cmd.Parameters.AddWithValue("@idOccupation", GetidOccupation(item["idOccupation"].ToString()));
                        if (item["idEducation"].ToString() == "1")
                        { cmd.Parameters.AddWithValue("@idEducation", "大专"); }
                        else if (item["idEducation"].ToString() == "2")
                        { cmd.Parameters.AddWithValue("@idEducation", "本科"); }
                        else if (item["idEducation"].ToString() == "3")
                        { cmd.Parameters.AddWithValue("@idEducation", "研究生"); }
                        else if (item["idEducation"].ToString() == "4")
                        { cmd.Parameters.AddWithValue("@idEducation", "博士"); }
                        else if (item["idEducation"].ToString() == "5")
                        { cmd.Parameters.AddWithValue("@idEducation", "硕士"); }
                        else
                        { cmd.Parameters.AddWithValue("@idEducation", "其他"); }
                        //cmd.Parameters.AddWithValue("@idEducation", item["idEducation"].ToString());
                        cmd.Parameters.AddWithValue("@cEmergerContact", item["cEmergerContact"].ToString());
                        cmd.Parameters.AddWithValue("@cNational", item["cNational"].ToString());
                        cmd.Parameters.AddWithValue("@cCloth", item["cCloth"].ToString());
                        cmd.Parameters.AddWithValue("@cShoe", item["cShoe"].ToString());
                        //sben.Append(",@cHealthUrl,@cECG,@cFinished,@cMake,@cMake1,@cMake2,@cPlace,@dIssue,@dExpiry");
                        cmd.Parameters.AddWithValue("@cHealthUrl", item["cHealthUrl"].ToString());
                        cmd.Parameters.AddWithValue("@cECG", item["cECG"].ToString());
                        cmd.Parameters.AddWithValue("@cFinished", item["cFinished"].ToString());
                        cmd.Parameters.AddWithValue("@cMake", item["cMake"].ToString());
                        cmd.Parameters.AddWithValue("@cMake1", item["cMake1"].ToString());
                        cmd.Parameters.AddWithValue("@cMake2", item["cMake2"].ToString());
                        cmd.Parameters.AddWithValue("@cPlace", item["cPlace"].ToString());
                        cmd.Parameters.AddWithValue("@dIssue", TypeChangeDefault.NullToDateTime(item["dIssue"].ToString(), DateTime.Now).ToString("yyyy-MM-dd"));
                        cmd.Parameters.AddWithValue("@dExpiry", TypeChangeDefault.NullToDateTime(item["dExpiry"].ToString(), DateTime.Now).ToString("yyyy-MM-dd"));
                        //cmd.Parameters.AddWithValue("@dIssue", item["dIssue"].ToString());
                        //cmd.Parameters.AddWithValue("@dExpiry", item["dExpiry"].ToString());
                        //sben.Append(",@cOrder_no,@dCreate,@cTrade_no,@iScore,@cMake3,@iCost");
                        cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                        cmd.Parameters.AddWithValue("@dCreate", item["dCreate"].ToString());
                        cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());
                        //cmd.Parameters.AddWithValue("@cTrade_no", item["cTrade_no"].ToString());
                        //cmd.Parameters.AddWithValue("@iScore", item["iScore"].ToString());
                        //cmd.Parameters.AddWithValue("@cMake3", item["cMake3"].ToString());
                        if (idItem > 0)
                        {
                            cmd.Parameters.AddWithValue("@idTeam", GetTeamID(idItem.ToString(), item["idUser"].ToString()));
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@idTeam", GetTeamID(item["idItem"].ToString(), item["idUser"].ToString()));
                        }

                        //cmd.Parameters.AddWithValue("@postil", GetPostil(item["idUser"].ToString(), item["idCompete"].ToString(), item["idItem"].ToString()));

                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }
            }
            else if (iFromTpye == 4)
            {
                DB6.tblHotel_Detail bll = new DB6.tblHotel_Detail();
                dt = bll.GetList(0, "idCompete=" + idRace, "dCreate").Tables[0];
                sbcn.Append("[赛事名称],[名称],[项目名称],[姓名],[证件号码],[付款时间],[订单号],[用户编号]");
                sben.Append("@cCompetitionName,@cName,@cItemName,@cFullname,@IdNo,@dCreate,@cOrder_no,@idUser");
                File.Copy(Server.MapPath("~/Admin/Template/jdexecl.xls"), filePath);
                // 使用OleDb驱动程序连接到副本
                OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
                using (conn)
                {
                    conn.Open();
                    // 增加记录
                    foreach (DataRow item in dt.Rows)
                    {
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                        cmd.Parameters.AddWithValue("@cCompetitionName", item["cCompetitionName"].ToString());
                        DBM6.tblHotel_Item model = new DB6.tblHotel_Item().GetModel(TypeChangeDefault.NullToInt(item["idItem"].ToString(), 0));
                        if (model != null)
                        {
                            cmd.Parameters.AddWithValue("@cName", model.cHotelName);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@cName", "");
                        }
                        cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                        cmd.Parameters.AddWithValue("@cFullname", item["cFullname"].ToString());
                        cmd.Parameters.AddWithValue("@IdNo", item["IdNo"].ToString());
                        cmd.Parameters.AddWithValue("@dCreate", item["dCreate"].ToString());
                        cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                        cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }
            }
            else if (iFromTpye == 5)
            {
                DB6.tbltour_Detail bll = new DB6.tbltour_Detail();
                dt = bll.GetList(0, "idCompete=" + idRace, "dCreate").Tables[0];
                sbcn.Append("[赛事名称],[名称],[项目名称],[姓名],[电话],[地址],[备注],[付款时间],[订单号],[用户编号]");
                sben.Append("@cCompetitionName,@cName,@cItemName,@cFullname,@cMobile,@cAddress,@cMake2,@dCreate,@cOrder_no,@idUser");
                File.Copy(Server.MapPath("~/Admin/Template/lvexecl.xls"), filePath);
                // 使用OleDb驱动程序连接到副本
                OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
                using (conn)
                {
                    conn.Open();
                    // 增加记录
                    foreach (DataRow item in dt.Rows)
                    {
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                        cmd.Parameters.AddWithValue("@cCompetitionName", item["cCompetitionName"].ToString());
                        DBM6.tbltour_Item model = new DB6.tbltour_Item().GetModel(TypeChangeDefault.NullToInt(item["idItem"].ToString(), 0));
                        if (model != null)
                        {
                            cmd.Parameters.AddWithValue("@cName", model.cEquipmentName);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@cName", "");
                        }
                        cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                        cmd.Parameters.AddWithValue("@cFullname", item["cFullname"].ToString());
                        cmd.Parameters.AddWithValue("@cMobile", item["cMobile"].ToString());
                        cmd.Parameters.AddWithValue("@cAddress", item["cAddress"].ToString());
                        cmd.Parameters.AddWithValue("@cMake2", item["cMake2"].ToString());
                        cmd.Parameters.AddWithValue("@dCreate", item["dCreate"].ToString());
                        cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                        cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());

                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }
            }
            else if (iFromTpye == 8)
            {
                DB6.tblEquipment_Detail bll = new DB6.tblEquipment_Detail();
                dt = bll.GetList(0, "idCompete=" + idRace, "dCreate").Tables[0];
                sbcn.Append("[赛事名称],[名称],[项目名称],[姓名],[电话],[地址],[备注],[付款时间],[订单号],[用户编号]");
                sben.Append("@cCompetitionName,@cName,@cItemName,@cFullname,@cMobile,@cAddress,@cMake2,@dCreate,@cOrder_no,@idUser");
                File.Copy(Server.MapPath("~/Admin/Template/lvexecl.xls"), filePath);
                // 使用OleDb驱动程序连接到副本
                OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
                using (conn)
                {
                    conn.Open();
                    // 增加记录
                    foreach (DataRow item in dt.Rows)
                    {
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                        cmd.Parameters.AddWithValue("@cCompetitionName", item["cCompetitionName"].ToString());
                        DBM6.tblEquipment_Item model = new DB6.tblEquipment_Item().GetModel(TypeChangeDefault.NullToInt(item["idItem"].ToString(), 0));
                        if (model != null)
                        {
                            cmd.Parameters.AddWithValue("@cName", model.cEquipmentName);
                        }
                        else
                        {
                            cmd.Parameters.AddWithValue("@cName", "");
                        }
                        cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                        cmd.Parameters.AddWithValue("@cFullname", item["cFullname"].ToString());
                        cmd.Parameters.AddWithValue("@cMobile", item["cMobile"].ToString());
                        cmd.Parameters.AddWithValue("@cAddress", item["cAddress"].ToString());
                        cmd.Parameters.AddWithValue("@cMake2", item["cMake2"].ToString());
                        cmd.Parameters.AddWithValue("@dCreate", item["dCreate"].ToString());
                        cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                        cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());

                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }
            }
            else if (iFromTpye == 9)
            {
                DB6.tblAnnex_Detail bll = new DB6.tblAnnex_Detail();
                dt = bll.GetList(0, "idCompete=" + idRace, "dCreate").Tables[0];
                sbcn.Append("[赛事名称],[项目名称],[姓名],[电话],[城市],[地址],[邮箱],[付款时间],[订单号],[用户编号]");
                sben.Append("@cCompetitionName,@cItemName,@cFullname,@cMobile,@cCityname,@cAddress,@cMail,@dCreate,@cOrder_no,@idUser");
                File.Copy(Server.MapPath("~/Admin/Template/fsexecl.xls"), filePath);
                // 使用OleDb驱动程序连接到副本
                OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
                using (conn)
                {
                    conn.Open();
                    // 增加记录
                    foreach (DataRow item in dt.Rows)
                    {
                        OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                        cmd.Parameters.AddWithValue("@cCompetitionName", item["cCompetitionName"].ToString());
                        cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                        cmd.Parameters.AddWithValue("@cFullname", item["cFullname"].ToString());
                        cmd.Parameters.AddWithValue("@cMobile", item["cMobile"].ToString());
                        cmd.Parameters.AddWithValue("@cCityname", item["cCityname"].ToString());
                        cmd.Parameters.AddWithValue("@cAddress", item["cAddress"].ToString());
                        cmd.Parameters.AddWithValue("@cMail", item["cMail"].ToString());
                        cmd.Parameters.AddWithValue("@dCreate", item["dCreate"].ToString());
                        cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                        cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());

                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                }
            }
            // 根据模板文件创建副本
            // 输出副本的二进制字节流
            Response.ContentType = "application/ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + name + ".xls");
            Response.BinaryWrite(File.ReadAllBytes(filePath));

            // 删除副本
            File.Delete(filePath);
        }
        catch
        { // 删除副本
            File.Delete(filePath);
        }
        finally
        {  // 删除副本
            File.Delete(filePath);
        }
    }
    //导出订单信息
    protected void btnAllEcexl_Click(object sender, EventArgs e)
    {
        string name = DateTime.Now.ToString("yyyyMMddhhmmss");
        string filePath = Server.MapPath(string.Format("~/Admin/Template/{0}.xls", name));
        try
        {
            DataTable dt = new DataTable();
            StringBuilder sbcn = new StringBuilder();
            StringBuilder sben = new StringBuilder();
            DB6.tblOrder bll = new DB6.tblOrder();
            dt = bll.GetList(0, "cFromToID=" + idRace + " and iFromTpye= " + iFromTpye + " and iStatus>=2", "iItemID").Tables[0];
            File.Copy(Server.MapPath("~/Admin/Template/ddexecl.xls"), filePath);
            // 根据模板文件创建副本
            sbcn.Append("[赛事名称],[名称],[项目名称],[数量],[积分],[兑换钱],[原价],[交易价],[姓名],[电话]");
            sbcn.Append(",[邮箱],[城市],[地址],[备注],[审核批注],[交易号],[付款时间],[订单号],[用户编码],[来源]");

            sben.Append("@cFromToName,@iTypeName,@cItemName,@iBuyNum,@iScore,@iMoney,@fPrice,@iCost,@cName,@cMobile");
            sben.Append(",@cMail,@cCityname,@cAddress,@cMake2,@cMake3,@cTrade_no,@dPayTime,@cOrder_no,@idUser,@cFrom");

            // 使用OleDb驱动程序连接到副本
            OleDbConnection conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");
            using (conn)
            {
                conn.Open();
                // 增加记录
                foreach (DataRow item in dt.Rows)
                {
                    OleDbCommand cmd = new OleDbCommand("INSERT INTO [Sheet1$](" + sbcn.ToString() + ") VALUES(" + sben.ToString() + ")", conn);

                    cmd.Parameters.AddWithValue("@cFromToName", item["cFromToName"].ToString());
                    cmd.Parameters.AddWithValue("@iTypeName", item["iTypeName"].ToString());
                    cmd.Parameters.AddWithValue("@cItemName", item["cItemName"].ToString());
                    cmd.Parameters.AddWithValue("@iBuyNum", item["iBuyNum"].ToString());
                    cmd.Parameters.AddWithValue("@iScore", item["iScore"].ToString());
                    if (TypeChangeDefault.NullToInt(item["iMoney"], 0) == 0 && TypeChangeDefault.NullToInt(item["iScore"], 0) > 0)
                    {
                        cmd.Parameters.AddWithValue("@iMoney", TypeChangeDefault.NullToDecimal(item["iScore"], 0) * 0.01M);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@iMoney", item["iMoney"].ToString());
                    }
                    cmd.Parameters.AddWithValue("@fPrice", item["fPrice"].ToString());
                    cmd.Parameters.AddWithValue("@iCost", item["iCost"].ToString());
                    cmd.Parameters.AddWithValue("@cName", item["cName"].ToString());
                    cmd.Parameters.AddWithValue("@cMobile", item["cMobile"].ToString());
                    cmd.Parameters.AddWithValue("@cMail", item["cMail"].ToString());
                    cmd.Parameters.AddWithValue("@cCityname", item["cCityname"].ToString());
                    cmd.Parameters.AddWithValue("@cAddress", item["cAddress"].ToString());

                    cmd.Parameters.AddWithValue("@cMake2", item["cMake2"].ToString());
                    cmd.Parameters.AddWithValue("@cMake3", item["cMake3"].ToString());
                    //合并付款需要联系后台管理员进行处理，
                    //if (item["cParentOrder"].ToString().Length > 0)
                    //{
                    //    DataTable dtp = bll.GetList(1, "cOrder_no='" + item["cParentOrder"].ToString() + "' and iStatus>=2", "iItemID").Tables[0];
                    //    cmd.Parameters.AddWithValue("@cTrade_no", dtp.Rows[0]["cTrade_no"].ToString());
                    //}
                    //else
                    //{
                    //    cmd.Parameters.AddWithValue("@cTrade_no", item["cTrade_no"].ToString());
                    //}
                    cmd.Parameters.AddWithValue("@cTrade_no", item["cTrade_no"].ToString());

                    cmd.Parameters.AddWithValue("@dPayTime", item["dPayTime"].ToString());
                    cmd.Parameters.AddWithValue("@cOrder_no", item["cOrder_no"].ToString());
                    cmd.Parameters.AddWithValue("@idUser", item["idUser"].ToString());
                    cmd.Parameters.AddWithValue("@cFrom", item["cFrom"].ToString());

                    cmd.ExecuteNonQuery();
                    cmd.Dispose();
                }
            }
            // 输出副本的二进制字节流
            Response.ContentType = "application/ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + name + ".xls");
            Response.BinaryWrite(File.ReadAllBytes(filePath));

            // 删除副本
            File.Delete(filePath);
        }
        catch (Exception ex)
        { // 删除副本
            File.Delete(filePath);
        }
        finally
        {  // 删除副本
            File.Delete(filePath);
        }
    }

    public string GetidOccupation(string id)
    {
        XmlDocument xmlDoc = new XmlDocument();
        xmlDoc.Load(Server.MapPath("/XML/Strings.xml"));
        XmlNodeList xmlNodeList = xmlDoc.SelectNodes("Strings/idOccupations/idOccupation[ValueField='" + id + "']");//查找
        XmlNode xmlNode = xmlNodeList.Item(0);
        return xmlNode["TextField"].InnerText;
    }

    //根据项目id和用户id获取当前用户的组队编号
    public string GetTeamID(string idItem, string IdUser)
    {
        DB6.tblTeam BLLTeam = new DB6.tblTeam();
        DataTable dt = BLLTeam.GetList("idItem=" + idItem + " and IdUser=" + IdUser).Tables[0];
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0]["iSNo"].ToString();
        }
        return "";
    }
    //根据获取审核批注
    public string GetPostil(string IdUser, string idCompete, string idItem)
    {

        DataTable dt = bllOrder.GetList(" idUser =" + IdUser + "  and iFromTpye=2 and iTypeID=" + idCompete + " and iStatus >=2 and iItemID=" + idItem).Tables[0];
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0]["cMake3"].ToString();
        }
        return "";
    }
}