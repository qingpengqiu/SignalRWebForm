using Erun360.BLL;
using Erun360.Model;
using System;
using System.Data;
using System.Web.UI;
using Utils;
using DB1 = Erun360.BLL.DB1;
using DB2 = Erun360.BLL.DB2;
using DB3 = Erun360.BLL.DB3;
using DB5 = Erun360.BLL.DB5;
using DBM2 = Erun360.Model.DB2;
using DBM3 = Erun360.Model.DB3;
using DBM5 = Erun360.Model.DB5;
using DBM1 = Erun360.Model.DB1;

public partial class infocenter_PostEquip : PageBase
{
    private int uId = 0;
    public int bId = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser == null)
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
                DBM5.tblPRODUCTS mProduct = new DB5.tblPRODUCTS().GetModelByidBlog(bId);
                DBM2.tblBLOG model = new DB2.tblBLOG().GetModel(bId);
                if (model != null && mProduct != null)
                {
                    if (model.idUser != CurrentUser.uId)
                    {
                        AlertHelper.JQAlertGo("你不能修改Ta的装备！", UrlHelper.MemberUrl(CurrentUser.uId), false);
                        return;
                    }
                    title.Value = mProduct.cTitle;
                    price.Value = mProduct.fPrice.ToString();
                    buytime.Value = TypeChangeDefault.NullToDateTime(mProduct.dBuytime, DateTime.Now).ToString("yyyy-MM-dd");
                    content.Value = model.cContent.Replace("[IMG]", "<img src=\"").Replace("[/IMG]", "\"/>");
                }
                else
                {
                    AlertHelper.JQAlertGo("该装备不存在或者已删除,不能进行编辑", UrlHelper.MemberUrl(CurrentUser.uId), false);
                    return;
                }
            }
            DBM1.tblMEMBER user = new DB1.tblMEMBER().GetModel(CurrentUser.uId);
            if (0 > user.idMemberStyle)
            {
                AlertHelper.JQAlertGo("你的账号已被限制！！！", "/Member/Logout.aspx", false);
                return;
            }
        }
        this.page_Title ="发装备-中国领先的跑步门户网站-ERUN360.COM";
        this.page_Keywords = "跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒";
        this.page_Description = "中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。";

    }


    //保存装备
    protected void imgbtEquip_Click(object sender, ImageClickEventArgs e)
    {
        if (CurrentUser == null)
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
        if (CurrentUser.idMemberStyle < 6)
        {
            int count = new DB5.tblPRODUCTS().GetRecordCount("idUser=" + CurrentUser.uId + " and DateDiff(dd,dCreate,getdate())=0");
            if (count >= 10)
            {
                AlertHelper.JQAlert("每天最多只能发10篇哦！", false);
                return;
            }
        }
        if (this.title.Value.Trim().Length <= 0 || this.title.Value.Trim().Length > 60)
        {
            AlertHelper.JQAlert("装备名称不能为空！", false);
            return;
        }       
        if (this.price.Value.Trim().Length <= 0 || this.price.Value.Trim().Length > 8)
        {
            AlertHelper.JQAlert("请输入价格！", false);
            return;
        }
        if (this.content.Value.Trim().Length <= 0 || this.content.Value.Trim().Length > 4000)
        {
            AlertHelper.JQAlert("装备简介不能为空！", false);          
            return;
        }

        //插入博客
        DBM2.tblBLOG bModel = new DBM2.tblBLOG();
        //UserInfoModel model = new UserInfoBll().Find(CurrentUser.uId);
        bModel.idUser = CurrentUser.uId;
        bModel.cLoginname = CurrentUser.cNickName;
        bModel.idHref = 0;
        bModel.cTitle = title.Value.Trim();
        bModel.cContent = content.Value.Trim();
        BlogInfo uBlog = new BlogInfo();
        //DB2.tblBLOG ublog = new DB2.tblBLOG();

        EquipInfo uProduct = new EquipInfo();
        DBM5.tblPRODUCTS mProduct = new DBM5.tblPRODUCTS();

        mProduct.cTitle = title.Value.Trim();
        mProduct.fPrice = decimal.Parse(price.Value.Trim().ToString());
        mProduct.idUser = CurrentUser.uId;
        mProduct.dBuytime = TypeChangeDefault.NullToDateTime(buytime.Value, DateTime.Now); 
        if (0 == bId)
        {
            //bModel.idUser = PageBase.cId;
            // bId = ublog.Insert(bModel);
            bId = uBlog.Add(bModel);
            //插入积分
            //DB1.tblMEMBER_HISTORY uMember_History = new DB1.tblMEMBER_HISTORY();
            //uMember_History.Insert(bModel.idUser, 100800119, 1);
            new DB1.tblIntegral().InsertScore(CurrentUser.uId, 200810011, 1, 0, 1);
            //插入装备            

            mProduct.idBlog = bId;
            uProduct.Add(mProduct);
        }
        else
        {
            DB2.tblBLOG ublog = new DB2.tblBLOG();
            bModel.id = bId;
            ublog.Update(bModel);
            //更新装备
            bModel = ublog.GetModel(bId);
            mProduct.id = (int)bModel.idHref;
            mProduct.idBlog = bId;
            uProduct.Update(mProduct);
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
            mActivity.idUser = bModel.idUser;
            mActivity.cNickName = bModel.cLoginname;
            mActivity.cAvatar = CurrentUser.cAvatar;
            mActivity.idBlog = bId;
            mActivity.idGroup = "24";
            mActivity.cTitle = bModel.cTitle;
            mActivity.cBio = XString.ContentTrunc(HTMLHelper.NoHTML(bModel.cContent), 250).Trim();
            mActivity.cImageUrl = thumbnail;
            new DB2.tblActivity().Add(mActivity);
        }
        AlertHelper.JQAlertGo("发布成功", "/blog/" + bId + ".aspx", true);
    }
}