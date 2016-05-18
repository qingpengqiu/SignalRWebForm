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
using Utils;
public partial class infocenter_singleEquip : PageBase
{
    public string fullText = string.Empty;
    public int uId = 0;//通过参数传递过来的用户id
    public int bId = 0;//通过参数传递过来的用户id
    public string Previous = string.Empty;
    public string Next = string.Empty;
    public string DiscussList = string.Empty;
    //0  博文Blog.aspx，5装备Equip，3 赛事Competition   
    public string StyleLeft = string.Empty;
    public int cId = 0;
    protected string classify = string.Empty;
    public string m_title = string.Empty;
    public string m_nav = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (Request.QueryString["bId"] != null)
        {
            bId = int.Parse(Request.QueryString["bId"].ToString());
            DBM2.tblBLOG mBlog = new DB2.tblBLOG().GetModelByCache(bId);
            if (mBlog != null)
            {
                uId = mBlog.idUser;
                m_title = mBlog.cTitle;

                classify = mBlog.idHref.ToString().Substring(0, 1);
                if (classify == "0")
                {
                    StyleLeft = ".main-left ul .left1 img{filter: alpha(Opacity=100);-moz-opacity: 1; opacity: 1;}  .main-left ul .left1 a {color: #693f69; }";
                    m_nav += "博客";
                }
                else if (classify == "5")
                {
                    StyleLeft = ".main-left ul .left4 img {filter: alpha(Opacity=100); -moz-opacity: 1; opacity: 1; } .main-left ul .left4 a {  color: #693f69; }";
                    m_nav += "装备";
                }
                else if (classify == "3")
                {
                    StyleLeft = ".main-left ul .left6 img {filter: alpha(Opacity=100);-moz-opacity: 1;opacity: 1;}.main-left ul .left6 a {color: #693f69;}";
                    m_nav += "赛事";
                }
                else if (classify == "4")
                {
                    StyleLeft = ".main-left ul .left3 img {filter: alpha(Opacity=100);-moz-opacity: 1;opacity: 1;}.main-left ul .left3 a {color: #693f69;}";
                    m_nav += "约跑";
                }
            }
            else
            {
                AlertHelper.JQAlertGo("该博文不存在或者已删除！，", "/", false);
                return;
            }
        }
        else
        {
            AlertHelper.JQAlertGo("该博文不存在或者已删除！，", "/", false);
            return;
        }

        ScriptManager.RegisterStartupScript(btnDiscuss, this.GetType(), "alert", "<script type=\"text/javascript\"> $('#text').emotions();</script>", false);

        if (CurrentUser != null)
        {
            cId = CurrentUser.uId;
            if (0 != bId)
            {
                DB2.tblBLOG_SUMMARY uBlog_Summary = new DB2.tblBLOG_SUMMARY();
                DBM2.tblBLOG_SUMMARY mBlog_Summary = new DBM2.tblBLOG_SUMMARY();
                mBlog_Summary = uBlog_Summary.GetModel(bId);
                if (mBlog_Summary != null)
                {
                    mBlog_Summary.idBlog = bId;
                    mBlog_Summary.iShowTimes = mBlog_Summary.iShowTimes + 1;
                    uBlog_Summary.Update(mBlog_Summary);

                    mBlog_Summary = uBlog_Summary.GetModelByCache(bId);
                    mBlog_Summary.iShowTimes = mBlog_Summary.iShowTimes + 1;
                }
            }
            BlogInfo bInfo = new BlogInfo();
            fullText = bInfo.GetSingleBolgInfo(CurrentUser.uId, uId, bId, classify);

            Previous = bInfo.Previous(uId, bId, classify);
            Next = bInfo.Next(uId, bId, classify);
            DiscussList = bInfo.GetDiscussList(CurrentUser.uId, bId);
        }
        else
        {
            if (0 != bId)
            {

                DB2.tblBLOG_SUMMARY uBlog_Summary = new DB2.tblBLOG_SUMMARY();
                DBM2.tblBLOG_SUMMARY mBlog_Summary = new DBM2.tblBLOG_SUMMARY();
                mBlog_Summary = uBlog_Summary.GetModel(bId);
                if (mBlog_Summary != null)
                {
                    mBlog_Summary.idBlog = bId;
                    mBlog_Summary.iShowTimes = mBlog_Summary.iShowTimes + 1;
                    uBlog_Summary.Update(mBlog_Summary);

                    mBlog_Summary = uBlog_Summary.GetModelByCache(bId);
                    mBlog_Summary.iShowTimes = mBlog_Summary.iShowTimes + 1;
                }
            }
            BlogInfo bInfo = new BlogInfo();
            fullText = bInfo.GetSingleBolgInfo(0, uId, bId, classify);

            Previous = bInfo.Previous(uId, bId, classify);
            Next = bInfo.Next(uId, bId, classify);
            DiscussList = bInfo.GetDiscussList(0, bId);
        }
        if (CurrentUser != null)
        {
            string itype = string.Empty;
            if (classify == "0")
            {
                itype = "32";
            }
            else if (classify == "5")
            {
                itype = "34";
            }
            else if (classify == "3")
            {
                itype = "33";
            }
            else if (classify == "4")
            {
                itype = "36";
            }
            else
            {
                itype = "0";
            }
            new DB3.tblMessage().DeleteMsg(" bId=" + bId + " and itype=" + itype + " and uId=" + CurrentUser.uId);
            new DB3.tblMessage().DeleteMsg(" bId=" + bId + " and itype=37 and uId=" + CurrentUser.uId);
        }
        if (!IsPostBack)
        {

        }
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

