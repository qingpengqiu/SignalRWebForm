using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using System.Data;
public partial class infocenter_ShoeFind : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //BindBrand();
    }
    /////绑定职业
    //protected void BindBrand()
    //{
    //    DataSet ds = new DB5.tblShoes().GetBrand();
    //    ddlZZS.DataSource = ds;
    //    ddlZZS.DataTextField = "cBrand";
    //    ddlZZS.DataValueField = "cBrand";
    //    ddlZZS.DataBind();
    //}
}