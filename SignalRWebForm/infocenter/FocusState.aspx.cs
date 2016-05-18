using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class infocenter_FocusState : System.Web.UI.Page
{
    public string pageCount = string.Empty; //总条目数
    private int uId = 0;//通过参数传递过来的用户id
    public string FocusList = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            uId = int.Parse(Request.QueryString["id"].ToString());
        }
        if (uId != 0)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('成功！～','','false');});</script>");
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('失败～','','false');});</script>");
        }
    }
}