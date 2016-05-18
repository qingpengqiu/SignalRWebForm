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

public partial class Admin_TourEdit : PageBase
{
    private int id = 0;
    private int idgood = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["id"] != null)
        {
            id = Convert.ToInt32(Request.QueryString["id"].ToString());
        }
        if (Request.QueryString["idgood"] != null)
        {
            idgood = Convert.ToInt32(Request.QueryString["idgood"].ToString());
        }
        if (!IsPostBack)
        {
            BindGoods();
            if (id != 0)
            {
                DBM1.tblTour model = new DB1.tblTour().GetModel(id);
                if (model != null)
                {
                    idGood.SelectedValue = model.idGood.ToString();
                    iBuyNum.Value = model.iBuyNum.ToString();
                    fBuyPrice.Value = model.fBuyPrice.ToString();

                }
            }
            if (idgood != 0)
            {
                idGood.SelectedValue = idgood.ToString();
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

        if (CurrentUser.idMemberStyle < 12)
        {
            AlertHelper.JQAlertGo("您没有权限", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        DBM1.tblTour model = new DBM1.tblTour();
        model.idGood = TypeChangeDefault.NullToInt(idGood.SelectedItem.Value, 0);
        model.cName = idGood.SelectedItem.Text;
        model.iBuyNum = TypeChangeDefault.NullToInt(iBuyNum.Value, 0);
        model.fBuyPrice = TypeChangeDefault.NullToDecimal(fBuyPrice.Value, 0);
        model.idUser = CurrentUser.uId;
        model.dCreate = DateTime.Now;
        if (id != 0)
        {
            model.id = id;
            if (new DB1.tblTour().Update(model))
            {
                AlertHelper.JQAlertGo("修改成功！", "TourList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("修改失败，请重试！", false);
            }
        }
        else
        {
            if (new DB1.tblTour().Add(model) > 0)
            {
                AlertHelper.JQAlertGo("添加成功！", "TourList.aspx", true);
            }
            else
            {
                AlertHelper.JQAlert("添加失败，请重试！", false);
            }

        }
    }
    protected void BindGoods()
    {
        DataSet ds = new DB1.tblGoods().GetList(" iState>=0 and idTour=1 ");
        idGood.DataSource = ds.Tables[0];
        idGood.DataTextField = "cName";
        idGood.DataValueField = "id";
        idGood.DataBind();
    }
}