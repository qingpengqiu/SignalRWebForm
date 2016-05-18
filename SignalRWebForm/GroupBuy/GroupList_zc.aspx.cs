using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;

public partial class GroupBuy_GroupList : System.Web.UI.Page
{
    public int id =0;
    protected void Page_Load(object sender, EventArgs e)
    {
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            APager.RecordCount = new DB1.tblGoods().GetRecordCount("iState=1 and iType =3 and  dEndTime>GETDATE() ");
            BindShop();
        }
    }
    private void BindShop()
    {
        int pagesize = APager.PageSize;
        int pageindex = APager.CurrentPageIndex;
        DB1.tblGoods Bll = new DB1.tblGoods();
        //DataTable dttour = Bll.GetList("iState=1 and iType =1").Tables[0];
        //DataTable dttour = Bll.GetListByPage("iState=1 and iType =2 or iType =3  and  dEndTime>GETDATE() ", "id desc", pageindex, pagesize).Tables[0];
        DataTable dttour = new DataTable();
        if (id == 0)//判断众筹商品条件
        {
             dttour = Bll.GetListByPage("iState=1 and iType =3  and  dEndTime>GETDATE() ", "id desc", pageindex, pagesize).Tables[0];
        }
        else
        {
             dttour = Bll.GetListByPage("iState=1 and iType =3 and cMark4 = " + id + " and  dEndTime>GETDATE() ", "id desc", pageindex, pagesize).Tables[0];
        }
        rptTour.DataSource = dttour;
        rptTour.DataBind();
    }

    //public string NewBindShop()
    //{//
        
    //    int pagesize = APager.PageSize;
    //    int pageindex = APager.CurrentPageIndex;
    //    DB1.tblGoods Bll = new DB1.tblGoods();
    //    //DataTable dttour = Bll.GetList("iState=1 and iType =1").Tables[0];
    //    DataTable dttour = Bll.GetListByPage("iState=1 and cMark4 = " + Request.QueryString["id"].ToString() + " and  dEndTime>GETDATE() ", "id desc", pageindex, pagesize).Tables[0];
    //    rptTour.DataSource = dttour;
    //    rptTour.DataBind();
    //    return null;
    //}
    protected void APager_PageChanged(object sender, EventArgs e)
    {
        BindShop();
    }
    DB1.tblTour tourBll = new DB1.tblTour();
    public string GetTour(string idGood)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
        return dt.Rows[0]["fBuyPrice"].ToString();
    }
    //益秒杀
    public string Getems(string idGood)
    {
        int ems = tourBll.GetRecordCount("idGood=" + idGood);
        if (ems==1)
            return "<i>【益秒杀】</i>";
        return "";
    }
    //折扣
    public string Getzk(string idGood, string MarketPrice)
    {
        DataTable dt = tourBll.GetList(1, "idGood=" + idGood, "fBuyPrice").Tables[0];
        if (dt.Rows.Count == 0)
            return "";
         decimal mp = TypeChangeDefault.NullToDecimal(MarketPrice, 1);
         if (mp == 0)
         {
             mp = 1;
         }
       
        return (TypeChangeDefault.NullToDecimal(dt.Rows[0]["fBuyPrice"], 0) / mp * 10).ToString("f");
    }
}