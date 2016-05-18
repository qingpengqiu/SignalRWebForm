using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utils;
using DB6 = Erun360.BLL.DB6;
using DBM6 = Erun360.Model.DB6;
using System.Text;
public partial class Admin_Backstage_Advertisem : PageBase
{
    public int id = 0;
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
            return;
        }
        id = TypeChangeDefault.NullToInt(Request.QueryString["id"], 0);
        if (!IsPostBack)
        {
            if (id != 0)
            {
                DBM6.tblAdvert_Nav_Config adt = new DB6.tblAdvert_Nav_Config().GetModel(id);
                cName.Value = adt.cName;
                //cLickurl.Value = adt.cLickurl;
                //cAtou.Value = adt.cAtou.ToString();
                cHeight.Value = adt.Height;
                cWidth.Value = adt.Width;
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
        if (cName.Value == string.Empty)
        {
            AlertHelper.JQAlertGo("广告名称不能为空！!", "", false);
            return;
        }
        DBM6.tblAdvert_Nav_Config mdol = new DBM6.tblAdvert_Nav_Config();
        mdol.cName = cName.Value.Trim();
        //mdol.cAtou = TypeChangeDefault.NullToInt(cAtou.Value, -1);
        //mdol.cLickurl = cLickurl.Value;
        mdol.Width = cWidth.Value.Trim();
        mdol.Height = cHeight.Value.Trim();
        if (id == 0)
        {
            new DB6.tblAdvert_Nav_Config().Add(mdol);
            AlertHelper.JQAlertGo("保存成功!", "Advertisemlb.aspx", true);
        }
        else
        {
            mdol.id = id;
            new DB6.tblAdvert_Nav_Config().Update(mdol);
            AlertHelper.JQAlertGo("修改成功!", "Advertisemlb.aspx", true);
        }
    }
}