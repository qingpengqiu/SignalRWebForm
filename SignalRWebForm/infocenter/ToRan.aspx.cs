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
using DB1 = Erun360.BLL.DB1;
using DBM1 = Erun360.Model.DB1;
using DB3 = Erun360.BLL.DB3;
using DBM3 = Erun360.Model.DB3;
using Utils;
using Erun360.BLL;
using System.IO;

public partial class infocenter_ToRan : PageBase
{
    public string iCity = string.Empty;
    public string iArea = string.Empty;
    public int bId = 0;
    public int uId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.page_Title ="发起约跑-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";
  
        if (CurrentUser != null)
        {
            if (CurrentUser.cName.Length <= 0 || CurrentUser.cMobile.Length <= 0 || CurrentUser.cNationID == null)
            {
                AlertHelper.JQAlertGo("您的信息不完善，请完善信息后发布约跑！，", "/infocenter/Account.aspx?uId=" + CurrentUser.uId + "#1", false);
            }
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
       
        if (Request.QueryString["bId"] != null)
        {
            bId = int.Parse(Request.QueryString["bId"].ToString());
        }
        if (!IsPostBack)
        {
            if (0 != bId)
            {
                //iCity = "1";
                //iArea = "01";
                DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(bId);
                if (model != null)
                {
                    if (model.idUser != CurrentUser.uId)
                    {
                        AlertHelper.JQAlertGo("您不能编辑Ta的约跑信息！", UrlHelper.MemberUrl(CurrentUser.uId), false);
                        return;
                    }
                    hdtitle.Value = model.cTitle;
                    cContentUEditor.Value = model.cContent.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                }
                DBM4.tblRACE_ACTIVITY taModel = new DB4.tblRACE_ACTIVITY().GetModelbyidBlog(bId);
                if (taModel != null)
                {
                    hdtype.SelectedIndex = Convert.ToInt32(taModel.idRoadStyle) - 1;
                    hdtime.Value = Convert.ToDateTime(taModel.dOpen.ToString()).ToString("yyyy-MM-dd HH:mm");


                    if (DateTime.Now >= taModel.dJoinEnd)
                    {
                        AlertHelper.JQAlertGo("该活动已结束，您不能进行编辑！！", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    }
                    if (taModel.idCity.ToString().Length == 3)
                    {
                        iCity = taModel.idCity.ToString().Substring(0, 1);
                        iArea = taModel.idCity.ToString().Substring(1, 2);
                    }
                    else if (taModel.idCity.ToString().Length == 4)
                    {
                        iCity = taModel.idCity.ToString().Substring(0, 2);
                        iArea = taModel.idCity.ToString().Substring(2, 2);
                    }

                    cCityname.Value = taModel.cCityname;
                    idCity.Value = taModel.idCity.ToString();
                    hdadd.Value = taModel.cAddress;
                    if (taModel.dCollect.ToString().Length > 0)
                    {
                        hdjime.Value = Convert.ToDateTime(taModel.dCollect.ToString()).ToString("yyyy-MM-dd HH:mm");
                    }
                    else
                    {
                        hdjime.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                    }
                    hdjadd.Value = taModel.cCollectAddress;
                    coordinates.Value = taModel.cPoints;
                    hdatime.Value = Convert.ToDateTime(taModel.dJoinBegin.ToString()).ToString("yyyy-MM-dd HH:mm");
                    hdbtime.Value = Convert.ToDateTime(taModel.dJoinEnd.ToString()).ToString("yyyy-MM-dd HH:mm");
                    if (taModel.iStrength.ToString().Length > 0)
                    {
                        hdqd.SelectedIndex = (int)taModel.iStrength - 1;
                    }
                    else
                    {
                        hdqd.SelectedIndex = 0;
                    }
                    hdallkm.Value = taModel.iDistance.ToString();

                    hdrmb.Value = taModel.iFee.ToString();                  
                    if (taModel.iWinner.ToString().Length > 0)
                    {
                        hdts.SelectedIndex = (int)taModel.iWinner;
                    }
                    else
                    {
                        hdts.SelectedIndex = 0;
                    }
                    hdpeople.Value = taModel.iLimit.ToString();

                    hdtt.Value = taModel.cImage;
                }
                else
                {
                    cCityname.Value = "";
                    idCity.Value = "0";
                    hdpeople.Value = "2";
                    hdrmb.Value = "0";
                    hdallkm.Value = "0";
                }
            }
            else
            {
                cCityname.Value = "";
                idCity.Value = "0";
                hdpeople.Value = "2";
                hdrmb.Value = "0";
                hdallkm.Value = "0";
            }
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
            if (0 > user.idMemberStyle)
            {
                AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
                return;
            }
            if (CurrentUser.idMemberStyle < 6)
            {
                hdjf.Visible = false;
            }
        }
    }

    /// <summary>
    ///  Jquery弹框提示 保存约跑
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnJQbackend_Click(object sender, EventArgs e)
    {
        if (CurrentUser != null)
        {
            if (CurrentUser.cName.Length <= 0 || CurrentUser.cMobile.Length <= 0 || CurrentUser.cNationID == null)
            {
                AlertHelper.JQAlertGo("您的信息不完善，请完善信息后发布约跑！，", "/infocenter/Account.aspx?uId=" + CurrentUser.uId + "#1", false);
            }
        }
        else
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script language='javascript'>PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();</script>");
            return;
        }
        DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
        if (0 > user.idMemberStyle)
        {
            AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
            return;
        }

        //if (CurrentUser.idMemberStyle < 6)
        //{
        //    hdjf.Visible = false;
        //    int count = new DB4.tblRACE_ACTIVITY().GetRecordCount("idUser=" + CurrentUser.uId + " and DateDiff(dd,dCreate,getdate())=0");
        //    if (count >= 2)
        //    {
        //        AlertHelper.JQAlert("每天最多只能发2篇哦！", false);
        //        return;
        //    }
        //}
        DBM4.tblRACE_ACTIVITY mRaceActivity = new DBM4.tblRACE_ACTIVITY();
        if (hdtitle.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写标题！", false);
            return;
        }
        else if (hdtitle.Value.Trim().Length > 60)
        {
            AlertHelper.JQAlert("活动标题超出限制！", false);
            return;
        }
        //if (GCommon.BadLoginname(hdtitle.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("非法内容！");
        //    return;
        //}
        mRaceActivity.cTitle = hdtitle.Value;
        if (hdtype.SelectedIndex == 0)
        {
            AlertHelper.JQAlert("请选择活动类型！", false);
            return;
        }
        mRaceActivity.idRoadStyle = hdtype.SelectedIndex;

        if (hdtime.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择活动时间！", false);
            return;
        }

        mRaceActivity.dOpen = Convert.ToDateTime(hdtime.Value);
        if (idCity.Value.Trim() == "0")
        {
            AlertHelper.JQAlert("请选择活动地点！", false);
            return;
        }
        mRaceActivity.idCity = TypeChangeDefault.NullToInt(idCity.Value, 0);
        if (string.IsNullOrEmpty(cCityname.Value.Trim()))
        {
            AlertHelper.JQAlert("请选择活动地点！", false);
            return;
        }
        mRaceActivity.cCityname = cCityname.Value.Trim();
        if (string.IsNullOrEmpty(hdadd.Value))
        {
            AlertHelper.JQAlert("请填写活动详细地址！", false);
            return;
        }

        mRaceActivity.cAddress = hdadd.Value;
        if (hdjime.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请选择集合时间", false);
            return;
        }
        mRaceActivity.dCollect = Convert.ToDateTime(hdjime.Value);
        if (hdjadd.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填写集合详细地址！", false);
            return;
        }
        mRaceActivity.cCollectAddress = hdjadd.Value;

        mRaceActivity.cPoints = coordinates.Value;//坐标
        if (hdatime.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("选择报名开始时间！", false);
            return;
        }
        mRaceActivity.dJoinBegin = Convert.ToDateTime(hdatime.Value);
        if (hdbtime.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("选择报名结束时间！", false);
            return;
        }
        mRaceActivity.dJoinEnd = Convert.ToDateTime(hdbtime.Value);

        if (Convert.ToDateTime(hdatime.Value) > Convert.ToDateTime(hdbtime.Value))
        {
            AlertHelper.JQAlert("报名开始时间不能小于报名结束时间！", false);
            return;
        }
        if (Convert.ToDateTime(hdtime.Value) < Convert.ToDateTime(hdatime.Value) || Convert.ToDateTime(hdtime.Value) < Convert.ToDateTime(hdbtime.Value))
        {
            AlertHelper.JQAlert("活动时间不能小于报名开始时间和报名结束时间！", false);
            return;
        }
        if (hdqd.SelectedIndex == 0)
        {
            AlertHelper.JQAlert("请选择活动强度！", false);
            return;
        }
        mRaceActivity.iStrength = hdqd.SelectedIndex;
        try
        {
            Convert.ToDecimal(hdallkm.Value);
        }
        catch (Exception)
        {
            AlertHelper.JQAlert("总里程输入错误，请重新输入！", false);
            return;
        }
        mRaceActivity.iDistance = Convert.ToDecimal(hdallkm.Value);
        try
        {
            Convert.ToInt16(hdrmb.Value);
        }
        catch (Exception)
        {
            AlertHelper.JQAlert("活动经费输入错误，请重新输入！", false);
            return;
        }
        if (CurrentUser.idMemberStyle < 6)
        {
            mRaceActivity.iFee = 0;
        }
        else
            mRaceActivity.iFee = Convert.ToInt16(hdrmb.Value);
        //if (hdts.SelectedIndex == 0)
        //{
        //    AlertHelper.JQAlert("请选择活动特色");
        //    return;
        //}
        mRaceActivity.iWinner = hdts.SelectedIndex;

        try
        {
            Convert.ToInt16(hdpeople.Value);
            if (Convert.ToInt32(hdpeople.Value) < 2)
            {
                AlertHelper.JQAlert("报名人数至少2人！", false);
                return;
            }
        }
        catch (Exception)
        {
            AlertHelper.JQAlert("报名人数输入错误，请重新输入！", false);
            return;
        }

        mRaceActivity.iLimit = Convert.ToInt16(hdpeople.Value);

       
     

        mRaceActivity.idUser = CurrentUser.uId;
        if (cContentUEditor.Value.Trim().Length <= 0)
        {
            AlertHelper.JQAlert("请填约跑内容", false);
            return;
        }
        //if (GCommon.BadContent(cContentUEditor.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("非法内容！");
        //    return;
        //}
        //if (GCommon.BadLoginname(cContentUEditor.Value.Trim()))
        //{
        //    AlertHelper.JQAlert("非法内容！");
        //    return;
        //}
        DB4.tblRACE_ACTIVITY uActivety = new DB4.tblRACE_ACTIVITY();
        //插入博客
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        //UserInfoModel model = new UserInfoBll().Find(CurrentUser.uId);
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.cTitle = hdtitle.Value.Trim();
        bModel.cContent = cContentUEditor.Value.Trim();
        BlogInfo uBlog = new BlogInfo();
        int iRaceActivity = 0;
        int idRace = 0;
        try
        {

            if (0 == bId)
            {
                bId = uBlog.Add(bModel);
                mRaceActivity.idBlog = bId;
                iRaceActivity = uActivety.Add(mRaceActivity);//插入约跑
                idRace = iRaceActivity;
                if (iRaceActivity > 0)
                {
                    bModel.idHref = iRaceActivity;
                    bModel.id = bId;
                    //更新约跑id到博客idhref
                    uBlog.Update(bModel);
                }
                //插入积分
                //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
                //uMember_History.Insert(bModel.idUser, 100800113, 1);
                new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810012, 1, 0);

                DBM4.tblRACE_JOIN join = new DBM4.tblRACE_JOIN();
                join.idOnwer = CurrentUser.uId;
                join.idActivity = iRaceActivity;
                join.idUser = CurrentUser.uId;
                join.cLoginname = CurrentUser.cNickName;
                join.cName = CurrentUser.cName;
                join.cTel = CurrentUser.cMobile;
                join.iStatus = 2;
                new DB4.tblRACE_JOIN().Add(join);

            }
            else
            {
                iRaceActivity = idRace;
                DB2.tblBLOG ublog = new DB2.tblBLOG();
                bModel.id = bId;
                ublog.Update(bModel);
                //更新竞赛
                bModel = ublog.GetModel(bId);
                idRace = (int)bModel.idHref;
                mRaceActivity.id = (int)bModel.idHref;
                mRaceActivity.idBlog = bId;
                uActivety.Update(mRaceActivity);

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
            if (!new DB2.tblActivity().Exists(CurrentUser.uId, iRaceActivity))
            {
                //2013-08-19 1关注11用户/12博文/13赛事/14装备，2发布22博文/23赛事/24装备/25训练/26约跑，3评论31留言/32博文/33赛事/34装备/35训练/36约跑
                DBM2.tblActivity mActivity = new DBM2.tblActivity();
                mActivity.idUser = CurrentUser.uId;
                mActivity.cNickName = CurrentUser.cNickName;
                mActivity.cAvatar = CurrentUser.cAvatar;
                mActivity.idBlog = iRaceActivity;
                mActivity.idGroup = "26";
                mActivity.cTitle = bModel.cTitle;
                mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
                mActivity.cImageUrl = thumbnail;
                new DB2.tblActivity().Add(mActivity);
            }
            AlertHelper.JQAlertGo("发布成功", "/race/" + idRace + ".aspx", true);
        }
        catch
        {
            AlertHelper.JQAlert("出错了，请重新提交！", false);
            return;
        }
    }
    private bool UpPhotoSaveAs(HttpPostedFile uploadFile, string Path, string FileName)
    {
        HttpPostedFile face = uploadFile;
        //FileSaveAs picWebService = new FileSaveAs();

        SaveFile.FileSaveAsSoapClient picWebService = new SaveFile.FileSaveAsSoapClient();
        int upPhotoLength = face.ContentLength;
        byte[] PhotoArray = new Byte[upPhotoLength];
        Stream PhotoStream = face.InputStream;
        PhotoStream.Read(PhotoArray, 0, upPhotoLength);
        bool flag = picWebService.UploadFile(PhotoArray, Path, FileName);
        face.InputStream.Close();
        return flag;
    }
}