using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Erun360.BLL;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;
public partial class infocenter_ClubInfo : PageBase
{
    public int idRace = 0;
    public int gId = -1;
    public string DiscussList = string.Empty;
    public string Name = string.Empty;
    public string tel = string.Empty;
    public string RaceName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            idRace = TypeChangeDefault.NullToInt(Request.QueryString["id"].ToString(), 0);
            
            if (new DB4.tblRACE_ACTIVITY().Exists(idRace))
            {
                RaceName = new DB4.tblRACE_ACTIVITY().GetcTitle(" and id=" + idRace);
            }
            else
            {
                if (CurrentUser != null)
                {
                    AlertHelper.JQAlertGo("该活动不存在！", UrlHelper.MemberUrl(CurrentUser.uId), false);
                }
                else
                {
                    AlertHelper.JQAlertGo("该活动不存在！", "/", false);
                }
            }            
        }
        if (CurrentUser != null)
        {
            gId = CurrentUser.uId;
            Name = CurrentUser.cName;
            tel = CurrentUser.cMobile;
        }
        pager.RecordCount = new DB3.tblDISCUSS().GetRecordCount("idInfo =" + idRace, idRace);
        Bind();
        
        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);
    }
    /// <summary>
    /// 添加留言
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnDiscuss_Click(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (cContent.Value.Trim().Length <= 0)
        {
            lbtip.InnerText = "留言不能为空";
            return;
        }
        if (CurrentUser != null)
        {
            DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
            DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
            disModel.cLoginname = CurrentUser.cNickName;
            disModel.cContent = cContent.Value.Trim();
            disModel.idInfo = idRace;
            disModel.idUser = CurrentUser.uId;
            disBll.Add(disModel);
        }
        cContent.Value = "";
        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);
        Bind();
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        DiscussList = new Club().GetDiscussList(idRace, pageindex, pagesize);
    }
}