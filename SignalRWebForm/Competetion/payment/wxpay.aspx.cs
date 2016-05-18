using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Competetion_payment_wxpay : System.Web.UI.Page
{
    public string parm = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        parm = TypeChangeDefault.NullToString(Request.QueryString["parm"], "");
    }
}