                DBM3.tblDISCUSS disModel = new DBM3.tblDISCUSS();
                DB3.tblDISCUSS disBll = new DB3.tblDISCUSS();
                disModel.cLoginname = CurrentUser.cNickName;
                disModel.cContent = cContent.Value.Trim();
                disModel.idInfo = bId;
                disModel.idUser = CurrentUser.uId;
                //disModel.dCreate = DateTime.Now;
                //disBll.Add(disModel);
                int imessage = disBll.Add(disModel);

                DB1.tblMEMBER_SUMMARY msbll = new DB1.tblMEMBER_SUMMARY();
                DBM1.tblMEMBER_SUMMARY msModel = new DBM1.tblMEMBER_SUMMARY();
                msModel = msbll.GetModel(CurrentUser.uId);
                msModel.idUser = CurrentUser.uId;
                msModel.iScore = msModel.iScore + 1;
                msModel.iDiscuss = msModel.iDiscuss + 1;
                msbll.Update(msModel);
                //插入积分
                DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                uMember_History.Insert(CurrentUser.uId, 100800109, 1);

                //更新博客数量
                DB2.tblBLOG_SUMMARY bsbll = new DB2.tblBLOG_SUMMARY();
                DBM2.tblBLOG_SUMMARY bsModel = new DBM2.tblBLOG_SUMMARY();
                bsModel = bsbll.GetModel(bId);
                bsModel.idBlog = bId;
                bsModel.iDiscuss = bsModel.iDiscuss + 1;
                bsbll.Update(bsModel);

                if (bsModel != null)
                {
                    string CacheKey = "tblBLOG_SUMMARYModel-" + bId;
                    bsModel = bsbll.GetModel(bId);
                    int ModelCache = Erun360.Common.ConfigHelper.GetConfigInt("ModelCache");
                    Erun360.Common.DataCache.SetCache(CacheKey, bsModel, DateTime.Now.AddMinutes(ModelCache), TimeSpan.Zero);
                }

                BlogInfo bInfo = new BlogInfo();
                DiscussList = bInfo.GetDiscussList(CurrentUser.uId, bId);
                cId = CurrentUser.uId;
                //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练/26约跑，3评论31留言/32博文/33赛事/34装备/35训练/36约跑
                DBM2.tblActivity mActivity = new DBM2.tblActivity();
                mActivity.idUser = CurrentUser.uId;
                mActivity.cNickName = CurrentUser.cNickName;
                mActivity.cAvatar = CurrentUser.cAvatar;
                mActivity.idBlog = bId;
                if (classify == "0")
                {
                    mActivity.idGroup = "32";
                }
                else if (classify == "5")
                {
                    mActivity.idGroup = "34";
                }
                else if (classify == "3")
                {
                    mActivity.idGroup = "33";
                }
                else if (classify == "4")
                {
                    mActivity.idGroup = "36";
                }
                else
                {
                    mActivity.idGroup = "0";
                }
                mActivity.cTitle = new DB2.tblBLOG().GetModelByCache(bId).cTitle;
                mActivity.cBio = cContent.Value.Trim();
                new DB2.tblActivity().Add(mActivity);
                if (CurrentUser.uId != uId)
                {
                    DBM3.tblMessage mMessage = new DBM3.tblMessage();
                    mMessage.cId = CurrentUser.uId;
                    mMessage.uId = uId;
                    mMessage.itype = int.Parse(mActivity.idGroup);
                    mMessage.bId = bId;
                    mMessage.idcode = imessage;
                    new DB3.tblMessage().Add(mMessage);
                }
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