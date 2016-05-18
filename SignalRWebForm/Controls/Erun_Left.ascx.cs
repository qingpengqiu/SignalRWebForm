using Erun360.BLL;
using Erun360.Model;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using DB3 = Erun360.BLL.DB3;
using DB2 = Erun360.BLL.DB2;
using DB1 = Erun360.BLL.DB1;
using DBM2 = Erun360.Model.DB2;

public partial class Controls_Erun_Left : PageBaseCtrl
{
    public int uId = 0;//通过参数传递过来的用户id
    private int bId = 0;//博客id
    public string cPageNav = string.Empty;//页面导航
    public string ctips = string.Empty;//页面导航
    protected void Page_Load(object sender, EventArgs e)
    {
        uId = TypeChangeDefault.NullToInt(Request.QueryString["uId"], 0);
        if (CurrentUser != null && uId == 0)
        {
            uId = CurrentUser.uId;
        }
        //if (uId == 0 && CurrentUser == null)
        //{
        //    ctips = "$(\".toast\").html('用户不存在').show().addClass('toast-error'); ";
        //    return;
        //}
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "444", "$(\".toast\").html('用户不存在').show().addClass('toast-success'); errorboxhide()", true);

        //通过参数传递过来的用户id：uId
        //if (!new DB1.tblMEMBER().Exists(uId))
        //{
        //    ctips = "$(\".toast\").html('用户不存在').show().addClass('toast-error'); errorboxhide()";
        //    return;
        //}
        //bId = TypeChangeDefault.NullToInt(Request.QueryString["bId"], 0);
        //if (!new DB2.tblBLOG().Exists(bId))
        //{
        //   ctips = "$(\".toast\").html('博文不存在').show().addClass('toast-error'); errorboxhide()";
        //    return;
        //}

    }
}