using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
public partial class GroupBuy_IntegRallist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        APager.RecordCount = new DB1.tblGoods().GetRecordCount("iState=1 and iType =1  and  dEndTime>GETDATE()");

        BindShop();
    }
    private void BindShop()
    {
        int pagesize = APager.PageSize;
        int pageindex = APager.CurrentPageIndex;
        DB1.tblGoods Bll = new DB1.tblGoods();
        DataTable dttour = Bll.GetListByPage("iState=1 and iType =1  and  dEndTime>GETDATE() ", "iTotal desc", pageindex, pagesize).Tables[0];
        rptTour.DataSource = dttour;
        rptTour.DataBind();

    }
    protected void APager_PageChanged(object sender, EventArgs e)
    {
        BindShop();
    }
}