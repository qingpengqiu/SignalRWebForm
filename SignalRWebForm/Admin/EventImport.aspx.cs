using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
public partial class Admin_EventImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRace();
        }
    }
    protected void btAllImport_Click(object sender, EventArgs e)
    {

    }
    protected void btPartImport_Click(object sender, EventArgs e)
    {

    }
    protected void BindRace()
    {
        DataSet ds = new DB4.tblEvent().GetAllList();
        ddlRace.DataSource = ds;
        ddlRace.DataTextField = "idRaceTitle";
        ddlRace.DataValueField = "id";
        ddlRace.DataBind();
    }
}