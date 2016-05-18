using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
public partial class Channels_Competetion_RaceQuery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGoods();
        }
    }
    protected void BindGoods()
    {
        DataSet ds = new DB4.tblRaceResult().GetRace(" iState>0 ");
        match.DataSource = ds.Tables[0];
        match.DataTextField = "cTitle";
        match.DataValueField = "idRace";
        match.DataBind();
    }
}