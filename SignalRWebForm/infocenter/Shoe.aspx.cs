using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB2 = Erun360.BLL.DB2;
using DBM2 = Erun360.Model.DB2;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using System.Text;
using DB5 = Erun360.BLL.DB5;
using DBM5 = Erun360.Model.DB5;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json;
public partial class infocenter_Shoe : PageBase
{
    public int uId = 0;//通过参数传递过来的用户id
    public int cId = 0;
    public int bId = 0;//通过参数传递过来的用户id
    public string DiscussList = string.Empty;
    public string ctitle = string.Empty;
    public string Result = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            bId = TypeChangeDefault.NullToInt(Request.QueryString["id"].ToString(), 0);
        }
        
        BlogInfo bInfo = new BlogInfo();
        if (!IsPostBack)
        { 
            DBM5.tblShoes mShoe = new DB5.tblShoes().GetModel(bId);
            if (mShoe != null)
            {
                ctitle = mShoe.cName;
                IsoDateTimeConverter iso = new IsoDateTimeConverter();
                iso.DateTimeFormat = "yyyy-MM-dd";
                Result = JsonConvert.SerializeObject(mShoe, iso);
            }
            if (CurrentUser != null)
            {
                cId = CurrentUser.uId;
                DiscussList = bInfo.GetDiscussList(CurrentUser.uId, bId);
                new DB3.tblMessage().DeleteMsg(" bId=" + bId + " and itype=38 and uId=" + CurrentUser.uId);
            }
            else
            {
                DiscussList = bInfo.GetDiscussList(0, bId);
            }
        }

        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);
      
    }
    //提交评论
    protected void btnDiscuss_Click(object sender, EventArgs e)
    {
        if (cContent.Value.Trim().Length <= 0)
        {
            lbtip.Text = "评论内容不能为空";
        }
        else
        {
            if (CurrentUser != null)
            {
                //UserInfoBll uClient = new UserInfoBll();
                //UserInfoModel uModel = uClient.Find(CurrentUser.uId);
                if (bId == 0)
                {
                    lbtip.Text = "没有id，请检查链接";
                    return; }
                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                disModel.cLoginname = CurrentUser.cNickName;
                disModel.cContent = cContent.Value.Trim();
                disModel.idInfo = bId;
                disModel.idUser = CurrentUser.uId;              
                int imessage = disBll.Add(disModel);
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810013, 1, 0, 1);
                BlogInfo bInfo = new BlogInfo();
                DiscussList = bInfo.GetDiscussList(CurrentUser.uId, bId);
               
                cContent.Value = "";
                lbtip.Text = "";
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>jQuery(document).ready(function($) {window.onload=tips('您还没有登录，请登陆！','../Member/Logout.aspx','false');});</script>");
                // return;
                //Response.Redirect("../Member/Logout.aspx", true);
            }
        }
    }
}