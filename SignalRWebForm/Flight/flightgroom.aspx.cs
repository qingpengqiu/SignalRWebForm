using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using Erun360.Common;
using System.Data;
using System.Text.RegularExpressions;
using System.Text;

public partial class Flight_flightgroom : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(200218155);
            if (model != null)
            {
                ltlhot.Text = model.cContent.Replace("&lt;", "<").Replace("&gt;", ">").Replace("<p>", "").Replace("</p>", "");
            }
            
        }
    }
}