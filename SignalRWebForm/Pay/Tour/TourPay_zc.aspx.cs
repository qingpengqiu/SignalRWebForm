using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
public partial class Pay_Tour_TourPay : PageBase
{
    public string idorder = string.Empty;
    public string stringresult = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["idorder"] != null)
        {
            idorder = TypeChangeDefault.NullToString(Request.QueryString["idorder"].ToString(), "");
        }
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (!IsPostBack)
        {
            DataTable dt = new DB1.tblShopping().GetList("iState=2  and iType=3 and idOrder='" + idorder + "' and idUser=" + CurrentUser.uId).Tables[0];
           if (dt.Rows.Count > 0)
            {
                int id = TypeChangeDefault.NullToInt(dt.Rows[0]["id"].ToString().Trim(), 0);//是否使用积分
                int idUser = TypeChangeDefault.NullToInt(dt.Rows[0]["idUser"].ToString().Trim(), 0);
                int idGood = TypeChangeDefault.NullToInt(dt.Rows[0]["idGood"].ToString().Trim(), 0);
                if (idUser != CurrentUser.uId)
                {
                    AlertHelper.JQAlertGo("您不符合要求！", "/GroupBuy/Group_zc.aspx?id=" + id, false);
                    return;
                }
                int iType = TypeChangeDefault.NullToInt(dt.Rows[0]["iType"].ToString().Trim(), 0);
                if (iType!=3)
                {
                    AlertHelper.JQAlertGo("您不符合要求！","/GroupBuy/GroupList_zc.aspx", false);
                    return;
                }
                DBM1.tblGoods model = new DB1.tblGoods().GetModel(idGood);
                if (model == null)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList_zc.aspx", false);
                    return;
                }
                if (model.iState != 1)
                {
                    AlertHelper.JQAlertGo("该商品不存在！", "/GroupBuy/GroupList_zc.aspx", false);
                    return;
                }
                if (DateTime.Now < model.dBeginTime)
                {
                    AlertHelper.JQAlertGo("还没开始众筹，敬请关注！", "/GroupBuy/GroupList_zc.aspx", false);
                    return;
                }
                if (DateTime.Now > model.dEndTime)
                {
                    AlertHelper.JQAlertGo("众筹已结束，看看其他商品吧！", "/GroupBuy/GroupList_zc.aspx", false);
                    return;
                }
                //ltlImg.Text = "<img src=\"" + dt.Rows[0]["cImage"].ToString() + "\" alt=\"\"/>";                
                LabelTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                ltlTitle.Text = dt.Rows[0]["cGoodName"].ToString();
                Labeltype.Text = dt.Rows[0]["cColor"].ToString() + "/" + dt.Rows[0]["cSize"].ToString();
                ltlNum.Text = dt.Rows[0]["iBuyNum"].ToString();
                Labelcost.Text = dt.Rows[0]["iCost"].ToString();
                int state = TypeChangeDefault.NullToInt(dt.Rows[0]["iState"].ToString().Trim(), 0);
                if (state >= 2)
                {
                    stringresult = "众筹成功";
                }
                else if (state == 1)
                {
                    stringresult = "未付款";
                }
               else
                {
                    stringresult = "已过期";
                }
                if (model.iEntity == 0)
                {
                    stringresult += "    兑换码：" + dt.Rows[0]["cMark4"].ToString(); ;
                }
            }
            else
            {
                AlertHelper.JQAlertGo("您的订单不存在！", "/GroupBuy/GroupList_zc.aspx", false);
                return;
            }
        }
    }
}