using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using System.Text;
using System.Data;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using System.Text.RegularExpressions;
using Erun360.BLL;
using Utils;

public partial class infocenter_Club : PageBase
{
    public string cTop = string.Empty;
    public string cNotice = string.Empty;
    public string sBackground = string.Empty;
    public string sMemberNew = string.Empty;
    public string sMember = string.Empty;
    public string sAudit = string.Empty;
    public string sBlog = string.Empty;
    public string DiscussList = string.Empty;
    public int ClubId = 0; //600000000;
    public int cId = 0;
    public string cTitle = string.Empty;
    //public int uId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null)
        {
            ClubId = int.Parse(Request.QueryString["id"].ToString());
            DBM4.tblRACE_CLUB mClub = new Erun360.BLL.DB4.tblRACE_CLUB().GetModel(ClubId);
            if (mClub != null)
            {
                cId = (int)mClub.idUser;
                sBackground = mClub.cBackground;
                cTitle = mClub.cTitle;
                if (mClub.iAudit < 0)
                {
                    AlertHelper.JQAlertGo("该俱乐部已关闭！", "/infocenter/SearchClub.aspx", false);
                }
                else if (mClub.iAudit < 3)
                {
                    AlertHelper.JQAlertGo("该俱乐部已禁用或者审核中！", "/infocenter/SearchClub.aspx", false);
                }
            }
        }
        //if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit>2 and idUser=" + CurrentUser.uId) > 0)
        //{
        //    AlertHelper.JQAlertGo("亲，您已经创建了俱乐部", UrlHelper.MemberUrl(CurrentUser.uId), false);
        //}
        //if (new DB4.tblRACE_CLUB().GetRecordCount(" iAudit<=2 and idUser=" + CurrentUser.uId) > 0)
        //{
        //    AlertHelper.JQAlertGo("您已申请，请等待审核！", UrlHelper.MemberUrl(CurrentUser.uId), false);
        //}
        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);
        //if (CurrentUser != null)
        //{
        //    uId = CurrentUser.uId;
        //}
        //DBM4.tblRACE_CLUB model = new DB4.tblRACE_CLUB().GetModel(ClubId);

        //StringBuilder sb = new StringBuilder();
        //StringBuilder sbMemberNew = new StringBuilder();
        //StringBuilder sbMember = new StringBuilder();
        //if (model != null)
        //{
        //    DBM1.tblMEMBER mModel = new DB1.tblMEMBER().GetModelByCache((int)model.idUser);
        //    cTitle = model.cTitle;
        //    if (mModel != null)
        //    {
        //        sb.AppendLine("<img src=\"" + mModel.cAvatar + "\" />");
        //    }
        //    sb.AppendLine("<h1>" + model.cTitle + "</h1>");
        //    //sb.AppendLine("<span>文章：33 | 图片：453 | 活动：2 | 成员：83</span>");
        //    sb.AppendLine("<span>文章：" + new DB4.tblRACE_LINKS().GetBlogCountByCache(ClubId) + " | 成员：" + new DB4.tblRACE_CLUB_MEMBER().GetCountByCache(ClubId) + "</span>");
        //    sb.AppendLine("<p>" + model.cDescription + "</p>");

        //    sAudit = "<a class=\"comec\" href=\"javascript:void(0)\" href=\"../action/ClubList.ashx?idClub=" + ClubId + "&state=" + model.iStates + "\"></a>";
        //    cTop = sb.ToString();
        //    cNotice = model.cNotice;

        //    //sb.AppendLine("");
        //    DataTable dt = new DB4.tblRACE_CLUB_MEMBER().GetList(Convert.ToInt32(model.iMemberLimit), " idClub=" + ClubId + " and iStates=1", " dCreate desc").Tables[0];
        //    int rows = dt.Rows.Count;
        //    if (rows > 0)
        //    {

        //        sBlog = new Club().ToList(ClubId, "22,23", 1, 20);

        //        //pager.RecordCount = 3;

       

        //        DB3.tblATTENTION uAttention = new DB3.tblATTENTION();
        //        for (int i = 0; i < rows; i++)
        //        {
        //            DBM1.tblMEMBER cMember = new DB1.tblMEMBER().GetModelByCache(Convert.ToInt32(dt.Rows[i]["idUser"].ToString()));
        //            if (i <= 3)
        //            {
        //                sbMemberNew.AppendLine("<li>");
        //                sbMemberNew.AppendLine("<a target=\"_blank\" href=\"" + UrlHelper.MemberUrl(cMember.id) + "\">");
        //                sbMemberNew.AppendLine(" <img src=\"" + cMember.cAvatar + "\" />");
        //                sbMemberNew.AppendLine(dt.Rows[i]["cUserName"].ToString() + "</a>");
        //                sbMemberNew.AppendLine("<p>" + cMember.cBio + "</p>");
        //                if (CurrentUser != null)
        //                {
        //                    if (uAttention.Exists("idInfo=" + cMember.id + " and idUser=" + CurrentUser.uId))
        //                    {
        //                        sbMemberNew.Append("\t<td><a class=\"focus-a focus" + i.ToString() + "\">相互关注</a></td>");
        //                    }
        //                    else
        //                    {
        //                        sbMemberNew.AppendLine("<a onclick=\"iFocus(" + cMember.id + ",'focus" + i + "')\" class=\"focus-a focusgz focus" + i + "\" href=\"javascript:\">关注TA</a>");
        //                    }
        //                }
        //                else
        //                {
        //                    sbMemberNew.AppendLine("<a onclick=\"iFocus(" + cMember.id + ",'focus" + i + "')\" class=\"focus-a focusgz focus" + i + "\" href=\"javascript:\">关注TA</a>");
        //                }
        //                sbMemberNew.AppendLine("<a href=\"/infocenter/PostMessage.aspx?uId=" + cMember.id + "\" class=\"focus-b article-up-iframe cboxElement\">给TA留言</a>");
        //                sbMemberNew.AppendLine("</li>");
        //            }
        //            else
        //            {
        //                sbMember.AppendLine("<li>");
        //                sbMember.AppendLine("<a target=\"_blank\" href=\"" + UrlHelper.MemberUrl(cMember.id) + "\">");
        //                sbMember.AppendLine(" <img src=\"" + cMember.cAvatar + "\" />");
        //                sbMember.AppendLine(dt.Rows[i]["cUserName"].ToString() + "</a>");
        //                sbMember.AppendLine("<p>" + cMember.cBio + "</p>");
        //                if (CurrentUser != null)
        //                {
        //                    if (uAttention.Exists("idInfo=" + cMember.id + " and idUser=" + CurrentUser.uId))
        //                    {
        //                        sbMember.Append("\t<td><a class=\"focus-a focus" + i.ToString() + "\">相互关注</a></td>");
        //                    }
        //                    else
        //                    {
        //                        sbMember.AppendLine("<a onclick=\"iFocus(" + cMember.id + ",'focus" + i + "')\" class=\"focus-a focusgz focus" + i + "\" href=\"javascript:\">关注TA</a>");
        //                    }
        //                }
        //                else
        //                {
        //                    sbMember.AppendLine("<a onclick=\"iFocus(" + cMember.id + ",'focus" + i + "')\" class=\"focus-a focusgz focus" + i + "\" href=\"javascript:\">关注TA</a>");
        //                }
        //                sbMember.AppendLine("<a href=\"/infocenter/PostMessage.aspx?uId=" + cMember.id + "\" class=\"focus-b article-up-iframe cboxElement\">给TA留言</a>");
        //                sbMember.AppendLine("</li>");
        //            }

        //        }
        //    }
        //    else
        //    {
        //        sbMemberNew.AppendLine("<li>暂无成员</li>");
        //    }
        //    sMember = sbMemberNew.ToString() + sbMember.ToString();
        //    sMemberNew = sbMemberNew.ToString();
        //}
        pager.RecordCount = new DB3.tblDISCUSS().GetRecordCount("idInfo =" + ClubId, ClubId);
        Bind();
        if (!IsPostBack)
        {
           
        }
    }
    protected void pager_PageChanged(object sender, EventArgs e)
    {
        Bind();
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
            disModel.idInfo = ClubId;
            disModel.idUser = CurrentUser.uId;
            disBll.Add(disModel);
        }
        cContent.Value = "";
        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);
        Bind();
    }
    private void Bind()
    {
        int pagesize = pager.PageSize;
        int pageindex = pager.CurrentPageIndex;
        DiscussList = new Club().GetDiscussList(ClubId, pageindex, pagesize);
    }

}