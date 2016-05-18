using System;
using System.Data;
using System.Web.UI;
using Erun360.BLL;
using Erun360.Model;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DB4 = Erun360.BLL.DB4;
using DBM4 = Erun360.Model.DB4;
using Utils;

public partial class infocenter_PostEvent : PageBase
{
    private int uId = 0;
    public int bId = 0;
    public string iCity = string.Empty;
    public string iArea = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        if (Request.QueryString["uId"] != null)
        {
            uId = int.Parse(Request.QueryString["uId"].ToString());
        }
        if (CurrentUser.uId != uId)
        {
            AlertHelper.JQAlertGo("您不能编辑Ta的赛事", UrlHelper.MemberUrl(CurrentUser.uId), false);
        }
        if (Request.QueryString["bId"] != null)
        {
            bId = int.Parse(Request.QueryString["bId"].ToString());
        }
        if (!IsPostBack)
        {
            if (CurrentUser != null)
            {
                if (0 != bId)
                {
                    DBM4.tblRACE_COMPETETION mCompetetion = new DB4.tblRACE_COMPETETION().GetModelByIdBlog(bId);
                    DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(bId);
                    if (model != null && mCompetetion != null)
                    {
                        title.Value = mCompetetion.cTitle;
                        idCompeteStyle.Value =mCompetetion.idCompeteStyle.ToString();
                        if (mCompetetion.idCity.ToString().Length == 3)
                        {
                            iCity = mCompetetion.idCity.ToString().Substring(0, 1);
                            iArea = mCompetetion.idCity.ToString().Substring(1, 2);
                        }
                        else if (mCompetetion.idCity.ToString().Length == 4)
                        {
                            iCity = mCompetetion.idCity.ToString().Substring(0, 2);
                            iArea = mCompetetion.idCity.ToString().Substring(2, 2);
                        }
                        idCity.Value = mCompetetion.idCity.ToString();
                        cCityname.Value = mCompetetion.cCityname;
                        dRaceBegin.Value = Convert.ToDateTime(mCompetetion.dRaceBegin).ToString("yyyy-MM-dd");
                        dRaceEnd.Value = Convert.ToDateTime(mCompetetion.dRaceEnd).ToString("yyyy-MM-dd");
                        dJoinBegin.Value = Convert.ToDateTime(mCompetetion.dJoinBegin).ToString("yyyy-MM-dd HH:mm");
                        dJoinEnd.Value = Convert.ToDateTime(mCompetetion.dJoinEnd).ToString("yyyy-MM-dd HH:mm");

                        cContentUEditor.Value = model.cContent.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                    }
                    else
                    {
                        AlertHelper.JQAlertGo("该赛事不存在或者已删除,不能进行编辑", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    }
                }
                else
                {
                    idCity.Value="0";
                    cCityname.Value = "";
                    dRaceBegin.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
                    dRaceEnd.Value = string.Format("{0:yyyy-MM-dd}", DateTime.Now);
                    dJoinBegin.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                    dJoinEnd.Value = string.Format("{0:yyyy-MM-dd HH:mm}", DateTime.Now);
                }
            }
        }
    }
    //保存装备
    protected void imgbtCompetetion_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM4.tblRACE_COMPETETION mCompetetion = new DBM4.tblRACE_COMPETETION();      
        if (this.title.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("赛事名称不能为空！", false);
            return;
        }
        else if (this.title.Value.Trim().Length > 60)
        {
            AlertHelper.JQAlert("赛事名称超过30个汉字的限制！", false);
            return;
        }
        if (idCompeteStyle.SelectedIndex ==0)
        {
            AlertHelper.JQAlert("请选择竞赛类型！", false);
            return;
        }
        mCompetetion.idCompeteStyle = Convert.ToInt32(idCompeteStyle.Value);
        if (idCity.Value.Trim() == "0")
        {
            AlertHelper.JQAlert("请选择所在城市！", false);
            return;
        }
        mCompetetion.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
      
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            AlertHelper.JQAlert("请选择所在城市！", false);
            return;
        }
        mCompetetion.cCityname = XString.SqlSafe(TypeChangeDefault.NullToString(cCityname.Value.Trim(), ""));
        
        if (dRaceBegin.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择赛事开始时间！", false);
            return;
        }
        mCompetetion.dRaceBegin = Convert.ToDateTime(dRaceBegin.Value);
       
        if (dRaceEnd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择赛事结束时间！", false);
            return;
        }
        mCompetetion.dRaceEnd = Convert.ToDateTime(dRaceEnd.Value);
        if (Convert.ToDateTime(dRaceBegin.Value.Trim()) > Convert.ToDateTime(dRaceEnd.Value.Trim()))
        {
            AlertHelper.JQAlert("赛事开始时间不能大于结束时间！", false);
            return;
        }
        if (dJoinBegin.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择开始报名时间！", false);
            return;
        }
        mCompetetion.dJoinBegin = Convert.ToDateTime(dJoinBegin.Value);
      
        if (dJoinEnd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择结束报名时间！", false);
            return;
        }
        mCompetetion.dJoinEnd = Convert.ToDateTime(dJoinEnd.Value);
        if (Convert.ToDateTime(dJoinBegin.Value.Trim()) > Convert.ToDateTime(dJoinEnd.Value.Trim()))
        {
            AlertHelper.JQAlert("开始报名时间不能大于结束报名时间！", false);
            return;
        }
        if (Convert.ToDateTime(dJoinEnd.Value.Trim()) > Convert.ToDateTime(dRaceBegin.Value.Trim()))
        {
            AlertHelper.JQAlert("报名结束时间不能大于赛事开始时间！", false);
            return;
        }
        if (this.cContentUEditor.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("赛事简介不能为空！", false);
            return;
        }
        //插入博客
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        //UserInfoModel model = new UserInfoBll().Find(CurrentUser.uId);
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.idHref = 0;
        bModel.cTitle = title.Value.Trim();
        bModel.cContent = cContentUEditor.Value.Trim();
        BlogInfo uBlog = new BlogInfo();

        CompetetionInfo uCompetetion = new CompetetionInfo();
        mCompetetion.cTitle = title.Value.Trim();

        if (0 == bId)
        {
            bId = uBlog.Add(bModel);
            //插入积分
            DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            uMember_History.Insert(bModel.idUser, 100800119, 1);
            //插入竞赛 
            mCompetetion.idBlog = bId;
            uCompetetion.Add(mCompetetion);
        }
        else
        {
            DB2.tblBLOG ublog = new DB2.tblBLOG();
            bModel.id = bId;
            ublog.Update(bModel);
            //更新竞赛
            bModel = ublog.GetModel(bId);
            mCompetetion.id = (int)bModel.idHref;
            mCompetetion.idBlog = bId;
            uCompetetion.Update(mCompetetion);
        }

        DB3.tblIMAGES imgBll = new DB3.tblIMAGES();
        DBM3.tblIMAGES imgModel = new DBM3.tblIMAGES();
        //删除原来博客图片
        imgBll.DeleteByIdBlog(bId);
        BlogInfo ucBlog = new BlogInfo();
        //插入图片
        string thumbnail = string.Empty;//缩略图

        string[] ImgList = ucBlog.GetHtmlImageUrlList(bModel.cContent);
        if (ImgList.Length > 0)
        {
            thumbnail = ImgList[0];
            for (int i = 0; i < ImgList.Length; i++)
            {
                imgModel.idUser = CurrentUser.uId;
                imgModel.idInfo = bId;
                imgModel.cImageUrl = ImgList[i];
                imgModel.cThumbUrl = ImgList[i];
                imgModel.dCreate = DateTime.Now;
                imgBll.Add(imgModel);
            }
        }
        if (!new DB2.tblActivity().Exists(CurrentUser.uId, bId))
        {
            //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练，3评论31留言/32博文/33赛事/34/装备
            DBM2.tblActivity mActivity = new DBM2.tblActivity();
            mActivity.idUser = CurrentUser.uId;
            mActivity.cNickName = CurrentUser.cNickName;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = bId;
            mActivity.idGroup = "23";
            mActivity.cTitle = bModel.cTitle;
            mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
            mActivity.cImageUrl = thumbnail;
            new DB2.tblActivity().Add(mActivity);
        }
        Erun360.Common.DataCache.RemoveAllCache("tblRACE_COMPETETIONM");
        AlertHelper.JQAlertGo("发布成功", "/blog/" + bId + ".aspx", true);
    }
}

